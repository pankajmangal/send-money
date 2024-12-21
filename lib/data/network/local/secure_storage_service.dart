import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  //access-token
  saveAccessToken(String value) async {
    await _saveData('accessToken', value);
  }

  Future<String> getAccessToken() async {
    String result = await _getData('accessToken');
    return result;
  }

  deleteAccessToken() async {
    await _deleteData('accessToken');
  }

  //refresh-token
  saveRefreshToken(String value) async {
    await _saveData('refreshToken', value);
  }

  Future<String> getRefreshToken() async {
    String result = await _getData('refreshToken');
    return result;
  }

  deleteRefreshToken() async {
    await _deleteData('refreshToken');
  }

  //test-data
  saveTestData(String value) async {
    await _saveData('test', value);
  }

  Future<String> getTestData() async {
    String result = await _getData('test');
    return result;
  }

  //common functions
  _saveData(String key, String value) async {
    await secureStorage.write(
      key: key,
      value: value,
    );
  }

  Future<String> _getData(String key) async {
    String result = await secureStorage.read(key: key) ?? "";
    return result;
  }

  _deleteData(String key) {
    secureStorage.delete(key: key);
  }
}