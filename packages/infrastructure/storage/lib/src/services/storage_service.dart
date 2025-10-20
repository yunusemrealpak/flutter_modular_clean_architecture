import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:storage/objectbox.g.dart';

class StorageService {
  static StorageService? _instance;
  Store? _store;

  StorageService._();

  static StorageService get I {
    _instance ??= StorageService._();
    return _instance!;
  }

  Future<void> initialize({String? directoryPath}) async {
    if (_store != null) {
      return; // Zaten initialize edilmiş
    }

    final dir =
        directoryPath ?? (await getApplicationDocumentsDirectory()).path;

    _store = await openStore(
      directory: '$dir/db',
      macosApplicationGroup: 'db.app',
    );
  }

  /// Store instance'ını döndürür
  Store get store {
    if (_store == null) {
      throw StateError(
        'StorageService not initialized. Call initialize() first.',
      );
    }
    return _store!;
  }

  /// Store'u kapatır
  Future<void> close() async {
    _store?.close();
    _store = null;
  }

  /// Belirli bir entity için Box döndürür
  Box<T> getBox<T>() {
    return store.box<T>();
  }

  /// Tüm veritabanını temizler
  Future<void> clearAllData() async {
    if (_store != null) {
      _store!.close();
      final dir = Directory(_store!.directoryPath);
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
      _store = null;
    }
  }
}
