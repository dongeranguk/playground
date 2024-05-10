class PreferenceItem<T> {

  T defaultValue;
  String key;

  PreferenceItem(this.key, this.defaultValue);

  @override
  String toString() {
    return 'PreferenceItem{defaultValue: $defaultValue, key: $key}';
  }
}