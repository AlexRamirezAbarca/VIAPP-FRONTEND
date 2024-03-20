
import 'package:flutter/material.dart';

import '../widgets/alerts_template.dart';

class FunctionalProvider extends ChangeNotifier {
  List<Widget> alerts = [];
  //? Se utilizara en paginas normales
  AnimationController? alertController;
  AnimationController? alertControllerContent;
  //? Se utilizara en las Notificaciones
  AnimationController? notificationController;

  showAlert({required GlobalKey key, required Widget content, bool closeAlert = false, bool animation = true}) {
    //final keyAlert = GlobalHelper.genKey();

    final newAlert = Container(
      key: key,
      color: Colors.transparent,
      child: AlertTemplate(content: content, keyToClose: key, dismissAlert: closeAlert, animation: animation));
    alerts.add(newAlert);
    // debugPrint('total de alertas: ${alerts.length.toString()}');
    notifyListeners();
    //-----NO SIRVE LO DE ABAJO ------
    //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) => {
    //    notifyListeners()
    //  });
  }

  addPage({required GlobalKey key, required Widget content}) {
    // final newAlert = AlertTemplate(key: key, content: content);
    alerts.add(content);
    // debugPrint('total de alertas: ${alerts.length.toString()}');
    notifyListeners();
    //-----NO SIRVE LO DE ABAJO ------
    //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) => {
    //    notifyListeners()
    //  });
  }

  showNotification() {
    notificationController!.forward();
  }

  dismissNotification() {
    notificationController!.reverse();
  }

  dismissAlert({required GlobalKey key}) {
    debugPrint("MANDAR A BORRAR alert de: $key");
    alerts.removeWhere((alert) => key == alert.key);
    notifyListeners();
  }

  clearAllAlert() {
    alerts.clear();
    notifyListeners();
  }
}
