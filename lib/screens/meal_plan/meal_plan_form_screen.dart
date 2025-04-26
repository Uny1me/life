import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/meal_plan.dart';
import 'package:go_router/go_router.dart';

class MealPlanFormScreen extends StatefulWidget {
  const MealPlanFormScreen({super.key});

  @override
  State<MealPlanFormScreen> createState() => _MealPlanFormScreenState();
}

class _MealPlanFormScreenState extends State<MealPlanFormScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Form fields
  double _height = 170;
  double _weight = 70;
  WeightGoal? _selectedGoal;
  final List<String> _selectedFoods = [];

  double get _bmi => _weight / ((_height / 100) * (_height / 100));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/nutrition'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Create Your Meal Plan'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            _generateMealPlan();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: const Text('Basic Information'),
            content: _buildBasicInfoStep(),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Your Goal'),
            content: _buildGoalStep(),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Food Preferences'),
            content: _buildFoodPreferencesStep(),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return Column(
      children: [
        Text(
          'Your BMI: ${_bmi.toStringAsFixed(1)}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextButton(
          onPressed: () => _showBMIModal(context),
          child: const Text('What does this mean?'),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: _height.toString(),
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                  suffixText: 'cm',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _height = double.tryParse(value) ?? _height;
                  });
                },
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: TextFormField(
                initialValue: _weight.toString(),
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  suffixText: 'kg',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _weight = double.tryParse(value) ?? _weight;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGoalStep() {
    return Column(
      children: [
        RadioListTile<WeightGoal>(
          title: const Text('Lose weight by eating more controlled meals'),
          value: WeightGoal.lose,
          groupValue: _selectedGoal,
          onChanged: (value) => setState(() => _selectedGoal = value),
        ),
        RadioListTile<WeightGoal>(
          title: const Text('Maintain my weight and eat healthy'),
          value: WeightGoal.maintain,
          groupValue: _selectedGoal,
          onChanged: (value) => setState(() => _selectedGoal = value),
        ),
        RadioListTile<WeightGoal>(
          title: const Text('Gain weight the right way'),
          value: WeightGoal.gain,
          groupValue: _selectedGoal,
          onChanged: (value) => setState(() => _selectedGoal = value),
        ),
        if (_selectedGoal != null && _selectedGoal == WeightGoal.gain && _bmi >= 25)
          Padding(
            padding: EdgeInsets.all(16.w),
            child: const Text(
              'Aproko Doctor Says: While we support your goals, gaining weight may not be the best choice given your current BMI. Consider consulting with a healthcare professional.',
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFoodPreferencesStep() {
    final nigerianFoods = [
      'Eba',
      'Semo',
      'Amala',
      'Beans',
      'Plantain',
      'Egusi',
      'Jollof Rice',
      'Pounded Yam',
      'Ofada Rice',
      'Moi Moi',
      'Akara',
      'Banga Soup',
      'Oha Soup',
      'Bitter Leaf Soup',
      'Efo Riro',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select at least 5 foods you enjoy:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: nigerianFoods.map((food) {
            final isSelected = _selectedFoods.contains(food);
            return FilterChip(
              label: Text(food),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedFoods.add(food);
                  } else {
                    _selectedFoods.remove(food);
                  }
                });
              },
            );
          }).toList(),
        ),
        if (_selectedFoods.length < 5)
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Text(
              'Please select ${5 - _selectedFoods.length} more foods',
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  void _showBMIModal(BuildContext context) {
    final bmiCategory = BMICategory.getCategory(_bmi);
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bmiCategory.category,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: bmiCategory.color,
                  ),
            ),
            SizedBox(height: 16.h),
            Text(bmiCategory.description),
            SizedBox(height: 16.h),
            Text(
              'Recommendation:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(bmiCategory.recommendation),
          ],
        ),
      ),
    );
  }

  void _generateMealPlan() {
    context.go('/meal-plan-loading');
    // TODO: Implement meal plan generation
    // This will navigate to the loading screen and then to the pricing screen
  }
}
