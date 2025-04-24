import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:aproko_app/providers/workout_provider.dart';
import 'package:aproko_app/screens/fitness/generate_workout_screen.dart';
import 'package:aproko_app/screens/fitness/workout_detail_screen.dart';

class Workouts extends StatelessWidget {
  const Workouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutProvider, child) {
        if (!workoutProvider.hasWorkoutPlan) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No workouts',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    textAlign: TextAlign.center,
                    'You have no workout plans for now but we can generate one for you',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GenerateWorkoutScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Generate Plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: _buildProgramInfo(context),
              ),
              Column(
                children: List.generate(
                  11,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: _buildWorkoutDayCard(context, index),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgramInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Muscle Building',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                size: 16.w,
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
              SizedBox(width: 4.w),
              Text(
                '30 Days',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Complete muscle building program designed to help you gain strength and muscle mass.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutDayCard(BuildContext context, int index) {
    final isRestDay = index == 3 || index == 7;
    final dayNumber = index + 1;
    final isFirstDay = index == 0;
    String workoutType;

    switch (index % 7) {
      case 0:
        workoutType = 'Chest';
        break;
      case 1:
        workoutType = 'Back';
        break;
      case 2:
        workoutType = 'Lower body';
        break;
      case 4:
        workoutType = 'Shoulders';
        break;
      case 5:
        workoutType = 'Lower body';
        break;
      case 6:
        workoutType = 'Arms';
        break;
      default:
        workoutType = 'Rest';
    }

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      color: isFirstDay ? Theme.of(context).primaryColor : null,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.w),
        leading: Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: isRestDay
                ? Colors.grey.withOpacity(0.1)
                : isFirstDay
                    ? Theme.of(context).primaryColor.withOpacity(0.8)
                    : Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Day $dayNumber',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isRestDay
                    ? Colors.grey
                    : isFirstDay
                        ? Colors.white
                        : Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        title: Text(
          isRestDay ? 'Rest Day' : workoutType,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isFirstDay ? Colors.white : null,
              ),
        ),
        trailing: isRestDay
            ? null
            : isFirstDay
                ? TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        isFirstDay ? Colors.white : Colors.transparent,
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutDetailScreen(
                            workoutType: workoutType,
                            dayNumber: dayNumber,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: isFirstDay ? Theme.of(context).primaryColor : null,
                        fontWeight: isFirstDay ? FontWeight.bold : null,
                      ),
                    ),
                  )
                : const Icon(Icons.lock_outline),
      ),
    );
  }
}
