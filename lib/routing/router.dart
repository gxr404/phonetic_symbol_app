import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:phonetic_symbol_app/models/doc.model.dart';
import 'package:phonetic_symbol_app/pages/docs/docs_page.dart';
import 'package:phonetic_symbol_app/pages/docs/markdown_page.dart';
import 'package:phonetic_symbol_app/pages/phonetic_page.dart';
import 'package:phonetic_symbol_app/pages/main_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {

  // 定义了一个只读属性 defaultRouteType，每次访问它时都会返回一个 RouteType.material()
  // Material 风格的页面切换动画
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: MainRoute.page,
      children: [
        AutoRoute(
          path: 'phonetic',
          page: PhoneticRoute.page
        ),
        AutoRoute(
          path: 'docs',
          page: DocsRoute.page,

        ),
      ]
    ),
    AutoRoute(
      page: MarkdownRoute.page,
    ),
  ];

  @override
  List<AutoRouteGuard> get guards => [
  ];
}
