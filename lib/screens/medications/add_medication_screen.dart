import 'package:aproko_app/library/diseases.dart';
import 'package:aproko_app/models/medication.dart';
import 'package:aproko_app/providers/medication_provider.dart';
import 'package:aproko_app/theme/app_theme.dart';
import 'package:aproko_app/widgets/medications/health_conditions_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({super.key});

  @override
  AddMedicationScreenState createState() => AddMedicationScreenState();
}

class AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 3));
  TimeOfDay _morningTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _eveningTime = const TimeOfDay(hour: 20, minute: 0);
  String healthCondition = 'Malaria';

  final TextEditingController _customDiseaseController = TextEditingController();
  final TextEditingController _medicationNameController = TextEditingController();
  bool showCustomDiseaseField = false;

  @override
  void dispose() {
    _customDiseaseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medication'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('What medication are you taking?'),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _medicationNameController,
                  decoration: const InputDecoration(
                    labelText: 'Medication Name',
                  ),
                ),
                SizedBox(height: 20.h),
                const Text('Select your health condition'),
                const SizedBox(height: 8),
                HealthConditionsWrap(
                    healthConditions: healthConditions,
                    selectedCondition: healthCondition,
                    onConditionSelected: (condition) {
                      setState(() {
                        healthCondition = condition;
                      });
                    }),
                SizedBox(height: 20.h),
                const Text('Can\'t find yours? Tell us here'),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _customDiseaseController,
                  decoration: InputDecoration(
                    labelText: 'Other Health Condition',
                    labelStyle: TextStyle(fontSize: 11, color: AppTheme.backgroundDark.withOpacity(0.5)),
                  ),
                ),
                SizedBox(height: 24.h),
                const Text('Treatment Period'),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                        child: _buildDateField('Start Date', _startDate, (date) {
                      setState(() {
                        _startDate = date;
                      });
                    })),
                    SizedBox(width: 8.w),
                    Expanded(
                        child: _buildDateField('End Date', _endDate, (date) {
                      setState(() {
                        _endDate = date;
                      });
                    })),
                  ],
                ),
                SizedBox(height: 24.h),
                const Text('Medication Schedule'),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                        child: _buildTimeField('Morning Dose', _morningTime, (time) {
                      setState(() {
                        _morningTime = time;
                      });
                    })),
                    SizedBox(width: 8.w),
                    Expanded(
                        child: _buildTimeField('Evening Dose', _eveningTime, (time) {
                      setState(() {
                        _eveningTime = time;
                      });
                    })),
                  ],
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _saveMedication,
                    child: const Text(
                      'Add Medication',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveMedication() {
    if (_formKey.currentState!.validate()) {
      final disease = showCustomDiseaseField ? _customDiseaseController.text : healthCondition;

      // Create scheduled times for each day
      final scheduledTimes = <DateTime>[];
      final currentDate = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
      );
      final endDate = DateTime(
        _endDate.year,
        _endDate.month,
        _endDate.day,
      );

      var date = currentDate;
      while (!date.isAfter(endDate)) {
        // Add morning dose
        scheduledTimes.add(DateTime(
          date.year,
          date.month,
          date.day,
          _morningTime.hour,
          _morningTime.minute,
        ));

        // Add evening dose
        scheduledTimes.add(DateTime(
          date.year,
          date.month,
          date.day,
          _eveningTime.hour,
          _eveningTime.minute,
        ));

        date = date.add(const Duration(days: 1));
      }

      // Create medication based on disease
      Medication medication;
      if (disease == 'Malaria') {
        medication = Medication.malaria(
          id: Provider.of<MedicationProvider>(context, listen: false).generateId(),
          startDate: _startDate,
          endDate: _endDate,
          name: _medicationNameController.text,
          scheduledTimes: scheduledTimes,
        );
      } else {
        // For other diseases, create a generic medication
        medication = Medication(
          id: Provider.of<MedicationProvider>(context, listen: false).generateId(),
          name: _medicationNameController.text,
          disease: disease,
          prescriptionMethod: 'Prescribed by Doctor',
          scheduledTimes: scheduledTimes,
          startDate: _startDate,
          endDate: _endDate,
          dosage: 'As prescribed',
          instructions: 'Take as directed by your doctor',
          facts: [
            'This medication has been prescribed by your healthcare provider.',
            'Follow the dosage instructions carefully.',
            'Complete the full course of treatment even if you feel better.',
            'Contact your doctor if you experience any side effects.',
          ],
          diseaseFacts: [
            'Consult your healthcare provider for information about this condition.',
            'Follow your treatment plan as prescribed.',
            'Keep all follow-up appointments.',
          ],
        );
      }

      // Add medication to provider
      Provider.of<MedicationProvider>(context, listen: false).addMedication(medication);

      // Navigate back
      Navigator.pop(context);
    }
  }

  Widget _buildTimeField(
    String label,
    TimeOfDay value,
    Function(TimeOfDay) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: value,
            );
            if (time != null) {
              onChanged(time);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.format(context),
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.access_time, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(
    String label,
    DateTime value,
    Function(DateTime) onChanged, {
    DateTime? minDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: value,
              firstDate: minDate ?? DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              onChanged(date);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('MMM d, y').format(value),
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.calendar_today, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
