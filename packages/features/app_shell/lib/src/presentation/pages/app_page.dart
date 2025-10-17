import 'package:app_shell/src/core/router/app_shell_router.gr.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../bloc/app_bloc.dart';

@RoutePage()
class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        // Extract current tab index from state
        final currentIndex = state.map(
          initial: (state) => state.currentTabIndex,
          tabChanged: (state) => state.currentTabIndex,
        );

        return AutoTabsRouter(
          routes: [HomeTabRoute(), ProfileTabRoute()],
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);

            // Sync the tab router with bloc state
            if (tabsRouter.activeIndex != currentIndex) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                tabsRouter.setActiveIndex(currentIndex);
              });
            }

            return Scaffold(
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  // Trigger bloc event when user taps
                  context.read<AppBloc>().add(
                    AppEvent.changeTabIndex(index: index),
                  );
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
