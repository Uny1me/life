import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:aproko_app/providers/workout_provider.dart';

class GeneratingWorkoutScreen extends StatefulWidget {
  const GeneratingWorkoutScreen({super.key});

  @override
  State<GeneratingWorkoutScreen> createState() => _GeneratingWorkoutScreenState();
}

class _GeneratingWorkoutScreenState extends State<GeneratingWorkoutScreen> {
  late Timer _timer;
  int _dotsCount = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotsCount = (_dotsCount + 1) % 4;
      });
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 3), () {
      final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
      workoutProvider.setWorkoutPlan({
        'type': 'muscle_building',
        'duration': '30 days',
        'workouts': [],
      });
      workoutProvider.setGenerating(false);
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dots = '.' * _dotsCount;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100.w,
              height: 100.w,
              child: CircularProgressIndicator(
                strokeWidth: 8.w,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'Generating your workout plan$dots',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 16.h),
            Text(
              'This may take a moment',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
