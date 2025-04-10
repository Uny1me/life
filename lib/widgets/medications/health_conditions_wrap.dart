import 'package:flutter/material.dart';

class HealthConditionsWrap extends StatelessWidget {
  final List<String> healthConditions;
  final String selectedCondition;
  final void Function(String) onConditionSelected;

  const HealthConditionsWrap({
    super.key,
    required this.healthConditions,
    required this.selectedCondition,
    required this.onConditionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: healthConditions.map((String condition) {
        return FilterChip(
          label: Text(condition),
          selected: selectedCondition == condition,
          onSelected: (bool selected) {
            onConditionSelected(condition);
          },
        );
      }).toList(),
    );
  }
}
