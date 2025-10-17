import 'package:app_shell/app_shell.dart';
import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/core/di/injection_container.dart';
import 'package:root/core/route/app_router.dart';

final appRouter = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di<AuthBloc>(), lazy: false),
        BlocProvider(create: (context) => di<AppBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Modular Clean Architecture',
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );
  }
}
