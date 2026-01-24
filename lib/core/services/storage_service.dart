import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  static const String _boxName = 'secureBox';
  late Box _box;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
    _box = await Hive.openBox(_boxName);
  }

  Future<void> saveData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  dynamic getData(String key) {
    return _box.get(key);
  }

  Future<void> removeData(String key) async {
    await _box.delete(key);
  }
}
