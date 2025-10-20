import 'package:objectbox/objectbox.dart';
import 'package:storage/src/core/base_db_model.dart';
import 'package:storage/src/services/storage_service.dart';

class StorageHelper<T extends DbModel> {
  late final Box<T> _box;

  StorageHelper() {
    _box = StorageService.I.getBox<T>();
  }

  /// Box instance'ını döndürür (özel sorgular için)
  Box<T> get box => _box;

  /// Tek bir entity ekler veya günceller
  Future<int> save(T entity) async {
    if (!entity.validate()) {
      throw ArgumentError('Entity validation failed');
    }
    return _box.putAsync(entity);
  }

  /// Birden fazla entity ekler veya günceller
  Future<List<int>> saveMany(List<T> entities) async {
    for (final entity in entities) {
      if (!entity.validate()) {
        throw ArgumentError('Entity validation failed');
      }
    }
    return _box.putManyAsync(entities);
  }

  /// ID'ye göre entity getirir
  Future<T?> findById(int id) async {
    return _box.getAsync(id);
  }

  /// Tüm entity'leri getirir
  Future<List<T>> findAll() async {
    return _box.getAllAsync();
  }

  /// ID'ye göre entity siler
  Future<bool> deleteById(int id) async {
    return _box.removeAsync(id);
  }

  /// Entity'yi siler
  Future<bool> delete(T entity) async {
    return deleteById(entity.id);
  }

  /// Birden fazla entity siler
  Future<int> deleteMany(List<int> ids) async {
    return _box.removeManyAsync(ids);
  }

  /// Tüm entity'leri siler
  Future<int> deleteAll() async {
    return _box.removeAllAsync();
  }

  /// Entity sayısını döndürür
  int count() {
    return _box.count();
  }

  /// Query builder döndürür (özel sorgular için)
  Query<T> query([Condition<T>? condition]) {
    return condition != null
        ? _box.query(condition).build()
        : _box.query().build();
  }

  /// Stream olarak tüm değişiklikleri dinler
  Stream<List<T>> watchAll() {
    return _box
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  /// Stream olarak belirli bir condition'a göre değişiklikleri dinler
  Stream<List<T>> watch(Condition<T> condition) {
    return _box
        .query(condition)
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }
}
