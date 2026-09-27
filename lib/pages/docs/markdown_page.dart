import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/models/doc.model.dart';
import 'package:phonetic_symbol_app/repositories/docs.repository.dart';


@RoutePage()
class MarkdownPage extends ConsumerWidget {
  const MarkdownPage({
    super.key,
    required this.doc,
  });

  final DocItem doc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doc.title),
      ),
      body: FutureBuilder(
        future: ref.read(docsRepositoryProvider).loadContent(doc),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('加载失败：${snapshot.error}'),
            );
          }

          return Markdown(
            data: snapshot.data!,
            // onTapLink: (String text, String? href, String title) {
            //   if (href != null) {
            //     launchUrl(Uri.parse(href));
            //   }
            // },
          );
        },
      ),
    );
  }
}