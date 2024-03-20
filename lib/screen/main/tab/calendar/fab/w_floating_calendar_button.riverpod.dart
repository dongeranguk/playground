import 'package:flutter_riverpod/flutter_riverpod.dart';

final floatingButtonSelectedDayProvider = StateProvider<DateTime?>((ref) => null);
final floatingButtonFromProvider = StateProvider((ref) => DateTime.now());
final floatingButtonToProvider = StateProvider((ref) => DateTime.now().add(const Duration(days: 1)));

