import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/shared/models/catalogue_response.dart';
import 'package:viapp/shared/models/general_response.dart';
import 'package:viapp/shared/services/http_interceptor.dart';

class CatalogueService {
  final urlService = Environment().config?.serviceUrl ?? "no url";
  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future<GeneralResponse<CatalogueResponse>> getCatalogue(BuildContext context) async {
    try {
      GeneralResponse response = await interceptorHttp.request(context, 'GET', '${urlService}catalogue', null);

      late CatalogueResponse catalogueData;
      if (!response.error) {
        catalogueData = catalogueResponseFromJson(jsonEncode(response.data));
      }
      return GeneralResponse(error: response.error, data: catalogueData, message: response.message);
    } catch (error) {
      debugPrint("Error en getCatalogue $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }
}
