import 'package:flutter/material.dart';

enum WeightGoal {
  lose,
  maintain,
  gain,
}

class BMICategory {
  final String category;
  final String description;
  final String recommendation;
  final Color color;

  BMICategory({
    required this.category,
    required this.description,
    required this.recommendation,
    required this.color,
  });

  static BMICategory getCategory(double bmi) {
    if (bmi < 18.5) {
      return BMICategory(
        category: 'Underweight',
        description:
            'Your BMI indicates you are underweight. This may be due to various factors including genetics, metabolism, or insufficient caloric intake.',
        recommendation: 'Focus on a calorie surplus diet with nutrient-dense foods. Aim to gain weight gradually through healthy means.',
        color: Colors.blue,
      );
    } else if (bmi < 25) {
      return BMICategory(
        category: 'Normal Weight',
        description: 'Your BMI falls within the healthy range. This is associated with good health outcomes.',
        recommendation: 'Maintain your current healthy habits. Focus on balanced nutrition and regular physical activity.',
        color: Colors.green,
      );
    } else if (bmi < 30) {
      return BMICategory(
        category: 'Overweight',
        description: 'Your BMI indicates you are overweight. This may increase your risk of health problems.',
        recommendation: 'Consider a balanced approach to weight management through healthy eating and increased physical activity.',
        color: Colors.orange,
      );
    } else {
      return BMICategory(
        category: 'Obese',
        description: 'Your BMI indicates obesity. This significantly increases your risk of various health conditions.',
        recommendation: 'Consult with healthcare professionals for a comprehensive weight management plan.',
        color: Colors.red,
      );
    }
  }
}

class MealPlan {
  final String breakfast;
  final String lunch;
  final String dinner;
  final int totalCalories;
  final Map<String, double> macronutrients;
  final String imageUrl;
  final String benefits;

  MealPlan({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.totalCalories,
    required this.macronutrients,
    required this.imageUrl,
    required this.benefits,
  });
}

class NigerianFood {
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final int calories;
  final Map<String, double> nutrients;

  NigerianFood({
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.calories,
    required this.nutrients,
  });
}
