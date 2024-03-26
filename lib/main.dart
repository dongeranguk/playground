import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/app.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'common/data/local/local_db.dart';

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await LocalDB.init();
  //await LocalDB.restore();
  initializeDateFormatting().then((_) => runApp(const ProviderScope(child: WiseApp())));
}