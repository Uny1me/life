import 'package:aproko_app/screens/home/nutrition_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aproko_app/models/medication.dart';
import 'package:aproko_app/screens/auth/signup_screen.dart';
import 'package:aproko_app/screens/challenges/challenges_screen.dart';
import 'package:aproko_app/screens/home/account_screen.dart';
import 'package:aproko_app/screens/home/discover_screen.dart';
import 'package:aproko_app/screens/medications/add_medication_screen.dart';
import 'package:aproko_app/screens/medications/medication_details_screen.dart';
import 'package:aproko_app/screens/notifications/notification_settings_screen.dart';
import 'package:aproko_app/screens/onboarding/app_use_case/app_use_case.dart';
import 'package:aproko_app/screens/profile/health_profile_screen.dart';
import 'package:aproko_app/screens/profile/personal_information_screen.dart';
import 'package:aproko_app/screens/splash_screen.dart';
import 'package:aproko_app/screens/onboarding/onboarding_screen.dart';
import 'package:aproko_app/screens/auth/login_screen.dart';
import 'package:aproko_app/screens/home/home_screen.dart';
import 'package:aproko_app/screens/medications/medications_screen.dart';
import 'package:aproko_app/screens/meal_plan/meal_plan_form_screen.dart';
import 'package:aproko_app/screens/meal_plan/meal_plan_loading_screen.dart';
import 'package:aproko_app/screens/meal_plan/pricing_screen.dart';
import 'package:aproko_app/screens/meal_plan/meal_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              final prefs = snapshot.data as SharedPreferences;
              final isFirstTime = prefs.getBool('isFirstTime') ?? true;
              final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
              return SplashScreen(
                isFirstTime: isFirstTime,
                isLoggedIn: isLoggedIn,
              );
            }
          },
        );
      },
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
      path: '/discover',
      builder: (context, state) => const DiscoverScreen(),
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
    GoRoute(
      path: '/meal-plan-form',
      builder: (context, state) => const MealPlanFormScreen(),
    ),
    GoRoute(
      path: '/meal-plan-loading',
      builder: (context, state) => const MealPlanLoadingScreen(),
    ),
    GoRoute(
      path: '/pricing',
      builder: (context, state) => const PricingScreen(),
    ),
    GoRoute(
      path: '/nutrition',
      builder: (context, state) => const NutritionScreen(),
    ),

    GoRoute(
      path: '/meal-details',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return MealDetailsScreen(
          mealName: args['mealName'] as String,
          mealDescription: args['mealDescription'] as String,
          imageUrl: args['imageUrl'] as String,
          calories: args['calories'] as int,
          nutrients: args['nutrients'] as Map<String, double>,
          benefits: args['benefits'] as List<String>,
        );
      },
    ),
  ],
);
