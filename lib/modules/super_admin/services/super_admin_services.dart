import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/modules/super_admin/models/pending_requests.dart';
import 'package:viapp/modules/super_admin/models/users_reponse.dart';
import 'package:viapp/shared/models/general_response.dart';
import 'package:viapp/shared/services/http_interceptor.dart';

class SuperAdminServices {
  final urlService = Environment().config?.serviceUrl ?? "no url";
  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future<GeneralResponse> getReportsRequests(BuildContext context) async {
    try {
      GeneralResponse response = await interceptorHttp.request(
          context, 'GET', '${urlService}requests/report-pdf', null);

      return GeneralResponse(error: response.error, message: response.message);
    } catch (error) {
      debugPrint("Error en Get Reports Requests $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }

  Future<GeneralResponse<PendingRequests>> getPendingRequests(
      BuildContext context, String statusRequests) async {
    try {
      GeneralResponse response = await interceptorHttp.request(
          context, 'GET', '${urlService}requests/list-requests', null, queryParameters: {
            'status_request' : statusRequests
          });

      late PendingRequests pendingRequests;

      if (!response.error) {
        pendingRequests = pendingRequestsFromJson(jsonEncode(response.data));
      }

      return GeneralResponse(
          message: response.message,
          error: response.error,
          data: pendingRequests);
    } catch (error) {
      debugPrint("Error en get Pending Requests $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }

  Future<GeneralResponse> acceptRequest(
      BuildContext context, Map<String, int> data) async {
    try {
      GeneralResponse response = await interceptorHttp.request(
          context, 'POST', '${urlService}requests/update', data);
      return GeneralResponse(message: response.message, error: response.error);
    } catch (error) {
      debugPrint("Error en Accept Requests $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }

  Future<GeneralResponse> declineRequest(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      GeneralResponse response = await interceptorHttp.request(
          context, 'POST', '${urlService}requests/update', data);
      return GeneralResponse(message: response.message, error: response.error);
    } catch (error) {
      debugPrint("Error en Decline Requests $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }

  Future<GeneralResponse<UserResponse>> getAllUsers(
      BuildContext context) async {
    try {
      GeneralResponse response = await interceptorHttp.request(
          context, 'GET', '${urlService}user/list', null);

      late UserResponse userResponse;

      if (!response.error) {
        userResponse = userResponseFromJson(jsonEncode(response.data));
      }

      return GeneralResponse(
          message: response.message,
          error: response.error,
          data: userResponse);
    } catch (error) {
      debugPrint("Error en get All Users $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }

  Future<GeneralResponse> updateStatusUsers(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      GeneralResponse response = await interceptorHttp.request(
          context, 'POST', '${urlService}user/update-status', data);
      return GeneralResponse(message: response.message, error: response.error);
    } catch (error) {
      debugPrint("Error en updateStatusUsers $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }
}
