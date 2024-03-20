import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/modules/home_page/models/my_requests_response.dart';
import 'package:viapp/modules/home_page/models/requests_response.dart';
import 'package:viapp/shared/models/general_response.dart';
import 'package:viapp/shared/services/http_interceptor.dart';

class RequestServices {
  final urlService = Environment().config?.serviceUrl ?? "no url";
  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future<GeneralResponse<RequestResponse>> findRequests(
      BuildContext context) async {
    try {
      GeneralResponse response = await interceptorHttp.request(
          context, 'GET', '${urlService}requests/list', null);

      late RequestResponse requestData;

      if (!response.error) {
        requestData = requestResponseFromJson(jsonEncode(response.data));
      }
      inspect(requestData.requests[0].descriptionRequest);
      return GeneralResponse(
          error: response.error, data: requestData, message: response.message);
    } catch (error) {
      debugPrint("Error en Find Requests $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }

  Future<GeneralResponse<MyRequests>> findMyRequests(
      BuildContext context) async {
    try {
      GeneralResponse response = await interceptorHttp.request(
          context, 'GET', '${urlService}requests/list-requests-user', null);

      late MyRequests myRequestData;

      if (!response.error) {
        myRequestData = myRequestsFromJson(jsonEncode(response.data));
      }
      return GeneralResponse(
          error: response.error, data: myRequestData, message: response.message);
    } catch (error) {
      debugPrint("Error en Find Requests $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }

}
