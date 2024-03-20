import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:viapp/modules/login_page/pages/login_page.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/models/general_response.dart';
import 'package:viapp/shared/models/login_response.dart';
import 'package:viapp/shared/secure/user_data_storage.dart';
import 'package:viapp/shared/widgets/alerts_template.dart';

import '../providers/functional_provider.dart';

class InterceptorHttp {
  Future<GeneralResponse> request(
    BuildContext context,
    String method,
    String urlEndPoint,
    dynamic body, {
    bool showLoading = true,
    Map<String, dynamic>? queryParameters,
    List<http.MultipartFile>? multipartFiles,
    Map<String, String>? multipartFields,
    String requestType = "JSON",
    Function(int sendBytes, int totalBytes)? onProgressLoad,
  }) async {
    String url = "$urlEndPoint?${Uri(queryParameters: queryParameters).query}";
    debugPrint("U R L $url");
    GeneralResponse generalResponse =
        GeneralResponse(data: null, message: "", error: true);

    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final keyLoading = GlobalHelper.genKey();

    String? messageButton;
    void Function()? onPress;

    try {
      http.Response _response;
      Uri uri = Uri.parse(url);

      if (showLoading) {
        debugPrint("KeyLoading del interceptor: $keyLoading");
        fp.showAlert(key: keyLoading, content: const AlertLoading());
        await Future.delayed(const Duration(milliseconds: 600));
      }

      //? Envio de TOKEN
      LoginResponse? userData = await UserDataStorage().getUserData();

      String tokenSesion = "";

      if (userData != null) {
        tokenSesion = userData.token;
      }

      Map<String, String> _headers = {
        "Content-Type": "application/json",
        "Authorization": (requestType == 'JSON') ? tokenSesion : tokenSesion,
      };

      int responseStatusCode = 0;
      String responseBody = "";

      switch (requestType) {
        case "JSON":
          switch (method) {
            case "POST":
              _response = await http.post(uri,
                  headers: _headers,
                  body: body != null ? json.encode(body) : null);
              inspect(_response);
              break;
            case "GET":
              _response = await http.get(uri, headers: _headers);
              inspect(_response);
              break;
            case "PUT":
              _response = await http.put(uri,
                  headers: _headers,
                  body: body != null ? json.encode(body) : null);
              inspect(_response);
              break;
            case "PATCH":
              _response = await http.patch(uri,
                  headers: _headers,
                  body: body != null ? json.encode(body) : null);
            default:
              _response = await http.post(uri, body: jsonEncode(body));
          }
          responseStatusCode = _response.statusCode;
          responseBody = _response.body;

          GlobalHelper.logger.log(Level.trace, json.decode(responseBody));
          break;

        case "FORM":
          final httpClient = getHttpClient();
          final request = await httpClient.postUrl(Uri.parse(url));
          int byteCount = 0;
          var requestMultipart = http.MultipartRequest(method, Uri.parse(url));
          if (multipartFiles != null) {
            requestMultipart.files.addAll(multipartFiles);
          }
          if (multipartFields != null) {
            requestMultipart.fields.addAll(multipartFields);
          }

          _headers.forEach((key, value) {
            request.headers.set("token", tokenSesion);
          });

          debugPrint("TOKEN CARGADO");

          var msStream = requestMultipart.finalize();

          var totalByteLength = requestMultipart.contentLength;

          request.contentLength = totalByteLength;

          request.headers.set(HttpHeaders.contentTypeHeader,
              requestMultipart.headers[HttpHeaders.contentTypeHeader]!);

          Stream<List<int>> streamUpload = msStream.transform(
            StreamTransformer.fromHandlers(
              handleData: (data, sink) {
                sink.add(data);

                byteCount += data.length;

                if (onProgressLoad != null) {
                  onProgressLoad(byteCount, totalByteLength);
                }
              },
              handleError: (error, stack, sink) {
                generalResponse.error = true;
                throw error;
              },
              handleDone: (sink) {
                sink.close();
                // UPLOAD DONE;
              },
            ),
          );

          await request.addStream(streamUpload);

          final httpResponse = await request.close();
          var statusCode = httpResponse.statusCode;

          responseStatusCode = statusCode;
          if (statusCode ~/ 100 != 2) {
            throw Exception(
                'Error uploading file, Status code: ${httpResponse.statusCode}');
          } else {
            await for (var data in httpResponse.transform(utf8.decoder)) {
              responseBody = data;
            }
          }
          break;
      }
      //debugPrint(responseStatusCode.toString());
      switch (responseStatusCode) {
        case 200:
          var responseDecoded = json.decode(responseBody);
          generalResponse.data = responseDecoded["data"];
          generalResponse.message = responseDecoded["message"];
          generalResponse.error = false;
          //fp.dismissAlert(key: keyLoading);
          // if (responseDecoded["error"]) {
          //     generalResponse.error = true;
          //     generalResponse.message = responseDecoded["message"];
          //     debugPrint('HAY ERROR');
          //     fp.dismissAlert(key: keyLoading);
          //  // }
          // } else {
          //   generalResponse.error = false;
          //   generalResponse.message = responseDecoded["message"];
          //   debugPrint('NO HAY ERROR');
          //   fp.dismissAlert(key: keyLoading);
          // }
          break;
        case 307:
          generalResponse.error = true;
          generalResponse.message =
              "Ocurrió un error al consultar con los servicios. Intente con una red que le permita el acceso";
          fp.dismissAlert(key: keyLoading);
          break;
        case 401:
          var responseDecoded = json.decode(responseBody);
          if ((generalResponse.message = responseDecoded["message"]) == 'Lo sentimos, el token enviado no es válido.') {
            debugPrint('Token invalido');
            generalResponse.message = 'Su sesión ha caducado, vuelva a iniciar sesión.';
            generalResponse.error = true;
            messageButton = 'Volver a ingresar';
            onPress = () async {
              fp.clearAllAlert();
              Navigator.pushAndRemoveUntil(
                  context,
                  GlobalHelper.navigationFadeIn(context, const LoginPage()),
                  (route) => false);
              //Navigator.pushReplacement(context, GlobalHelper.navigationFadeIn(context, const LoginPage()));
              await UserDataStorage().removeUserData();
              //fp.dismissAlert(key: LayoutHomeWidget.keyModalProfile);
            };
          } else {
            debugPrint('normal');
            generalResponse.error = true;
            fp.dismissAlert(key: keyLoading);
          }
          break;
        default:
          generalResponse.error = true;
          generalResponse.message = json.decode(responseBody)["message"];
          fp.dismissAlert(key: keyLoading);
          break;
      }
    } on TimeoutException catch (e) {
      debugPrint('$e');
      generalResponse.error = true;
      generalResponse.message = 'Tiempo de conexión excedido.';
    } on FormatException catch (ex) {
      debugPrint(ex.toString());
    } on SocketException catch (exSock) {
      debugPrint("Error por conexion -> ${exSock.toString()}");
      generalResponse.error = true;
      //generalResponse.message = exSock.toString();
      generalResponse.message =
          "Verifique su conexión a internet y vuelva a intentar.";
      fp.dismissAlert(key: keyLoading);
    } on Exception catch (e, stacktrace) {
      debugPrint("Error en request -> ${stacktrace.toString()}");
      generalResponse.error = true;
      generalResponse.message = "Ocurrio un error, vuelva a intentarlo.";
    }

    if (!generalResponse.error) {
      if (showLoading) {
        fp.dismissAlert(key: keyLoading);
      }
    } else {
      final keyError = GlobalHelper.genKey();
      debugPrint("Key de error del Interceptor: $keyError");
      fp.showAlert(
        key: keyError,
        content: AlertGeneric(
          content: ErrorGeneric(
            keyToClose: keyError,
            message: generalResponse.message,
            messageButton: messageButton,
            onPress: onPress,
          ),
        ),
      );
    }
    return generalResponse;
  }

  HttpClient getHttpClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
      // print(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}
