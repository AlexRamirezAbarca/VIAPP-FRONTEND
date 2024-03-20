import 'package:flutter/material.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/shared/models/general_response.dart';
import 'package:viapp/shared/services/http_interceptor.dart';

class ChangePasswordServices {
  final urlService = Environment().config?.serviceUrl ?? "no url";
  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future<GeneralResponse> validateEmailChangePassword (BuildContext context, Map<String, String> data)async{
    try {
      GeneralResponse response = await interceptorHttp.request(context, 'POST', '${urlService}auth/recovery-password', data);
      return GeneralResponse(message: response.message, error: response.error);
    }catch(error){
      debugPrint("Error en Validate Email ChangePassword $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }
}