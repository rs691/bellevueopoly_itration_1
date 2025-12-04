import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/business_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/stop_hub_screen.dart';
import 'screens/business_list_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  print('Bellevueopoly: Starting app...');
  runApp(const ProviderScope(child: BellevueopolyApp()));
}

class BellevueopolyApp extends ConsumerWidget {
  const BellevueopolyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Bellevueopoly: Building BellevueopolyApp');
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/list',
          builder: (context, state) => const BusinessListScreen(),
        ),
        GoRoute(
          path: '/business/:id',
          builder: (context, state) {
            final businessId = state.pathParameters['id']!;
            return BusinessDetailScreen(businessId: businessId);
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/stops',
          builder: (context, state) => const StopHubScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Bellevueopoly',
      theme: AppTheme.theme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Constrain to mobile size
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Container(
              width: 414, // iPhone 11 Pro Max width
              height: 896, // iPhone 11 Pro Max height
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: ClipRect(
                child: child ?? const SizedBox(),
              ),
            ),
          ),
        );
      },
    );
  }
}
