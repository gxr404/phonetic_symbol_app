
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/widgets/app_drawer/app_drawer.dart';
import 'package:phonetic_symbol_app/routing/router.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

@RoutePage()
class MainPage extends ConsumerWidget {
  final CircularBottomNavigationController _navigationController;
  MainPage({super.key}):
    _navigationController = CircularBottomNavigationController(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final settings = ref.watch(settingsNotifierProvider);
    final c = Theme.of(context).colorScheme;
    final List<TabItem> tabItems = List.of([
      TabItem(
        Icons.volume_up,
        '发音',
        c.onPrimary,
        labelStyle: TextStyle(color: c.onPrimary, fontWeight: FontWeight.bold),
      ),
      TabItem(
        Icons.library_books,
        "文档",
        c.onPrimary,
        labelStyle: TextStyle(color: c.onPrimary, fontWeight: FontWeight.bold)
      ),
    ]);
    return AutoTabsRouter.pageView(
      homeIndex: 0,
      routes: [
        PhoneticRoute(),
        DocsRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        _navigationController.value = tabsRouter.activeIndex;
        return Scaffold(
          appBar: AppBar(
            title: Text('Phonetic', textAlign: .center),
            centerTitle: true,
            titleTextStyle: TextStyle(color: c.onPrimary, fontSize: 20),
            backgroundColor: c.primary,
          ),
          body: Stack(
            children: [
              // 页面内容
              SafeArea(
                bottom: false,
                child: child,
              ),
              // BottomNavigation 覆盖在 body 上
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Stack(
                  children: [
                    // 只负责 Android 系统底部区域
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: MediaQuery.viewPaddingOf(context).bottom,
                      child: ColoredBox(
                        color: c.primary
                      ),
                    ),
                    SafeArea(
                      top: false,
                      child: CircularBottomNavigation(
                        tabItems,
                        controller: _navigationController,
                        backgroundBoxShadow: <BoxShadow>[],
                        iconsSize: 22,
                        circleSize: 50,
                        circleStrokeWidth: 6,
                        selectedIconColor: c.primary,
                        normalIconColor: c.onPrimary,
                        barBackgroundColor: c.primary,
                        // barBackgroundColor: Colors.transparent,
                        animationDuration: Duration(milliseconds: 280),
                        selectedCallback: (index) {
                          print('index = $index');
                          print('type = ${index.runtimeType}');
                          tabsRouter.setActiveIndex(index ?? 0);
                        },
                      )
                    ),
                  ]
                )
              )
            ],
          ),
          drawerEnableOpenDragGesture: true,
          drawer: SafeArea(
            child: AppDrawer()
          ),
        );
      }
    );
  }
}