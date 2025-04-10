import 'package:aproko_app/models/medication.dart';
import 'package:aproko_app/screens/auth/signup_screen.dart';
import 'package:aproko_app/screens/challenges/challenges_screen.dart';
import 'package:aproko_app/screens/home/account_screen.dart';
import 'package:aproko_app/screens/medications/add_medication_screen.dart';
import 'package:aproko_app/screens/medications/medication_details_screen.dart';
import 'package:aproko_app/screens/notifications/notification_settings_screen.dart';
import 'package:aproko_app/screens/onboarding/app_use_case/app_use_case.dart';
import 'package:aproko_app/screens/profile/health_profile_screen.dart';
import 'package:aproko_app/screens/profile/personal_information_screen.dart';
import 'package:aproko_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/medication_provider.dart';
import 'providers/notification_settings_provider.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/medications/medications_screen.dart';
import 'widgets/desktop_to_mobile_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  prefs.setBool('isFirstTime', false);
  prefs.setBool('isLoggedIn', false);

  runApp(MyApp(isFirstTime: isFirstTime, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.isFirstTime,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => MedicationProvider()),
            ChangeNotifierProvider(create: (_) => NotificationSettingsProvider()),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return DesktopToMobileWrapper(
                child: MaterialApp.router(
                  title: 'Aproko App',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  routerConfig: GoRouter(
                    initialLocation: '/',
                    routes: [
                      GoRoute(
                        path: '/',
                        builder: (context, state) => SplashScreen(
                          isFirstTime: isFirstTime,
                          isLoggedIn: isLoggedIn,
                        ),
                      ),
                      GoRoute(
                        path: '/onboarding',
                        builder: (context, state) => const OnboardingScreen(),
                      ),
                      GoRoute(
                        path: '/login',
                        builder: (context, state) => const LoginScreen(),
                      ),
                      GoRoute(
                        path: '/home',
                        builder: (context, state) => const HomeScreen(),
                      ),
                      GoRoute(
                        path: '/signup',
                        builder: (context, state) => const SignUpScreen(),
                      ),
                      GoRoute(
                        path: '/app-use-case',
                        builder: (context, state) => const AppUseCase(),
                      ),
                      GoRoute(
                        path: '/medications',
                        builder: (context, state) => const MedicationsScreen(),
                      ),
                      GoRoute(
                        path: '/add-medication',
                        builder: (context, state) => const AddMedicationScreen(),
                      ),
                      GoRoute(
                        path: '/notification-settings',
                        builder: (context, state) => const NotificationSettingsScreen(),
                      ),
                      GoRoute(
                        path: '/personal-information',
                        builder: (context, state) => const PersonalInformationScreen(),
                      ),
                      GoRoute(
                        path: '/health-profile',
                        builder: (context, state) => const HealthProfileScreen(),
                      ),
                      GoRoute(
                        path: '/medication-details',
                        builder: (context, state) => MedicationDetailsScreen(
                          medication: state.extra as Medication,
                        ),
                      ),
                      GoRoute(
                        path: '/account',
                        builder: (context, state) => const AccountScreen(),
                      ),
                      GoRoute(
                        path: '/challenges',
                        builder: (context, state) => const ChallengesScreen(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
