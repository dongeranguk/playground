import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/app.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  initializeDateFormatting().then((_) => runApp(const ProviderScope(child: WiseApp())));
}