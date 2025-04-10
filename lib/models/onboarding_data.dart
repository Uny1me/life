class OnboardingData {
  final String title;
  final String description;
  final String imagePath;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

final List<OnboardingData> onboardingData = [
  OnboardingData(
    title: 'Aproko Doctor welcomes you',
    description: 'To your personal health, lifestyle and fitness companion',
    imagePath: 'assets/images/onboarding-1.png',
  ),
  OnboardingData(
    title: 'Stay Healthy',
    description: 'Get personalized nutrition and lifestyle recommendations',
    imagePath: 'assets/images/onboarding-2.jpg',
  ),
  OnboardingData(
    title: 'Track Your Progress',
    description: 'Monitor your fitness journey and achieve your goals',
    imagePath: 'assets/images/onboarding-3.png',
  ),
];
