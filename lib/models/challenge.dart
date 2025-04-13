import 'package:flutter/material.dart';

enum ChallengeCategory {
  nutrition,
  medication,
  fitness,
}

class Challenge {
  final String id;
  final String name;
  final String description;
  final Duration duration;
  final List<String> pictures;
  final String videoId;
  final ChallengeCategory category;
  final bool isActive;

  const Challenge({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.pictures,
    required this.category,
    required this.videoId,
    this.isActive = false,
  });

  Color getCategoryColor() {
    switch (category) {
      case ChallengeCategory.nutrition:
        return Colors.green;
      case ChallengeCategory.medication:
        return Colors.blue;
      case ChallengeCategory.fitness:
        return Colors.orange;
    }
  }

  Color getCategoryDarkColor() {
    switch (category) {
      case ChallengeCategory.nutrition:
        return Colors.green.shade700;
      case ChallengeCategory.medication:
        return Colors.blue.shade700;
      case ChallengeCategory.fitness:
        return Colors.orange.shade700;
    }
  }
}
