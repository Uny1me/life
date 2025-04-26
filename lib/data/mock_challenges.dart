import 'package:aproko_app/models/challenge.dart';

final mockChallenges = [
  const Challenge(
    id: '1',
    name: 'Intermittent Fasting',
    description:
        'Challenge yourself with intermittent fasting to improve your metabolism and overall health. This challenge involves fasting for 16 hours and eating within an 8-hour window each day.',
    duration: Duration(days: 30),
    pictures: ['https://example.com/intermittent-fasting.jpg'],
    category: ChallengeCategory.nutrition,
    videoId: 'ZWn9Jn1LT9I',
  ),
  const Challenge(
    id: '2',
    name: 'OMAD Challenge',
    description:
        'One Meal A Day (OMAD) challenge to reset your eating habits and improve your relationship with food. Eat one nutritious meal per day within a 1-hour window.',
    duration: Duration(days: 21),
    pictures: ['https://example.com/omad.jpg'],
    category: ChallengeCategory.nutrition,
    videoId: 'JTz4OEkn0TQ',
  ),
  const Challenge(
    id: '3',
    name: '75 Hard',
    description:
        'A mental and physical challenge that requires you to follow a strict routine for 75 days. Includes two workouts per day, following a diet, reading 10 pages, and drinking a gallon of water daily.',
    duration: Duration(days: 75),
    pictures: ['https://example.com/75hard.jpg'],
    category: ChallengeCategory.fitness,
    videoId: 'JTz4OEkn0TQ',
  ),
  const Challenge(
    id: '4',
    name: 'Active April',
    description:
        'Get moving this April! Challenge yourself to walk 8,000 steps every day of the month. Track your progress and earn rewards for consistency.',
    duration: Duration(days: 30),
    pictures: ['https://example.com/active-april.jpg'],
    category: ChallengeCategory.fitness,
    videoId: 'JTz4OEkn0TQ',
  ),
  const Challenge(
    id: '5',
    name: 'Medication Mindfulness',
    description:
        'A 30-day challenge to build better medication habits. Track your medication schedule, set reminders, and maintain a medication journal to improve adherence.',
    duration: Duration(days: 30),
    pictures: ['https://example.com/medication-mindfulness.jpg'],
    category: ChallengeCategory.medication,
    videoId: 'BdFwUEGhZss',
  ),
  const Challenge(
    id: '6',
    name: 'Hydration Hero',
    description:
        'Stay hydrated and healthy! Challenge yourself to drink 8 glasses of water daily and track your water intake. Learn about the importance of proper hydration for medication effectiveness.',
    duration: Duration(days: 21),
    pictures: ['https://example.com/hydration-hero.jpg'],
    category: ChallengeCategory.medication,
    videoId: 'BdFwUEGhZss',
  ),
];
