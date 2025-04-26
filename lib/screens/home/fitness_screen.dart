import 'package:aproko_app/widgets/fitness/workouts.dart';
import 'package:aproko_app/widgets/fitness/workout_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelStyle: TextStyle(
                fontSize: 12.sp,
                color: _tabController.index == 0 ? Theme.of(context).primaryColor : null,
              ),
              dividerHeight: 0,
              controller: _tabController,
              tabs: const [
                Tab(text: 'Workouts'),
                Tab(text: 'Progress'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const <Widget>[
                Workouts(),
                WorkoutProgress(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
