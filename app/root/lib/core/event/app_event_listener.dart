import 'dart:async';

import 'package:auth/auth.dart';
import 'package:event_bus/event_bus.dart';
import 'package:home/core/route/home_router.gr.dart';
import 'package:injectable/injectable.dart';
import 'package:root/main.dart';

@singleton
class AppEventListener {
  @factoryMethod
  AppEventListener() {
    start();
  }

  StreamSubscription? _subLogin;
  StreamSubscription? _subLogout;
  StreamSubscription? _subNavigate;

  void start() {
    // Login → Home’a git (stack replace)
    _subLogin = EventBus.I.subscribe<AuthenticationSuccessEvent>((e) async {
      await appRouter.replaceAll([HomeRoute()]);
    });

    // Logout → Sign-in’e git (stack replace)
    _subLogout = EventBus.I.subscribe<LogoutSuccessEvent>((e) async {
      await appRouter.replaceAll([LoginRoute()]);
    });

    // Genel navigasyon niyeti (isteğe bağlı)
    _subNavigate = EventBus.I.subscribe<NavigateToFeatureEvent>((e) async {});
  }

  void stop() {
    _subLogin?.cancel();
    _subLogout?.cancel();
    _subNavigate?.cancel();
  }
}
