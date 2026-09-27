import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/models/doc.model.dart';

class DocsRepository {
  const DocsRepository();
  static const _root = 'assets/docs/';

  Future<List<DocItem>> loadDocs() async {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final paths = manifest
        .listAssets()
        .where(
          (path) =>
              path.startsWith(_root) && path.toLowerCase().endsWith('.md'),
        )
        .toList();
    final docs = <DocItem>[];

    for (final path in paths) {
      final relativePath = path.substring(_root.length);
      final parts = relativePath.split('/');
      final category = parts.length > 1 ? parts.first : 'other';
      final content = await rootBundle.loadString(path);
      final title =
          _parseTitle(content) ?? parts.last.replaceFirst(RegExp(r'\.md$'), '');

      docs.add(DocItem(path: path, title: title, category: category));
    }

    return docs;
  }

  String? _parseTitle(String content) {
    for (final line in content.split('\n')) {
      final match = RegExp(r'^#\s+(.+)$').firstMatch(line.trim());
      if (match != null) {
        return match.group(1);
      }
    }
    return null;
  }

  Future<String> loadContent(DocItem doc) {
    return rootBundle.loadString(doc.path);
  }
}

final docsRepositoryProvider = Provider<DocsRepository>(
  (ref) => const DocsRepository(),
);
