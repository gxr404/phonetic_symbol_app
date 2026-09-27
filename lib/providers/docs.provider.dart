import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/models/doc.model.dart';
import 'package:phonetic_symbol_app/repositories/docs.repository.dart';

final docsProvider =
    AsyncNotifierProvider<DocsNotifier, List<DocItem>>(
  DocsNotifier.new,
);

class DocsNotifier extends AsyncNotifier<List<DocItem>> {
  late final DocsRepository _repository;

  @override
  Future<List<DocItem>> build() {
    _repository = ref.watch(docsRepositoryProvider);

    return _repository.loadDocs();
  }
}