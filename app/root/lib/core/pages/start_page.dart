import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:profile/core/profile_usecase.dart';
import 'package:profile/core/route/profile_router.gr.dart';
import 'package:root/core/di/injection_container.dart';

@RoutePage()
class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String text = 'Root Module';

  @override
  void initState() {
    super.initState();
    text = di<ProfileUsecase>().title;
  }

  void getText() {
    text = di<ProfileUsecase>().title;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                di<ProfileUsecase>().execute();
                context.router
                    .push(const ProfileRoute())
                    .then((value) => getText());
              },
              child: const Text('Go to Profile Module'),
            ),
          ),
        ],
      ),
    );
  }
}
