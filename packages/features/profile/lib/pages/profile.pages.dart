import 'package:core/core.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:profile/core/profile_usecase.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String title = 'Yükleniyor';

  @override
  void initState() {
    super.initState();
    title = di<ProfileUsecase>().title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: Center(child: Text(title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EventBus.I.publish(ChangeBottomNavIndexEvent(newIndex: 0));
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
