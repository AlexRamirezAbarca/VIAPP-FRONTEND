import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/modules/change_password_page/models/token_change_password.dart';
import 'package:viapp/shared/models/general_response.dart';
import 'package:viapp/shared/services/http_interceptor.dart';

class ChangePasswordCodeServices {

final urlService = Environment().config?.serviceUrl ?? "no url";
  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future<GeneralResponse<TokenChangePassword>> validateCodePassword (BuildContext context, Map<String, String> data)async{
    try {
      GeneralResponse response = await interceptorHttp.request(context, 'POST', '${urlService}auth/recovery-password/get-code', data);
      
      late TokenChangePassword token;
      if (!response.error) {
       token = tokenChangePasswordFromJson(jsonEncode(response.data));
      }
      inspect(token.toString());
      return GeneralResponse(message: response.message, error: response.error,data: token  );
    }catch(error){
      debugPrint("Error en Validate Code ChangePassword $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }


  Future<GeneralResponse> sendChangePassword (BuildContext context, Map<String, dynamic> data) async {
    try {
      GeneralResponse response = await interceptorHttp.request(context, 'POST', '${urlService}auth/recovery-password/change-password', data);
      
      return GeneralResponse(message: response.message, error: response.error  );
    }catch(error){
      debugPrint("Error en Send ChangePassword $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }




}