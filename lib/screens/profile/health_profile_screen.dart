import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/medication_provider.dart';

class HealthProfileScreen extends StatelessWidget {
  const HealthProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<AuthProvider>().userData;
    final medications = context.watch<MedicationProvider>().medications;

    // Mock data for statistics (in a real app, this would come from a database)
    final workoutStats = {
      'totalWorkouts': 24,
      'thisMonth': 8,
      'streak': 7,
      'caloriesBurned': 1250,
    };

    final challengeStats = {
      'completed': 12,
      'inProgress': 3,
      'successRate': 85,
    };

    final stepStats = {
      'dailyAverage': 8750,
      'weeklyTotal': 61250,
      'monthlyTotal': 262500,
      'goalAchievement': 87,
    };

    final mealStats = {
      'totalMeals': 156,
      'thisMonth': 42,
      'healthyMeals': 98,
      'waterIntake': 2.5, // liters
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Info Card
            _buildBasicInfoCard(context, userData),

            const SizedBox(height: 24),

            // Workout Statistics
            _buildStatCard(
              context,
              'Workout Statistics',
              [
                _buildStatItem('Total Workouts', '${workoutStats['totalWorkouts']}'),
                _buildStatItem('This Month', '${workoutStats['thisMonth']}'),
                _buildStatItem('Current Streak', '${workoutStats['streak']} days'),
                _buildStatItem('Calories Burned', '${workoutStats['caloriesBurned']} kcal'),
              ],
              Icons.fitness_center,
              Colors.blue,
            ),

            const SizedBox(height: 16),

            // Challenge Statistics
            _buildStatCard(
              context,
              'Challenge Statistics',
              [
                _buildStatItem('Completed Challenges', '${challengeStats['completed']}'),
                _buildStatItem('In Progress', '${challengeStats['inProgress']}'),
                _buildStatItem('Success Rate', '${challengeStats['successRate']}%'),
              ],
              Icons.emoji_events,
              Colors.amber,
            ),

            const SizedBox(height: 16),

            // Medication Statistics
            _buildStatCard(
              context,
              'Medication Statistics',
              [
                _buildStatItem('Active Medications', '${medications.where((m) => m.isActive).length}'),
                _buildStatItem('Total Medications', '${medications.length}'),
                _buildStatItem('Adherence Rate', '92%'),
              ],
              Icons.medication,
              Colors.green,
            ),

            const SizedBox(height: 16),

            // Step Count Statistics
            _buildStatCard(
              context,
              'Step Count Statistics',
              [
                _buildStatItem('Daily Average', '${stepStats['dailyAverage']}'),
                _buildStatItem('Weekly Total', '${stepStats['weeklyTotal']}'),
                _buildStatItem('Monthly Total', '${stepStats['monthlyTotal']}'),
                _buildStatItem('Goal Achievement', '${stepStats['goalAchievement']}%'),
              ],
              Icons.directions_walk,
              Colors.orange,
            ),

            const SizedBox(height: 16),

            // Meal Statistics
            _buildStatCard(
              context,
              'Meal Statistics',
              [
                _buildStatItem('Total Meals', '${mealStats['totalMeals']}'),
                _buildStatItem('This Month', '${mealStats['thisMonth']}'),
                _buildStatItem('Healthy Meals', '${mealStats['healthyMeals']}'),
                _buildStatItem('Water Intake', '${mealStats['waterIntake']} L'),
              ],
              Icons.restaurant,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoCard(BuildContext context, userData) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    userData?.name.substring(0, 1).toUpperCase() ?? 'U',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData?.name ?? 'Emeka Pius',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userData?.email ?? 'emekapius@gmail.com',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBasicStatItem(
                  context,
                  'Height',
                  '${userData?.height.toStringAsFixed(1) ?? '0.0'} m',
                  Icons.height,
                ),
                _buildBasicStatItem(
                  context,
                  'Weight',
                  '${userData?.weight.toStringAsFixed(1) ?? '0.0'} kg',
                  Icons.monitor_weight,
                ),
                _buildBasicStatItem(
                  context,
                  'BMI',
                  _calculateBMI(userData?.height ?? 0, userData?.weight ?? 0),
                  Icons.health_and_safety,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _calculateBMI(double height, double weight) {
    if (height <= 0 || weight <= 0) return '0.0';
    final bmi = weight / (height * height);
    return bmi.toStringAsFixed(1);
  }

  Widget _buildBasicStatItem(BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    List<Widget> stats,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...stats,
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
