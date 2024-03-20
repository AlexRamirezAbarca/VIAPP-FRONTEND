import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/modules/profile_page/models/profile_response.dart';
import 'package:viapp/shared/models/general_response.dart';
import 'package:viapp/shared/services/http_interceptor.dart';

class ProfileServices {
  final urlService = Environment().config?.serviceUrl ?? "no url";

  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future<GeneralResponse<ProfileResponse>> getProfile(
      BuildContext context) async {
    try {
      GeneralResponse response = await interceptorHttp.request(
          context, 'GET', '${urlService}profile', null);

      late ProfileResponse profileData;

      if (!response.error) {
        profileData = profileResponseFromJson(jsonEncode(response.data));
      }

      return GeneralResponse(
          error: response.error, data: profileData, message: response.message);
    } catch (error) {
      debugPrint("Error en Find Requests $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }
}
