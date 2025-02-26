import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:simple_iam/packages/auth/screens/auth_screen.dart';
import 'package:simple_iam/packages/users/screens/user_list_screen.dart';
import 'package:simple_iam/providers/token_provider.dart';
import 'package:simple_iam/routes/routes.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.purple,
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: improve this
    final isTokenValid = ref.watch(tokenProvider).accessToken.isNotEmpty;

    return MaterialApp(
      title: 'Simple IAM',
      theme: ThemeData().copyWith(
        primaryColor: colorScheme.primary,
        scaffoldBackgroundColor: colorScheme.surface,
        colorScheme: colorScheme,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: LoaderOverlay(
        child: isTokenValid ? const UserListScreen() : const AuthScreen(),
      ),
    );
  }
}
