import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:simple_iam/packages/auth/screens/auth_screen.dart';
import 'package:simple_iam/packages/users/models/argument_model.dart';
import 'package:simple_iam/packages/users/screens/user_detail_screen.dart';
import 'package:simple_iam/packages/users/screens/user_list_screen.dart';
import 'package:simple_iam/packages/users/screens/user_update_screen.dart';

class RouteGenerator {
  static Route<Widget> generateRoute(RouteSettings settings) {
    Widget selectedScreen = const _ErrorRouteScreen();

    switch (settings.name) {
      case AuthScreen.routeName:
        selectedScreen = const AuthScreen();
        break;
      case UserListScreen.routeName:
        selectedScreen = const UserListScreen();
        break;
      case UserDetailScreen.routeName:
        final args = settings.arguments as UserDetailScreenArgument;
        selectedScreen = UserDetailScreen(userId: args.selectedUser.id);
        break;
      case UserUpdateScreen.routeName:
        final args = settings.arguments as UserUpdateScreenArgument;
        selectedScreen = UserUpdateScreen(userId: args.selectedUser.id);
        break;
    }

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
