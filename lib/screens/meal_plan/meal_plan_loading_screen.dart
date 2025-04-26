import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MealPlanLoadingScreen extends StatefulWidget {
  const MealPlanLoadingScreen({super.key});

  @override
  State<MealPlanLoadingScreen> createState() => _MealPlanLoadingScreenState();
}

class _MealPlanLoadingScreenState extends State<MealPlanLoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    // Navigate to pricing screen after animation
    Future.delayed(const Duration(seconds: 7), () {
      if (mounted) {
        context.go('/pricing');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.w,
                height: 200.w,
                child: CircularProgressIndicator(
                  value: _animation.value,
                  strokeWidth: 8.w,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Generating your custom meal plan...',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                'We\'re analyzing your preferences and creating a personalized plan just for you.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
