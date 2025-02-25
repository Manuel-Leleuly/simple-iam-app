import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:simple_iam/packages/auth/screens/auth_screen.dart';
import 'package:simple_iam/packages/users/screens/user_list_screen.dart';

class RouteGenerator {
  static Route<Widget> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    final selectedScreen = switch (settings.name) {
      AuthScreen.routeName => const AuthScreen(),
      UserListScreen.routeName => const UserListScreen(),
      _ => const _ErrorRouteScreen(),
    };

    return MaterialPageRoute(
      builder: (context) => LoaderOverlay(
        child: selectedScreen,
      ),
    );
  }
}

// helper widgets
class _ErrorRouteScreen extends StatelessWidget {
  const _ErrorRouteScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('Page not found'),
      ),
    );
  }
}
