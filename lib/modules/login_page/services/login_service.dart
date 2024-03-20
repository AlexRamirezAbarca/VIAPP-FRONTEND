import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/models/general_response.dart';
import 'package:viapp/shared/models/login_response.dart';
import 'package:viapp/shared/secure/user_data_storage.dart';
import 'package:viapp/shared/services/http_interceptor.dart';

class LoginService {
  final urlService = Environment().config?.serviceUrl ?? "no url";
  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future login(BuildContext context, Map<String, String> data) async {
    try {
      GeneralResponse response = await interceptorHttp.request(
          context, 'POST', '${urlService}auth/login', data);

      late LoginResponse userData;

      if (!response.error) {
        userData = loginResponseFromJson(jsonEncode(response.data));
        UserDataStorage().setUserData(userData);
        if (context.mounted) {
          GlobalHelper.navigateToPageRemove(context, '/transition_page');
        }
      }
    } catch (error) {
      debugPrint("Error en Login $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }
}
