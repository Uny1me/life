import 'package:flutter/material.dart';
import 'package:aproko_app/models/challenge.dart';
import 'package:uuid/uuid.dart';

class ChallengeProvider extends ChangeNotifier {
  final List<Challenge> _challenges = [];
  final _uuid = const Uuid();

  List<Challenge> get challenges => _challenges;

  List<Challenge> get activeChallenges => _challenges.where((challenge) => challenge.isActive).toList();

  void addChallenge(Challenge challenge) {
    _challenges.add(challenge);
    notifyListeners();
  }

  void removeChallenge(String id) {
    _challenges.removeWhere((challenge) => challenge.id == id);
    notifyListeners();
  }

  void toggleChallengeStatus(String id) {
    final index = _challenges.indexWhere((challenge) => challenge.id == id);
    if (index != -1) {
      final challenge = _challenges[index];
      _challenges[index] = Challenge(
        id: challenge.id,
        name: challenge.name,
        description: challenge.description,
        duration: challenge.duration,
        pictures: challenge.pictures,
        category: challenge.category,
        videoId: challenge.videoId,
        isActive: !challenge.isActive,
      );
      notifyListeners();
    }
  }

  String generateId() => _uuid.v4();
}
