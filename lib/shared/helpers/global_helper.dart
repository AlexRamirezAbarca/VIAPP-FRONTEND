import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../../modules/not_found_page/pages/page_404.dart';
import '../routes/app_routes.dart';

class GlobalHelper {
  static slideTransitionNavigationPage(BuildContext context, String routeName, {String? type}) {
    final route = AppRoutes.routes[routeName];
    final page = (route != null) ? route.call(context) : const PageNotFound();

    Navigator.push(context, slideTransition(context, page));
  }

  static Route slideTransition(BuildContext context, Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 2000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.fastOutSlowIn;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static navigateToPage(BuildContext context, String routeName, {String? type}) {
    final route = AppRoutes.routes[routeName];
    switch (type) {
      case 'android':
        final page = (route != null) ? route.call(context) : const PageNotFound();
        Navigator.push(context, navigationFadeIn(context, page));
        // Navigator.push(context,
        // MaterialPageRoute(builder: route ?? (context) => const PageNotFound()));
        break;
      case 'ios':
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: route ?? (context) => const PageNotFound()));
        // Navigator.push(context,
        // CupertinoPageRoute(builder: route ?? (context) => const PageNotFound()));
        break;
      default:
        final page = (route != null) ? route.call(context) : const PageNotFound();
        Navigator.pushReplacement(context, navigationFadeIn(context, page));
      //  final page = (route!=null)?route.call(context):const PageNotFound();
      //   Navigator.pushReplacement(context,
      //                         navigationFadeIn(
      //                             context, page, 1600));
    }
  }

  static navigateToPageRemove(BuildContext context, String routeName) {
    final route = AppRoutes.routes[routeName];
    final page = (route != null) ? route.call(context) : const PageNotFound();
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        fullscreenDialog: true,
         reverseTransitionDuration: const Duration(milliseconds: 100),
        transitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: page,
        ),
      ),
      (route) => false,
    );
  }

  static Route navigationFadeIn(BuildContext context, Widget page) {
    return PageRouteBuilder(
      fullscreenDialog: true,
      reverseTransitionDuration: const Duration(milliseconds: 100),
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
    );
  }

  static GlobalKey genKey() {
    GlobalKey key = GlobalKey();
    return key;
  }

  static String device = (Platform.isAndroid) ? "android" : "ios";

  static final logger = Logger(printer: PrettyPrinter(methodCount: 0, printEmojis : false));

  //? Quita el teclado
  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  identificationValidator(String number, String type) {
    switch (type) {
      case 'ci':
        return _ciValidator(number);
      case 'ruc':
        return _rucValidator(number);
      default:
        return false;
    }
  }

  bool _ciValidator(String cedula) {
    try {
      if (cedula.length == 10) {
        //Obtenemos el digito de la region que sonlos dos primeros digitos
        final digitoRegion = int.parse(cedula.substring(0, 2));

        //Pregunto si la region existe ecuador se divide en 24 regiones
        if (digitoRegion >= 1 && digitoRegion <= 24) {
          // Extraigo el ultimo digito
          final ultimoDigito = int.parse(cedula.substring(9, 10));

          //Agrupo todos los pares y los sumo
          var pares = int.parse(cedula.substring(1, 2)) +
              int.parse(cedula.substring(3, 4)) +
              int.parse(cedula.substring(5, 6)) +
              int.parse(cedula.substring(7, 8));

          //Agrupo los impares, los multiplico por un factor de 2, si la resultante es > que 9 le restamos el 9 a la resultante
          var numero1 = int.parse(cedula.substring(0, 1));
          numero1 = (numero1 * 2);
          if (numero1 > 9) {
            numero1 = (numero1 - 9);
          }

          var numero3 = int.parse(cedula.substring(2, 3));
          numero3 = (numero3 * 2);
          if (numero3 > 9) {
            numero3 = (numero3 - 9);
          }

          var numero5 = int.parse(cedula.substring(4, 5));
          numero5 = (numero5 * 2);
          if (numero5 > 9) {
            numero5 = (numero5 - 9);
          }

          var numero7 = int.parse(cedula.substring(6, 7));
          numero7 = (numero7 * 2);
          if (numero7 > 9) {
            numero7 = (numero7 - 9);
          }

          var numero9 = int.parse(cedula.substring(8, 9));
          numero9 = (numero9 * 2);
          if (numero9 > 9) {
            numero9 = (numero9 - 9);
          }

          var impares = numero1 + numero3 + numero5 + numero7 + numero9;

          //Suma total
          final sumaTotal = (pares + impares);

          //extraemos el primero digito
          final primerDigitoSuma = sumaTotal.toString().substring(0, 1);

          //Obtenemos la decena inmediata
          var decena = (int.parse(primerDigitoSuma) + 1) * 10;

          //Obtenemos la resta de la decena inmediata - la suma_total esto nos da el digito validador
          var digitoValidador = decena - sumaTotal;

          //Si el digito validador es = a 10 toma el valor de 0
          if (digitoValidador == 10) {
            digitoValidador = 0;
          }

          //Validamos que el digito validador sea igual al de la cedula
          if (digitoValidador == ultimoDigito) {
            return true;
          } else {
            return false;
          }
        } else {
          // imprimimos en consola si la region no pertenece
          return false;
        }
      } else {
        //imprimimos en consola si la cedula tiene mas o menos de 10 digitos
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  List<bool> _rucValidator(String ruc) {
    try {
      if (ruc.length == 13) {
        final digitoRegion = int.parse(ruc.substring(0, 2));
        final numero3 = int.parse(ruc[2]);
        if (numero3 == 7 || numero3 == 8) return [false, false];

        final ultimos3 = ruc.substring(10, 13);
        final ultimos4 = ruc.substring(9, 13);
        if (digitoRegion >= 1 && digitoRegion <= 24) {
          if (numero3 > -1 && numero3 <= 5) {
            final ciValid = _ciValidator(ruc.substring(0, 10));
            if (ciValid && ultimos3 == '001') {
              return [true, true];
            }
            return [false, false];
          }
          if (numero3 == 6) {
            final spValid = _juridicaPublica(ruc, 'pub');
            if (spValid && ultimos4 == '0001') {
              return [true, false];
            }
            return [false, false];
          }
          if (numero3 == 9) {
            final jurValid = _juridicaPublica(ruc, 'jur');
            if (jurValid && ultimos3 == '001') {
              return [true, false];
            }
            return [false, false];
          }
          return [false, false];
        } else {
          return [false, false];
        }
      } else {
        return [false, false];
      }
    } catch (e) {
      return [false, false];
    }
  }

  bool _juridicaPublica(String ruc, String type) {
    int verificador = 0;
    List<int> coeficientes = [];
    switch (type) {
      case 'jur':
        verificador = 9;
        coeficientes = [4, 3, 2, 7, 6, 5, 4, 3, 2];
        break;
      case 'pub':
        verificador = 8;
        coeficientes = [3, 2, 7, 6, 5, 4, 3, 2];
        break;
    }
    var dVerificador = int.parse(ruc[verificador]);
    if (dVerificador > 0) {
      int prod;
      int aux = 0;

      for (int i = 0; i < verificador; i++) {
        var digito = int.parse(ruc[i]);
        prod = digito * coeficientes[i];
        aux += prod;
      }
      if (aux % 11 == 0) {
        dVerificador = 0;
      } else if (aux % 11 == 1) {
        return false;
      } else {
        aux = aux % 11;
        dVerificador = 11 - aux;
      }
      if (dVerificador == int.parse(ruc[verificador])) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
