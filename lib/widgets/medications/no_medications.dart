import 'package:flutter/material.dart';

class NoMedications extends StatelessWidget {
  final void Function() navigateToAddMedicationSreen;
  const NoMedications({super.key, required this.navigateToAddMedicationSreen});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.medication,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No active medications',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: navigateToAddMedicationSreen,
            child: const Text('Add Medication'),
          ),
        ],
      ),
    );
  }
}
