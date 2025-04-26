import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:aproko_app/providers/workout_provider.dart';
import 'package:aproko_app/screens/fitness/generating_workout_screen.dart';

class GenerateWorkoutScreen extends StatefulWidget {
  const GenerateWorkoutScreen({super.key});

  @override
  State<GenerateWorkoutScreen> createState() => _GenerateWorkoutScreenState();
}

class _GenerateWorkoutScreenState extends State<GenerateWorkoutScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String _fitnessLevel = 'Beginner';
  String _goal = 'Build Muscle';
  int _workoutsPerWeek = 3;
  final List<String> _focusAreas = [];

  final List<String> _fitnessLevels = ['Beginner', 'Intermediate', 'Advanced'];
  final List<String> _goals = ['Build Muscle', 'Lose Weight', 'Get Stronger', 'Stay Fit'];
  final List<String> _bodyParts = ['Chest', 'Back', 'Arms', 'Shoulders', 'Legs', 'Core', 'Full Body'];

  void _handleNext() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    } else {
      _generateWorkout();
    }
  }

  void _generateWorkout() {
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    workoutProvider.setGenerating(true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const GeneratingWorkoutScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workout Plan'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: _handleNext,
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
          steps: [
            Step(
              title: const Text('Fitness Level'),
              content: Column(
                children: _fitnessLevels
                    .map((level) => RadioListTile<String>(
                          title: Text(level),
                          value: level,
                          groupValue: _fitnessLevel,
                          onChanged: (value) {
                            setState(() {
                              _fitnessLevel = value!;
                            });
                          },
                        ))
                    .toList(),
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: const Text('Goal'),
              content: Column(
                children: _goals
                    .map((goal) => RadioListTile<String>(
                          title: Text(goal),
                          value: goal,
                          groupValue: _goal,
                          onChanged: (value) {
                            setState(() {
                              _goal = value!;
                            });
                          },
                        ))
                    .toList(),
              ),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: const Text('Workouts Per Week'),
              content: Slider(
                value: _workoutsPerWeek.toDouble(),
                min: 2,
                max: 6,
                divisions: 4,
                label: _workoutsPerWeek.toString(),
                onChanged: (value) {
                  setState(() {
                    _workoutsPerWeek = value.round();
                  });
                },
              ),
              isActive: _currentStep >= 2,
            ),
            Step(
              title: const Text('Focus Areas'),
              content: Column(
                children: _bodyParts
                    .map((part) => CheckboxListTile(
                          title: Text(part),
                          value: _focusAreas.contains(part),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                _focusAreas.add(part);
                              } else {
                                _focusAreas.remove(part);
                              }
                            });
                          },
                        ))
                    .toList(),
              ),
              isActive: _currentStep >= 3,
            ),
          ],
        ),
      ),
    );
  }
}
