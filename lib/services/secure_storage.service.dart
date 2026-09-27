import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider(
  (ref) => SecureStorageService(),
);

class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService():
    _secureStorage = FlutterSecureStorage();

  Future<void> write(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }

  Future<void> delete(String key) {
    return _secureStorage.delete(key: key);
  }

  Future<String?> read(String key) {
    return _secureStorage.read(key: key);
  }
}
