import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:playground/app.dart';
import 'package:playground/common/data/preference/appPreferences.riverpod.dart';
import 'package:playground/common/firebase/DynamicLink.dart';

import 'common/data/local/local_db.dart';
import 'firebase_options.dart';

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await LocalDB.init();
  //await LocalDB.restore();
  await AppPreferences.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DynamicLink.setUp();

  initializeDateFormatting().then((_) => runApp(const ProviderScope(child: WiseApp())));
}