import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/medication_provider.dart';
import 'providers/notification_settings_provider.dart';
import 'providers/challenge_provider.dart';
import 'providers/workout_provider.dart';
import 'data/mock_challenges.dart';
import 'widgets/desktop_to_mobile_wrapper.dart';
import 'routes/app_routes.dart';

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
            ChangeNotifierProvider(create: (_) {
              final provider = ChallengeProvider();
              for (final challenge in mockChallenges) {
                provider.addChallenge(challenge);
              }
              return provider;
            }),
            ChangeNotifierProvider(create: (_) => WorkoutProvider()),
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
                  routerConfig: appRouter,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
