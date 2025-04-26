import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'workout_session_screen.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String workoutType;
  final int dayNumber;

  const WorkoutDetailScreen({
    super.key,
    required this.workoutType,
    required this.dayNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/fitness/chest.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DAY $dayNumber',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    workoutType,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.blue[300],
                    ),
                  ),
                ],
              ),
              titlePadding: EdgeInsets.only(left: 16.w, bottom: 16.h),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection(),
                  SizedBox(height: 24.h),
                  Text(
                    '4 exercises',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Edited by myself',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildExerciseItem(
                'Incline Bench Press • Barbell',
                '4 Sets x 8 reps',
                'bench_press.png',
              ),
              _buildExerciseItem(
                'Bench Press • Smith Machine',
                '4 Sets x 8 reps',
                'smith_machine.png',
              ),
              _buildExerciseItem(
                'Standing Decline Fly • Cable',
                '4 Sets x 8 reps',
                'cable_fly.png',
              ),
              _buildExerciseItem(
                'Chest Dip',
                '3 Sets x 10 reps',
                'chest_dip.png',
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.h),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutSessionScreen(
                  workoutName: workoutType,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 16.h),
          ),
          child: Text(
            'START',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return _buildInfoItem(label: 'Equipment', value: '17 Selected', icon: Icons.fitness_center);
  }

  Widget _buildInfoItem({String? label, String? value, IconData? icon}) {
    return Row(
      children: [
        if (label != null)
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        SizedBox(width: 8.w),
        Text(
          value ?? '',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 4.w),
        Icon(
          icon,
          size: 16.sp,
          color: Colors.grey[600],
        ),
      ],
    );
  }

  Widget _buildExerciseItem(String title, String subtitle, String imagePath) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.fitness_center,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.info_outline,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
