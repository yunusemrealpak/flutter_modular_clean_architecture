import 'package:objectbox/objectbox.dart';

/// Her model'nin implement etmesi gereken base interface
abstract class DbModel {
  @Id()
  int id = 0;

  /// ObjectBox query'leri için kullanılacak
  int get entityId => id;

  /// Model validasyonu için
  bool validate() => true;
}
