import 'package:aproko_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  Timer? _timer;
  Duration _timeUntilNextMeal = Duration.zero;
  final int _mealsConsumed = 1;
  final int _totalMeals = 3;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timeUntilNextMeal = const Duration(hours: 2, minutes: 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeUntilNextMeal.inSeconds > 0) {
          _timeUntilNextMeal = _timeUntilNextMeal - const Duration(seconds: 1);
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
              sliver: SliverToBoxAdapter(
                child: _buildNextMealTimer(context),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
              sliver: SliverToBoxAdapter(
                child: _buildDailySummary(context),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
              sliver: SliverToBoxAdapter(
                child: _buildMealPlanCTA(context),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Today\'s Meals',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildMealCard(context, index),
                  childCount: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextMealTimer(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80.w,
                  height: 80.w,
                  child: CircularProgressIndicator(
                    value: _timeUntilNextMeal.inSeconds / (2.5 * 3600),
                    strokeWidth: 8.w,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                ),
                Column(
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      size: 24.w,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'LUNCH',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.titleMedium?.color?.withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 16.w),
            SizedBox(
              width: 200.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _formatDuration(_timeUntilNextMeal),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.surfaceDark,
                          fontSize: 24.sp,
                        ),
                  ),
                  Text(
                    'Time remaining',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 12.sp,
                          color: Theme.of(context).textTheme.titleMedium?.color?.withOpacity(0.7),
                        ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: 210.w,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add Meal'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailySummary(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Daily Summary',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNutritionItem(
                  context,
                  'Meals',
                  '$_mealsConsumed',
                  '$_totalMeals',
                  Colors.orange,
                ),
                _buildNutritionItem(
                  context,
                  'Calories',
                  '1,800',
                  '2,000',
                  AppTheme.secondaryDark,
                ),
                _buildNutritionItem(
                  context,
                  'Water',
                  '0.5L',
                  '2.4L',
                  AppTheme.primaryDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealPlanCTA(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          context.go('/meal-plan-form');
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Icon(
                Icons.fastfood,
                size: 48.sp,
                color: AppTheme.secondaryDark,
              ),
              SizedBox(height: 16.h),
              Text(
                'Get Your Custom Meal Plan',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Personalized meal plans based on your preferences and goals',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryDark,
                ),
                onPressed: () {
                  context.go('/meal-plan-form');
                },
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionItem(
    BuildContext context,
    String label,
    String current,
    String target,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
        ),
        SizedBox(height: 4.h),
        Text(
          current,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        Text(
          'of $target',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
        ),
      ],
    );
  }

  Widget _buildMealCard(BuildContext context, int index) {
    final meals = ['Breakfast', 'Lunch', 'Dinner'];
    final mealIcons = [
      Icons.breakfast_dining,
      Icons.lunch_dining,
      Icons.dinner_dining,
    ];

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.w),
        leading: ClipOval(
          child: Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            child: index == 0
                ? Image.asset('assets/images/nutrition/breakfast.png', fit: BoxFit.cover)
                : index == 1
                    ? Image.asset('assets/images/nutrition/lunch.png', fit: BoxFit.cover)
                    : Image.asset('assets/images/nutrition/dinner.png', fit: BoxFit.cover),
          ),
        ),
        title: Text(
          meals[index],
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(
          index == 0
              ? 'Egg salad • 350 calories'
              : index == 1
                  ? 'Jollof rice and Chicken • 450 calories'
                  : 'Four Mangoes • 396 calories',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.check_circle_outline),
          onPressed: () => context.push('/meal-details', extra: {
            'mealName': meals[index],
            'mealDescription': index == 0
                ? 'A healthy egg salad to start your day.'
                : index == 1
                    ? 'Delicious Jollof rice with Chicken for lunch.'
                    : 'Sweet and juicy mangoes for dinner.',
            'imageUrl': index == 0
                ? 'assets/images/nutrition/breakfast.png'
                : index == 1
                    ? 'assets/images/nutrition/lunch.png'
                    : 'assets/images/nutrition/dinner.png',
            'calories': index == 0
                ? 350
                : index == 1
                    ? 450
                    : 396,
            'nutrients': {
              'Protein': index == 0
                  ? 20.0
                  : index == 1
                      ? 30.0
                      : 5.0,
              'Carbs': index == 0
                  ? 30.0
                  : index == 1
                      ? 50.0
                      : 90.0,
              'Fat': index == 0
                  ? 10.0
                  : index == 1
                      ? 15.0
                      : 1.0,
            },
            'benefits': index == 0
                ? ['High in protein', 'Low in carbs']
                : index == 1
                    ? ['Rich in flavor', 'High in protein']
                    : ['Rich in vitamins', 'Good for digestion'],
          }),
        ),
      ),
    );
  }
}
