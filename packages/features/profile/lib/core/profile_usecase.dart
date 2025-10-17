import 'package:core/core.dart';

@singleton
class ProfileUsecase {
  String title = 'Değişmedi';

  void execute() {
    title = 'Değişti';
  }
}
