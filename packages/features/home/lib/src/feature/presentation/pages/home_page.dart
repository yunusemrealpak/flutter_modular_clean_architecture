import 'package:core/core.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:session/session.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionBloc, SessionState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Home Page')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Welcome to the Home Page!'),
                SizedBox(height: 20),

                state.maybeMap(
                  orElse: () => Container(),
                  authenticated: (authState) {
                    return Column(
                      children: [
                        Text('Hello, ${authState.session.accessToken}!'),
                        ElevatedButton(
                          onPressed: () {
                            //EventBus.I.publish(LogoutSuccessEvent());
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    );
                  },
                  unauthenticated: (_) {
                    return ElevatedButton(
                      onPressed: () {
                        EventBus.I.publish(LogoutSuccessEvent());
                      },
                      child: const Text('Login'),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
