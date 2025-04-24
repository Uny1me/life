import 'package:aproko_app/core/mock/mock_app_use_cases.dart';
import 'package:aproko_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class AppUseCase extends StatefulWidget {
  const AppUseCase({super.key});

  @override
  AppUseCaseState createState() => AppUseCaseState();
}

class AppUseCaseState extends State<AppUseCase> {
  final List<String> _selectedAppUseCases = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: '',
        showThemeToggle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'What would like Aproko Doctor to help you do better?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 2,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                ...mockAppUseCases.map((e) => FilterChip(
                    label: Text(e),
                    selected: _selectedAppUseCases.contains(e),
                    onSelected: (value) {
                      setState(() {
                        _selectedAppUseCases.contains(e) ? _selectedAppUseCases.remove(e) : _selectedAppUseCases.add(e);
                      });
                    })),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isFirstTime', false);
                // ignore: use_build_context_synchronously
                context.go('/login');
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
