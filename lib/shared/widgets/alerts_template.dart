import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/filled_button.dart';
import 'package:viapp/shared/widgets/text_button_text.dart';

Text titleAlerts({required String title, required Color color}) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: color,
    ),
  );
}

Padding messageAlerts(Size size, {required String message}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
    child: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppTheme.hinText,
      ),
    ),
  );
}

class AlertLoading extends StatelessWidget {
  const AlertLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: 180,
        width: 240,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset('assets/loading_logo.svg'),
          ],
        ),
      ),
    );
  }
}

class AlertGeneric extends StatefulWidget {
  final bool dismissable;
  final GlobalKey? keyToClose;
  final Widget content;
  final bool? heightOption;

  const AlertGeneric(
      {Key? key,
      required this.content,
      this.heightOption = false,
      this.dismissable = false,
      this.keyToClose})
      : super(key: key);

  @override
  State<AlertGeneric> createState() => _AlertGenericState();
}

class _AlertGenericState extends State<AlertGeneric> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          height: widget.heightOption == true ? size.height * 0.54 : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.whiteS,
          ),
          child:
              Material(type: MaterialType.transparency, child: widget.content),
        ),
        if (widget.dismissable)
          Positioned(
            top: -3,
            right: 0,
            child: SizedBox(
              height: 50,
              width: 50,
              child: CloseButton(
                style: const ButtonStyle(
                    iconColor: MaterialStatePropertyAll(AppTheme.hinText)),
                onPressed: () {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  fp.dismissAlert(key: widget.keyToClose!);
                },
              ),
            ),
          )
      ],
    );
  }
}

class AlertTemplate extends StatefulWidget {
  final Widget content;
  final GlobalKey keyToClose;
  final bool? dismissAlert;
  final bool? animation;
  final double? padding;

  const AlertTemplate(
      {Key? key,
      required this.content,
      required this.keyToClose,
      this.dismissAlert = false,
      this.animation = true,
      this.padding = 20
      })
      : super(key: key);

  @override
  State<AlertTemplate> createState() => _AlertTemplateState();
}

class _AlertTemplateState extends State<AlertTemplate> {
  late GlobalKey keySummoner;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomOut(
        controller: (controller) {
        },
        animate: false,
        duration: const Duration(milliseconds: 200),
        child: Scaffold(
          backgroundColor: Colors.black45,
          body: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  widget.dismissAlert == true
                      ? fp.dismissAlert(key: widget.keyToClose)
                      : null;
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
              ),
              Container(
                padding: EdgeInsets.all(widget.padding ?? 20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.animation == true
                            ? FadeInUpBig(
                                animate: true,
                                controller: (controller) {
                                },
                                duration: const Duration(milliseconds: 500),
                                child: widget.content)
                            : widget.content,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class ErrorGeneric extends StatelessWidget {
  final GlobalKey keyToClose;
  final String message;
  final String? messageButton;
  final void Function()? onPress;

  const ErrorGeneric(
      {Key? key,
      required this.message,
      required this.keyToClose,
      this.messageButton,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: size.height * 0.015),
        SvgPicture.asset(AppTheme.iconErrorPath),
        SizedBox(height: size.height * 0.03),
        titleAlerts(title: '¡Oops, algo falló!', color: AppTheme.secondaryColorS),
        SizedBox(height: size.height * 0.04),
        messageAlerts(size, message: message),
        SizedBox(height: size.height * 0.035),
        FilledButtonWidget(
          borderRadius: 20,
          width: size.width * 0.05,
          color: AppTheme.secondaryColorS,
          text: messageButton ?? 'Aceptar',
          onPressed: (onPress != null)
              ? onPress
              : () async {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  fp.dismissAlert(key: keyToClose);
                },
        ),
        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}

class SuccessInformation extends StatelessWidget {
  final GlobalKey keyToClose;
  final void Function()? onPressed;
  final String? message;

  const SuccessInformation(
      {Key? key,
      required this.keyToClose,
      this.onPressed,
      this.message = 'body'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: size.height * 0.015),
        SvgPicture.asset(AppTheme.iconCheckPath),
        const SizedBox(height: 25),
        titleAlerts(title: '¡Estamos listos!', color: AppTheme.textColorS),
        SizedBox(height: size.height * 0.015),
        messageAlerts(size, message: message!),
        SizedBox(height: size.height * 0.025),
        FilledButtonWidget(
            borderRadius: 15,
            width: size.width * 0.05,
            color: AppTheme.textColorS,
            text: 'Aceptar',
            onPressed: 
            (onPressed != null) ? onPressed : (){
              final fp = Provider.of<FunctionalProvider>(context, listen: false);
              fp.dismissAlert(key: keyToClose);
              
            },
            ),
        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}

class ConfirmContent extends StatelessWidget {
  final String message;
  final void Function() confirm;
  final void Function() cancel;
  const ConfirmContent(
      {Key? key,
      required this.message,
      required this.confirm,
      required this.cancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.025),
        SvgPicture.asset(AppTheme.iconAlertPath),
        const SizedBox(height: 20),
        messageAlerts(size, message: message),
        const SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButtonWidget(
                onPressed: cancel, size: 15, text: 'Cancelar', textColor: AppTheme.secondaryColor, decoration: TextDecoration.underline, decorationColor: AppTheme.secondaryColor,),
            SizedBox(width: size.width * 0.19),
            FilledButtonWidget(
                onPressed: confirm, width: size.width * 0.05, text: 'Confirmar', color: AppTheme.primaryColor,)
          ],
        ),
        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}