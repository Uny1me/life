import 'package:flutter/foundation.dart';

class WorkoutProvider with ChangeNotifier {
  bool _hasWorkoutPlan = false;
  Map<String, dynamic>? _workoutPlan;
  bool _isGenerating = false;

  bool get hasWorkoutPlan => _hasWorkoutPlan;
  Map<String, dynamic>? get workoutPlan => _workoutPlan;
  bool get isGenerating => _isGenerating;

  void setGenerating(bool value) {
    _isGenerating = value;
    notifyListeners();
  }

  void setWorkoutPlan(Map<String, dynamic> plan) {
    _workoutPlan = plan;
    _hasWorkoutPlan = true;
    notifyListeners();
  }

  void clearWorkoutPlan() {
    _workoutPlan = null;
    _hasWorkoutPlan = false;
    notifyListeners();
  }
}
