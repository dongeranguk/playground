import 'package:playground/common/data/preference/PreferenceItem.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'appPreferences.riverpod.g.dart';

@riverpod
class AppPreferences extends _$AppPreferences {
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  FutureOr<List<PreferenceItem<dynamic>>> build() async {
    List<PreferenceItem<dynamic>> appPreferences = List.empty(growable: true);
    for (String key in _prefs.getKeys()) {
      appPreferences.add(PreferenceItem(key, _prefs.get(key)));
    }
    print('appPreferences : ${appPreferences.toString()}');
    return appPreferences;
  }

  void setPref(PreferenceItem preferenceItem) {
    Type type = preferenceItem.defaultValue.runtimeType;

    Future<bool> result = switch (type) {
      String _ => _prefs.setString(preferenceItem.key, preferenceItem.defaultValue),
      int _ => _prefs.setInt(preferenceItem.key, preferenceItem.defaultValue),
      bool _ => _prefs.setBool(preferenceItem.key, preferenceItem.defaultValue),
      double _ => _prefs.setDouble(preferenceItem.key, preferenceItem.defaultValue),
      _ => Future.value(false),
    };

    result.then((value) {
      if(value) {
        print('save Succeded');
      } else {
        print('save Failed');
      }
    });
  }

  String? getPref(String key) {
    return _prefs.getString(key);
  }
}
