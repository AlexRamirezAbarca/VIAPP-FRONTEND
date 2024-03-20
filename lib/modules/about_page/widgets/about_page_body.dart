import 'package:flutter/material.dart';
import 'package:flutter_easy_faq/flutter_easy_faq.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/shared/widgets/title.dart';

class AboutPageBody extends StatefulWidget {
  const AboutPageBody({super.key});

  @override
  State<AboutPageBody> createState() => _AboutPageBodyState();
}

class _AboutPageBodyState extends State<AboutPageBody> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: height + 500,
        child: Column(
          children: [
            const SizedBox(height: 30),
            title(
                title: 'FAQ',
                fontName: 'Roboto',
                color: AppTheme.secondaryColor,
                fontSize: 50,
                fontWeight: FontWeight.w800),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: EasyFaq(
                collapsedIcon: const Icon(Icons.keyboard_arrow_down_outlined, color: AppTheme.primaryColor,),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                question: '¿Qué puedo hacer con VIAPP?',
                answer:
                    'Con VIAPP podemos gestionar, crear solicitudes internas para agilizar el proceso cotidiano de nuestra empresa',
                questionTextStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w800),
                anserTextStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    color: AppTheme.textColorAbout,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: EasyFaq(
                collapsedIcon: const Icon(Icons.keyboard_arrow_down_outlined, color: AppTheme.primaryColor,),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                question: '¿Qué tan dificil es crear un solicitud con VIAPP?',
                answer:
                    'Es muy sencillo, solo debes escoger la solicitud que desees generar, a su vez ingresar el motivo explicito de porque deseamos generar la solicitud y listo, solicitud generada facilmente.',
                questionTextStyle: GoogleFonts.roboto(
                    fontSize: 16, color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w800),
                anserTextStyle: GoogleFonts.roboto(
                  fontSize: 16,
                  color: AppTheme.textColorAbout,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: EasyFaq(
                collapsedIcon: const Icon(Icons.keyboard_arrow_down_outlined, color: AppTheme.primaryColor,),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                question:
                    '¿Comó sabre si mi solicitud fue aprobada o rechazada?',
                answer:
                    'La solicitud tiene indicadores de estado, cuando la creas el estado es pendiente de aprobación, en donde tienes que esperar que el administrador analice la solicitud y la apruebe o rechaze ',
                questionTextStyle: GoogleFonts.roboto(
                    fontSize: 16, color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w800),
                anserTextStyle: GoogleFonts.roboto(
                  fontSize: 16,
                  color: AppTheme.textColorAbout,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: EasyFaq(
                collapsedIcon: const Icon(Icons.keyboard_arrow_down_outlined, color: AppTheme.primaryColor,),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                question:
                    '¿Puedo enviar la solicitud desde mi cuenta pero que sea de otra persona?',
                answer:
                    'NO!.... Las cuentas son personales y las solicitudes son unicamente para la persona de la cuenta VIAPP. Para ello mejor contactese con un administrador.',
                questionTextStyle: GoogleFonts.roboto(
                    fontSize: 16, color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w800),
                anserTextStyle: GoogleFonts.roboto(
                  fontSize: 16,
                  color: AppTheme.textColorAbout,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: EasyFaq(
                collapsedIcon: const Icon(Icons.keyboard_arrow_down_outlined, color: AppTheme.primaryColor,),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                question:
                    '¿Puedo cambiar mi contraseña en caso de que no recuerde mi contraseña VIAPP?',
                answer:
                    'Si, VIAPP cuenta con una interfaz de cambio de contraseña en donde se envia información a tu correo electrónico para realizar la transacción.',
                questionTextStyle: GoogleFonts.roboto(
                    fontSize: 16, color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w800),
                anserTextStyle: GoogleFonts.roboto(
                  fontSize: 16,
                  color: AppTheme.textColorAbout,
                  fontWeight: FontWeight.w400
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
