import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsProvider with ChangeNotifier {
  static const String _allNotificationsKey = 'all_notifications_enabled';
  static const String _sedentaryReminderKey = 'sedentary_reminder_enabled';
  static const String _medicationsKey = 'medications_enabled';
  static const String _eatingReminderKey = 'eating_reminder_enabled';
  static const String _fitnessChallengesKey = 'fitness_challenges_enabled';
  static const String _waterReminderKey = 'water_reminder_enabled';
  static const String _sedentaryHoursKey = 'sedentary_hours';
  static const String _medicationsHoursKey = 'medications_hours';
  static const String _eatingHoursKey = 'eating_hours';
  static const String _waterHoursKey = 'water_hours';
  static const String _sedentaryMinutesKey = 'sedentary_minutes';
  static const String _medicationsMinutesKey = 'medications_minutes';
  static const String _eatingMinutesKey = 'eating_minutes';
  static const String _waterMinutesKey = 'water_minutes';

  bool _allNotificationsEnabled = true;
  bool _sedentaryReminderEnabled = true;
  bool _medicationsEnabled = true;
  bool _eatingReminderEnabled = true;
  bool _fitnessChallengesEnabled = true;
  bool _waterReminderEnabled = true;
  String _sedentaryHours = '2';
  String _medicationsHours = '2';
  String _eatingHours = '2';
  String _waterHours = '1';
  String _sedentaryMinutes = '0';
  String _medicationsMinutes = '0';
  String _eatingMinutes = '0';
  String _waterMinutes = '30';

  bool get allNotificationsEnabled => _allNotificationsEnabled;
  bool get sedentaryReminderEnabled => _sedentaryReminderEnabled;
  bool get medicationsEnabled => _medicationsEnabled;
  bool get eatingReminderEnabled => _eatingReminderEnabled;
  bool get fitnessChallengesEnabled => _fitnessChallengesEnabled;
  bool get waterReminderEnabled => _waterReminderEnabled;
  String get sedentaryHours => _sedentaryHours;
  String get medicationsHours => _medicationsHours;
  String get eatingHours => _eatingHours;
  String get waterHours => _waterHours;
  String get sedentaryMinutes => _sedentaryMinutes;
  String get medicationsMinutes => _medicationsMinutes;
  String get eatingMinutes => _eatingMinutes;
  String get waterMinutes => _waterMinutes;

  NotificationSettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _allNotificationsEnabled = prefs.getBool(_allNotificationsKey) ?? true;
    _sedentaryReminderEnabled = prefs.getBool(_sedentaryReminderKey) ?? true;
    _medicationsEnabled = prefs.getBool(_medicationsKey) ?? true;
    _eatingReminderEnabled = prefs.getBool(_eatingReminderKey) ?? true;
    _fitnessChallengesEnabled = prefs.getBool(_fitnessChallengesKey) ?? true;
    _waterReminderEnabled = prefs.getBool(_waterReminderKey) ?? true;
    _sedentaryHours = prefs.getString(_sedentaryHoursKey) ?? '2';
    _medicationsHours = prefs.getString(_medicationsHoursKey) ?? '2';
    _eatingHours = prefs.getString(_eatingHoursKey) ?? '2';
    _waterHours = prefs.getString(_waterHoursKey) ?? '1';
    _sedentaryMinutes = prefs.getString(_sedentaryMinutesKey) ?? '0';
    _medicationsMinutes = prefs.getString(_medicationsMinutesKey) ?? '0';
    _eatingMinutes = prefs.getString(_eatingMinutesKey) ?? '0';
    _waterMinutes = prefs.getString(_waterMinutesKey) ?? '30';
    notifyListeners();
  }

  Future<void> setAllNotifications(bool value) async {
    _allNotificationsEnabled = value;
    if (!value) {
      _sedentaryReminderEnabled = false;
      _medicationsEnabled = false;
      _eatingReminderEnabled = false;
      _fitnessChallengesEnabled = false;
      _waterReminderEnabled = false;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_allNotificationsKey, value);
    notifyListeners();
  }

  Future<void> setSedentaryReminder(bool value) async {
    _sedentaryReminderEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sedentaryReminderKey, value);
    notifyListeners();
  }

  Future<void> setMedications(bool value) async {
    _medicationsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_medicationsKey, value);
    notifyListeners();
  }

  Future<void> setEatingReminder(bool value) async {
    _eatingReminderEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_eatingReminderKey, value);
    notifyListeners();
  }

  Future<void> setFitnessChallenges(bool value) async {
    _fitnessChallengesEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_fitnessChallengesKey, value);
    notifyListeners();
  }

  Future<void> setWaterReminder(bool value) async {
    _waterReminderEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_waterReminderKey, value);
    notifyListeners();
  }

  Future<void> setSedentaryHours(String hours) async {
    _sedentaryHours = hours;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sedentaryHoursKey, hours);
    notifyListeners();
  }

  Future<void> setMedicationsHours(String hours) async {
    _medicationsHours = hours;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_medicationsHoursKey, hours);
    notifyListeners();
  }

  Future<void> setEatingHours(String hours) async {
    _eatingHours = hours;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_eatingHoursKey, hours);
    notifyListeners();
  }

  Future<void> setWaterHours(String hours) async {
    _waterHours = hours;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_waterHoursKey, hours);
    notifyListeners();
  }

  Future<void> setSedentaryMinutes(String minutes) async {
    _sedentaryMinutes = minutes;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sedentaryMinutesKey, minutes);
    notifyListeners();
  }

  Future<void> setMedicationsMinutes(String minutes) async {
    _medicationsMinutes = minutes;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_medicationsMinutesKey, minutes);
    notifyListeners();
  }

  Future<void> setEatingMinutes(String minutes) async {
    _eatingMinutes = minutes;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_eatingMinutesKey, minutes);
    notifyListeners();
  }

  Future<void> setWaterMinutes(String minutes) async {
    _waterMinutes = minutes;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_waterMinutesKey, minutes);
    notifyListeners();
  }
}
