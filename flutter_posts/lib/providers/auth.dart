import 'dart:convert';
import 'dart:html';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_posts/dio.dart';
import 'package:flutter_posts/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Auth extends ChangeNotifier {
  final storage = new FlutterSecureStorage();
  bool _authenticated = false;

  bool get authenticated => _authenticated;
  late User _user;
  User get user => _user;

  Future login({Map? credentials}) async {
    String deviceId = await getDeviceId();
    Dio.Response response = await dio().post(
      'auth/token',
      data: json.encode(credentials!..addAll({'deviceId': deviceId})),
    );

    String token = json.decode(response.toString())['token'];

    // print(token);
    await attempt(token);
    storeToken(token);
  }

  Future attempt(String token) async {
    try {
      Dio.Response response = await dio().get(
        'user',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // print(response.toString());
      _user = User.fromJson(
        json.decode(
          response.toString(),
        ),
      );
      _authenticated = true;
    } catch (e) {
      // print(e.toString());
      _authenticated = false;
    }
    notifyListeners();
  }

  Future getDeviceId() async {
    late String deviceId;
    try {
      deviceId = (await PlatformDeviceId.getDeviceId)!;
    } catch (e) {
      print('Error getting device ID: $e');
    }
    return deviceId;
  }

  storeToken(String token) async {
    await storage.write(key: 'auth', value: token);
  }

  Future getToken() async {
    return await storage.read(key: 'auth');
  }

  deleteToken() async {
    await storage.delete(key: 'auth');
  }


  void logout() async {
  _authenticated = false;

  String? token = await getToken();
  if (token != null) {
    try {
      await dio().delete(
        'auth/token',
        data: {'deviceId': await getDeviceId()},
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } catch (e) {
      print('Error deleting token: $e');
    }
  }

  deleteToken();
  notifyListeners();
}
}
