import 'package:aproko_app/providers/medication_provider.dart';
import 'package:aproko_app/providers/challenge_provider.dart';
import 'package:aproko_app/screens/medications/add_medication_screen.dart';
import 'package:aproko_app/screens/medications/medication_details_screen.dart';
import 'package:aproko_app/screens/challenges/challenge_details_screen.dart';
import 'package:aproko_app/widgets/medications/no_medications.dart';
import 'package:aproko_app/models/challenge.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToAddMedicationSreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddMedicationScreen(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medications'),
        actions: [
          IconButton(
            onPressed: navigateToAddMedicationSreen,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer2<MedicationProvider, ChallengeProvider>(
        builder: (context, medicationProvider, challengeProvider, child) {
          final medications = medicationProvider.activeMedications;
          final activeChallenges =
              challengeProvider.activeChallenges.where((challenge) => challenge.category == ChallengeCategory.medication).toList();

          if (medications.isEmpty && activeChallenges.isEmpty) {
            return NoMedications(navigateToAddMedicationSreen: navigateToAddMedicationSreen);
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Active Challenges Section
              if (activeChallenges.isNotEmpty) ...[
                const Text(
                  'Active Challenges',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...activeChallenges.map((challenge) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChallengeDetailsScreen(
                                challenge: challenge,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: challenge.getCategoryDarkColor(),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.medication,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      challenge.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${challenge.duration.inDays} days',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                const SizedBox(height: 24),
              ],

              // Medications Section
              if (medications.isNotEmpty) ...[
                const Text(
                  'Medications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...medications.map((medication) {
                  final nextTime = medication.getNextMedicationTime();
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicationDetailsScreen(
                              medication: medication,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  medication.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    medication.disease,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Day ${medication.getCurrentDay()} of ${medication.getTotalDays()}',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            if (nextTime != null) ...[
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Next dose: ${DateFormat.jm().format(nextTime)}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddMedicationSreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
