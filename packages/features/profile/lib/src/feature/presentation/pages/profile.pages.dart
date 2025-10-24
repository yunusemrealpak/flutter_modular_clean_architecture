import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:theming/theming.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: Center(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: di<ThemeManager>().currentThemeMode,
              builder: (context, themeMode, child) {
                return AppThemeSwitchTile(
                  currentTheme: themeMode,
                  onThemeChanged: (newTheme) {
                    di<ThemeManager>().setThemeMode(newTheme);
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EventBus.I.publish(ChangeBottomNavIndexEvent(newIndex: 0));
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
