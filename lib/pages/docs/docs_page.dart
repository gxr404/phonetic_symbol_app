import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/models/doc.model.dart';
import 'package:phonetic_symbol_app/providers/docs.provider.dart';
import 'package:phonetic_symbol_app/routing/router.dart';

@RoutePage()
class DocsPage extends ConsumerWidget {
  const DocsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docs = ref.watch(docsProvider);
    print(docs);
    return docs.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('加载失败：$error')),
      data: (items) {
        return _DocsList(items: items);
      },
    );
  }
}

class _DocsList extends StatelessWidget {
  const _DocsList({required this.items});

  final List<DocItem> items;

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<DocItem>>{};
    final c = Theme.of(context).colorScheme;

    for (final item in items) {
      groups.putIfAbsent(item.category, () => []).add(item);
    }

    return ListView(
      // padding: .symmetric(vertical: 16),
      children: [
        for (final entry in groups.entries) ...[
          const SizedBox(height: 12),
          ListTile(
            minTileHeight: 42,
            title: Text(getPhoneticTypeName(entry.key)),
            titleTextStyle: TextStyle(
              fontWeight: .bold,
              fontSize: 20,
              color: c.onSurface,
            ),
            enabled: true,
          ),

          for (final doc in entry.value)
            ListTile(
              trailing: const Icon(Icons.chevron_right, size: 18),
              minTileHeight: 38,
              title: Row(
                children: [
                  const Icon(Icons.description_outlined, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      doc.title,
                      style: TextStyle(fontSize: 14, color: c.onSecondary),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              contentPadding: .only(left: 24, right: 14),
              onTap: () {
                // 跳转
                context.router.push(MarkdownRoute(doc: doc));
              },
            ),
        ],
      ],
    );
  }

  String getPhoneticTypeName(String value) {
    return switch (value) {
      'grammar' => '语法',
      'common_sense' => '常识',
      'pronounce' => '发音',
      _ => value,
    };
  }
}
