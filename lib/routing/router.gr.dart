// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [DocsPage]
class DocsRoute extends PageRouteInfo<void> {
  const DocsRoute({List<PageRouteInfo>? children})
    : super(DocsRoute.name, initialChildren: children);

  static const String name = 'DocsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DocsPage();
    },
  );
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<MainRouteArgs> {
  MainRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        MainRoute.name,
        args: MainRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainRouteArgs>(
        orElse: () => const MainRouteArgs(),
      );
      return MainPage(key: args.key);
    },
  );
}

class MainRouteArgs {
  const MainRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MainRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [MarkdownPage]
class MarkdownRoute extends PageRouteInfo<MarkdownRouteArgs> {
  MarkdownRoute({Key? key, required DocItem doc, List<PageRouteInfo>? children})
    : super(
        MarkdownRoute.name,
        args: MarkdownRouteArgs(key: key, doc: doc),
        initialChildren: children,
      );

  static const String name = 'MarkdownRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MarkdownRouteArgs>();
      return MarkdownPage(key: args.key, doc: args.doc);
    },
  );
}

class MarkdownRouteArgs {
  const MarkdownRouteArgs({this.key, required this.doc});

  final Key? key;

  final DocItem doc;

  @override
  String toString() {
    return 'MarkdownRouteArgs{key: $key, doc: $doc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MarkdownRouteArgs) return false;
    return key == other.key && doc == other.doc;
  }

  @override
  int get hashCode => key.hashCode ^ doc.hashCode;
}

/// generated route for
/// [PhoneticPage]
class PhoneticRoute extends PageRouteInfo<void> {
  const PhoneticRoute({List<PageRouteInfo>? children})
    : super(PhoneticRoute.name, initialChildren: children);

  static const String name = 'PhoneticRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PhoneticPage();
    },
  );
}
