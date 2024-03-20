import 'package:flutter/material.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/shared/models/general_response.dart';
import 'package:viapp/shared/services/http_interceptor.dart';

class RegisterService {
  final urlService = Environment().config?.serviceUrl ?? "no url";
  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future<GeneralResponse> register(BuildContext context, Map<String, dynamic> body) async {
    try {
      GeneralResponse response = await interceptorHttp.request(context, 'POST', '${urlService}auth/register', body);

      // if (!response.error) {}
      return GeneralResponse(message: response.message, data: response.data, error: response.error);
      
    } catch (error) {
      debugPrint("Error en register $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }
}
