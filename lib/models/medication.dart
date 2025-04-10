class Medication {
  final String id;
  final String name;
  final String disease;
  final String prescriptionMethod;
  final List<DateTime> scheduledTimes;
  final DateTime startDate;
  final DateTime endDate;
  final String dosage;
  final String instructions;
  final List<String> facts;
  final List<String> diseaseFacts;
  final bool isActive;
  bool remindMe;

  Medication({
    required this.id,
    required this.name,
    required this.disease,
    required this.prescriptionMethod,
    required this.scheduledTimes,
    required this.startDate,
    required this.endDate,
    required this.dosage,
    required this.instructions,
    required this.facts,
    required this.diseaseFacts,
    this.isActive = true,
    this.remindMe = false,
  });

  // Factory constructor for malaria medication
  factory Medication.malaria({
    required String id,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required List<DateTime> scheduledTimes,
  }) {
    return Medication(
      id: id,
      name: name,
      disease: 'Malaria',
      prescriptionMethod: 'Prescribed by Doctor',
      scheduledTimes: scheduledTimes,
      startDate: startDate,
      endDate: endDate,
      dosage: '4 tablets twice daily for 3 days',
      instructions: 'Take with food. Complete the full course even if you feel better.',
      remindMe: false,
      facts: [
        'Artemether/Lumefantrine is a combination medication used to treat malaria.',
        'It works by killing the malaria parasites in your blood.',
        'This medication should be taken with food to improve absorption.',
        'Common side effects include headache, dizziness, and loss of appetite.',
        'Avoid grapefruit juice while taking this medication as it may increase side effects.',
      ],
      diseaseFacts: [
        'Malaria is caused by parasites that are transmitted to people through the bites of infected female Anopheles mosquitoes.',
        'Symptoms typically appear 10-15 days after the infective mosquito bite.',
        'The first symptoms – fever, headache, and chills – may be mild and difficult to recognize as malaria.',
        'If not treated within 24 hours, P. falciparum malaria can progress to severe illness, and lead to death.',
        'Children under 5 are the most vulnerable group affected by malaria.',
      ],
    );
  }

  // Get next medication time
  DateTime? getNextMedicationTime() {
    final now = DateTime.now();
    for (var time in scheduledTimes) {
      if (time.isAfter(now)) {
        return time;
      }
    }
    return null;
  }

  // Get current day of medication
  int getCurrentDay() {
    final now = DateTime.now();
    return now.difference(startDate).inDays + 1;
  }

  // Get total days of medication
  int getTotalDays() {
    return endDate.difference(startDate).inDays + 1;
  }
}
