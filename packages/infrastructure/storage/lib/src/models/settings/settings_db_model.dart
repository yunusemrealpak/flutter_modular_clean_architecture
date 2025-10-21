import 'package:objectbox/objectbox.dart';
import 'package:storage/src/core/base_db_model.dart';

@Entity()
final class SettingsDbModel implements DbModel {
  @override
  @Id()
  int id = 0;
  String themeMode;

  SettingsDbModel({this.themeMode = 'light'});

  @override
  int get entityId => id;

  @override
  bool validate() {
    return true;
  }
}
