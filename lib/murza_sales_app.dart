import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/auth/presentation/login/login_screen.dart';
import 'package:murza_app/auth/presentation/splash/splash_screen.dart';
import 'package:murza_app/core/presentation/global/restart_widget.dart';
import 'package:murza_app/core/theme/app_theme.dart';
import 'package:murza_app/home_screen.dart';

import 'auth/application/auth/auth_provider.dart';

class MurzaSalesApp extends ConsumerStatefulWidget {
  const MurzaSalesApp({super.key});
  @override
  ConsumerState<MurzaSalesApp> createState() => _MurzaSalesAppState();
}

class _MurzaSalesAppState extends ConsumerState<MurzaSalesApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(authProvider.notifier).authCheckRequest());
  }

  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: Consumer(
          // Using Consumer to access the context and theme
          builder: (context, ref, child) {
            // Access the auth state from the provider
            final authStateValue = ref.watch(authProvider);
            return authStateValue.when(
              initial: () => const SplashScreen(),
              loading: () => const SplashScreen(),
              authenticated: () => const HomeScreen(),
              unauthenticated: () => const LoginScreen(),
            );
          },
        ),
      ),
    );
  }
}
