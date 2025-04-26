import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/notification_settings_provider.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: Consumer<NotificationSettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Master Switch
              SwitchListTile(
                title: const Text(
                  'All Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('Enable or disable all notifications'),
                value: settings.allNotificationsEnabled,
                onChanged: (value) => settings.setAllNotifications(value),
              ),
              const Divider(height: 1, thickness: 0.5, color: Colors.grey),

              // Sedentary Reminder
              _buildNotificationTile(
                context,
                'Sedentary Reminder',
                'Get reminded to move when sitting for too long',
                settings.sedentaryReminderEnabled,
                settings.allNotificationsEnabled,
                (value) => settings.setSedentaryReminder(value),
                settings.sedentaryHours,
                settings.sedentaryMinutes,
                (hours) => settings.setSedentaryHours(hours),
                (minutes) => settings.setSedentaryMinutes(minutes),
              ),

              // Medications
              _buildNotificationTile(
                context,
                'Medications',
                'Get reminded to take your medications',
                settings.medicationsEnabled,
                settings.allNotificationsEnabled,
                (value) => settings.setMedications(value),
                settings.medicationsHours,
                settings.medicationsMinutes,
                (hours) => settings.setMedicationsHours(hours),
                (minutes) => settings.setMedicationsMinutes(minutes),
              ),

              // Eating Reminder
              _buildNotificationTile(
                context,
                'Eating Reminder',
                'Get reminded to eat at regular intervals',
                settings.eatingReminderEnabled,
                settings.allNotificationsEnabled,
                (value) => settings.setEatingReminder(value),
                settings.eatingHours,
                settings.eatingMinutes,
                (hours) => settings.setEatingHours(hours),
                (minutes) => settings.setEatingMinutes(minutes),
              ),

              // Water Reminder
              _buildNotificationTile(
                context,
                'Water Reminder',
                'Get reminded to drink water regularly',
                settings.waterReminderEnabled,
                settings.allNotificationsEnabled,
                (value) => settings.setWaterReminder(value),
                settings.waterHours,
                settings.waterMinutes,
                (hours) => settings.setWaterHours(hours),
                (minutes) => settings.setWaterMinutes(minutes),
              ),

              // Fitness Challenges
              SwitchListTile(
                title: const Text('Fitness Challenges'),
                subtitle: const Text('Get notified about new challenges and updates'),
                value: settings.fitnessChallengesEnabled,
                onChanged: settings.allNotificationsEnabled ? (value) => settings.setFitnessChallenges(value) : null,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNotificationTile(
    BuildContext context,
    String title,
    String subtitle,
    bool value,
    bool masterEnabled,
    Function(bool) onChanged,
    String hours,
    String minutes,
    Function(String) onHoursChanged,
    Function(String) onMinutesChanged,
  ) {
    return Column(
      children: [
        SwitchListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          value: value,
          onChanged: masterEnabled ? onChanged : null,
        ),
        if (value && masterEnabled)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                  child: Text(
                    'Remind me every:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 4.0, bottom: 4.0),
                            child: Text(
                              'Hours',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          _buildTimeDropdown(
                            context,
                            'Hours',
                            hours,
                            List.generate(24, (index) => index.toString()),
                            onHoursChanged,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 4.0, bottom: 4.0),
                            child: Text(
                              'Minutes',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          _buildTimeDropdown(
                            context,
                            'Minutes',
                            minutes,
                            List.generate(60, (index) => index.toString()),
                            onMinutesChanged,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        const Divider(height: 1, thickness: 0.5, color: Colors.grey),
      ],
    );
  }

  Widget _buildTimeDropdown(
    BuildContext context,
    String label,
    String value,
    List<String> items,
    Function(String) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          hint: Text(label),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}
