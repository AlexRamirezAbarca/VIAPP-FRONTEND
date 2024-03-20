import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:viapp/shared/models/login_response.dart';

class UserDataStorage {
  final storage = const FlutterSecureStorage();

  Future<LoginResponse?> getUserData() async {
    final data = await storage.read(key: 'userData');
    if (data != null) {
      LoginResponse response = loginResponseFromJson(data);
      return response;
    }
    return null;
  }

  // Future<DataUserModel?> getUserCredentials() async {
  //   final data = await storage.read(key: 'userCredentials');
  //   if (data != null) {
  //     DataUserModel response = dataUserModelFromJson(data);
  //     return response;
  //   }
  //   return null;
  // }

  // void setUserCredentials(DataUserModel userModel) async {
  //   final data = jsonEncode(userModel);
  //   await storage.write(key: 'userCredentials', value: data);
  // }

  void setUserData(LoginResponse userData) async {
    final data = jsonEncode(userData);
    await storage.write(key: 'userData', value: data);
  }

  // Future<bool> verifyToken() async {
  //   final userData = await getUserData();
  //   if (userData != null) {
  //     //?: comprobamos si el token ya ha expirado
  //     bool hasExpired = JwtDecoder.isExpired(userData.token);
  //     if (!hasExpired) {
  //       return true;
  //     }
  //     return false;
  //   }
  //   return false;
  // }

  removeUserData() async {
    // await storage.deleteAll();
    await storage.delete(key: 'userData');
  }

  // removeUserCredentials() async {
  //   await storage.delete(key: 'userCredentials');
  // }
}
