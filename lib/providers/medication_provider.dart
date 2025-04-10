import 'package:flutter/material.dart';
import 'package:aproko_app/models/medication.dart';
import 'package:uuid/uuid.dart';

class MedicationProvider extends ChangeNotifier {
  final List<Medication> _medications = [];
  final _uuid = const Uuid();

  List<Medication> get medications => _medications;

  List<Medication> get activeMedications => _medications.where((med) => med.isActive).toList();

  void addMedication(Medication medication) {
    _medications.add(medication);
    notifyListeners();
  }

  void removeMedication(String id) {
    _medications.removeWhere((med) => med.id == id);
    notifyListeners();
  }

  void toggleMedicationStatus(String id) {
    final index = _medications.indexWhere((med) => med.id == id);
    if (index != -1) {
      // Create a new medication with the opposite isActive status
      final med = _medications[index];
      _medications[index] = Medication(
        id: med.id,
        name: med.name,
        disease: med.disease,
        prescriptionMethod: med.prescriptionMethod,
        scheduledTimes: med.scheduledTimes,
        startDate: med.startDate,
        endDate: med.endDate,
        dosage: med.dosage,
        instructions: med.instructions,
        facts: med.facts,
        diseaseFacts: med.diseaseFacts,
        isActive: !med.isActive,
      );
      notifyListeners();
    }
  }

  // Helper method to generate a new ID
  String generateId() => _uuid.v4();
}
