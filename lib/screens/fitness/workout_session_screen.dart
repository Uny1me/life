import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutSessionScreen extends StatefulWidget {
  final String workoutName;

  const WorkoutSessionScreen({
    super.key,
    required this.workoutName,
  });

  @override
  State<WorkoutSessionScreen> createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends State<WorkoutSessionScreen> {
  final stopwatch = Stopwatch()..start();
  late Timer timer;
  String timeDisplay = '00:00';

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final minutes = stopwatch.elapsed.inMinutes;
        final seconds = stopwatch.elapsed.inSeconds % 60;
        timeDisplay = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Day 1-${widget.workoutName}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              timeDisplay,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildExerciseSection(
              'Incline Bench Press • Barbell',
              'assets/images/exercises/incline_bench.png',
              '0/4 Done',
              [60, 60, 60, 60],
              8,
            ),
            _buildExerciseSection(
              'Bench Press • Smith Machine',
              'assets/images/exercises/bench_press.png',
              '0/4 Done',
              [60, 60, 60, 60],
              8,
            ),
            _buildExerciseSection(
              'Standing Decline Fly • Cable',
              'assets/images/exercises/cable_fly.png',
              '0/4 Done',
              [60, 60, 60, 60],
              8,
            ),
            _buildExerciseSection(
              'Chest Dip',
              'assets/images/exercises/chest_dip.png',
              '0/3 Done',
              [0, 0, 0],
              10,
            ),
            SizedBox(height: 80.h), // Space for bottom button
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.edit_note, size: 24.w),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  'LOG NEXT SET',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseSection(
    String title,
    String imagePath,
    String progress,
    List<int> weights,
    int reps,
  ) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          leading: Image.asset(
            imagePath,
            width: 40.w,
            height: 40.w,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.fitness_center,
              size: 40.w,
              color: Colors.grey[400],
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            progress,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ),
        Column(
          children: List.generate(
            weights.length,
            (index) => _buildSetRow(index + 1, weights[index], reps),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            '+ Add set',
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSetRow(int setNumber, int weight, int reps) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Container(
            width: 60.w,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weight.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' KG',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  reps.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' Reps',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Checkbox(
                value: false,
                onChanged: (bool? value) {
                  // Handle checkbox state change
                },
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
