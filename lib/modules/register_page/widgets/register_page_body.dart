import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/register_page/services/register_service.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/models/catalogue_response.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/services/catalogue_service.dart';
import 'package:viapp/shared/widgets/alerts_template.dart';
import 'package:viapp/shared/widgets/drop_down_button.dart';
import 'package:viapp/shared/widgets/filled_button.dart';
import 'package:viapp/shared/widgets/placeholder.dart';
import 'package:viapp/shared/widgets/text.dart';
import 'package:viapp/shared/widgets/text_button_text.dart';
import 'package:viapp/shared/widgets/title.dart';
import '../../../shared/widgets/text_form_field.dart';

class RegisterPageBody extends StatefulWidget {
  static CatalogueResponse? catalogueResponse;
  const RegisterPageBody({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {
  final TextEditingController _identificationController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _focusIdentification = FocusNode();
  final FocusNode _focusFirstName = FocusNode();
  final FocusNode _focusLastName = FocusNode();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusUserName = FocusNode();
  final FocusNode _focusBirthDate = FocusNode();
  final FocusNode _focusPhone = FocusNode();
  final FocusNode _focusPassword = FocusNode();
  final FocusNode _focusConfirmPassword = FocusNode();

  final _registerService = RegisterService();
  final _catalogueService = CatalogueService();

  CatalogueResponse? catalogueResponse;

  DateTime _selectedDate = DateTime.now();

  String birthDate = '';

  List<DropdownMenuItem<String>> selectCharge = [];
  List<DropdownMenuItem<String>> selectArea = [];

  int valueCharge = 0;
  int valueArea = 0;

  bool showPasswordPassword = false;
  bool showPasswordConfirmPassword = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getCatalogueService();
    });
    super.initState();
  }

  void _getCatalogueService() async {
    if (RegisterPageBody.catalogueResponse == null) {
      debugPrint('no hay datos peticion');
      final response = await _catalogueService.getCatalogue(context);
      if (!response.error) {
        RegisterPageBody.catalogueResponse = response.data;
        _getCatalogueCharge();
        _getCatalogueArea();
        setState(() {});
      }
    } else {
      debugPrint(
          'si hay datos ya en variable global, llama al metodo de listar charge ys setea');
      // catalogueResponse = RegisterPageBody.catalogueResponse;
      _getCatalogueCharge();
      _getCatalogueArea();
      setState(() {});
    }
  }

  _getCatalogueCharge() {
    if (RegisterPageBody.catalogueResponse != null) {
      debugPrint('si hay datos en variable global');
      selectCharge.addAll(RegisterPageBody.catalogueResponse!.charge
          .map((e) => DropdownMenuItem<String>(
              value: e.id.toString(), child: textWidget(title: e.name)))
          .toList());
    } else {
      GlobalHelper.logger.e('no hay datos');
      //ARREGLAR PARA QUE NO SE CAIGA EL APP, SE LE TIENE QUE PASAR UN NUMERO AL VALUE
      //selectCharge.add(DropdownMenuItem<String>(value: '', child:  textWidget(title:'Ninguna')));
    }
  }

  _getCatalogueArea() {
    if (RegisterPageBody.catalogueResponse != null) {
      debugPrint('si hay datos en variable global');
      selectArea.addAll(RegisterPageBody.catalogueResponse!.area
          .map((e) => DropdownMenuItem<String>(
              value: e.id.toString(), child: textWidget(title: e.name)))
          .toList());
    } else {
      GlobalHelper.logger.e('no hay datos');
      //ARREGLAR PARA QUE NO SE CAIGA EL APP, SE LE TIENE QUE PASAR UN NUMERO AL VALUE
      //selectCharge.add(DropdownMenuItem<String>(value: '', child:  textWidget(title:'Ninguna')));
    }
  }

  void register({required Map<String, dynamic> body}) async {
    final successAlertKey = GlobalHelper.genKey();
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final response = await _registerService.register(context, body);

    if (!response.error) {
      fp.dismissAlert(key: widget.keyPage);
      fp.showAlert(
        key: successAlertKey,
        content: AlertGeneric(
          content: SuccessInformation(
            keyToClose: successAlertKey,
            message: response.message,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final fp = Provider.of<FunctionalProvider>(context, listen: false);

    return SingleChildScrollView(
      child: FadeInUp(
        delay: const Duration(milliseconds: 300),
        child: Container(
          width: width,
          height: height,
          color: AppTheme.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 45),
                  title(
                      fontName: 'Archivo Black',
                      title: '¡Vamos a empezar!',
                      fontSize: width * 0.08),
                  title(
                      fontName: 'Archivo Black',
                      title: 'Ingresa tus datos para registrate',
                      fontSize: 16,
                      color: AppTheme.secondaryColorS,
                      fontWeight: FontWeight.w500),
                  const SizedBox(height: 45),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: width * 0.065),
                              child: placeHolderWidget(placeholder: 'Cedula')),
                          const SizedBox(height: 5),
                          Container(
                            width: width * 0.46,
                            padding: const EdgeInsets.only(left: 15),
                            child: CustomTextField(
                              focusNode: _focusIdentification,
                              textInputAction: TextInputAction.next,
                              controller: _identificationController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onSubmitted: (term) {
                                _focusIdentification.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_focusFirstName);
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: width * 0.065),
                              child: placeHolderWidget(placeholder: 'Nombres')),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.only(left: 15),
                            width: width * 0.46,
                            child: CustomTextField(
                              focusNode: _focusFirstName,
                              textInputAction: TextInputAction.next,
                              controller: _firstNameController,
                              keyboardType: TextInputType.text,
                              onSubmitted: (term) {
                                _focusFirstName.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_focusLastName);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //FIN PRIMERA FILA
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: width * 0.065),
                              child:
                                  placeHolderWidget(placeholder: 'Apellidos')),
                          const SizedBox(height: 5),
                          Container(
                            width: width * 0.46,
                            padding: const EdgeInsets.only(left: 15),
                            child: CustomTextField(
                              focusNode: _focusLastName,
                              textInputAction: TextInputAction.next,
                              controller: _lastNameController,
                              keyboardType: TextInputType.text,
                              onSubmitted: (term) {
                                _focusLastName.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_focusUserName);
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: width * 0.065),
                              child: placeHolderWidget(placeholder: 'Usuario')),
                          const SizedBox(height: 5),
                          Container(
                            width: width * 0.46,
                            padding: const EdgeInsets.only(left: 15),
                            child: CustomTextField(
                              focusNode: _focusUserName,
                              controller: _userNameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              onSubmitted: (term) {
                                _focusUserName.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_focusPhone);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //FIN DE SEGUNDA FILA
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: width * 0.065),
                              child: placeHolderWidget(
                                  placeholder: 'Fecha de nac.')),
                          const SizedBox(height: 5),
                          Container(
                            width: width * 0.46,
                            padding: const EdgeInsets.only(left: 15),
                            child: CustomTextField(
                              readOnly: true,
                              focusNode: _focusBirthDate,
                              controller: _birthDateController,
                              suffixIcon: const Icon(Icons.calendar_month),
                              onTap: () async {
                                //debugPrint('hola');
                                final keyCalendar = GlobalHelper.genKey();
                                fp.showAlert(
                                    key: keyCalendar,
                                    content: AlertGeneric(
                                        content: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        CalendarDatePicker(
                                          initialDate: _selectedDate,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2101),
                                          onDateChanged: (DateTime date) {
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date);
                                            setState(() {
                                              birthDate =
                                                  formattedDate.toString();
                                              _selectedDate = date;
                                            });
                                          },
                                        ),
                                        const SizedBox(height: 30),
                                        FilledButtonWidget(
                                          width: 120,
                                          text: 'Aceptar',
                                          onPressed: () {
                                            if (birthDate != '') {
                                              _birthDateController.text =
                                                  birthDate;
                                            }
                                            fp.dismissAlert(key: keyCalendar);
                                            birthDate = '';
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        TextButtonWidget(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                AppTheme.primaryColor,
                                            text: 'Cancelar',
                                            onPressed: () {
                                              if (birthDate != '') {
                                                _selectedDate = DateTime.now();
                                              }
                                              fp.dismissAlert(key: keyCalendar);
                                            },
                                            size: 15,
                                            textColor: AppTheme.primaryColor),
                                        const SizedBox(height: 20),
                                      ],
                                    )));
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: width * 0.065),
                              child:
                                  placeHolderWidget(placeholder: 'Teléfono')),
                          const SizedBox(height: 5),
                          Container(
                            width: width * 0.46,
                            padding: const EdgeInsets.only(left: 15),
                            child: CustomTextField(
                              focusNode: _focusPhone,
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onSubmitted: (term) {
                                _focusPhone.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_focusEmail);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //FIN DE TERCERA FILA
                  const SizedBox(height: 12),
                  Padding(
                      padding: EdgeInsets.only(left: width * 0.065),
                      child: placeHolderWidget(placeholder: 'Correo')),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: CustomTextField(
                      focusNode: _focusEmail,
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onSubmitted: (term) {
                        _focusEmail.unfocus();
                        FocusScope.of(context).requestFocus(_focusPassword);
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: width * 0.065),
                              child: placeHolderWidget(placeholder: 'Cargo')),
                          const SizedBox(height: 5),
                          Container(
                            width: width * 0.46,
                            padding: const EdgeInsets.only(left: 15),
                            child: DropDownButtonWidget(
                              hint: 'Cargos...',
                              items: selectCharge,
                              onChanged: (String? value) {
                                setState(() {
                                  valueCharge = int.parse(value!);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: width * 0.065),
                              child: placeHolderWidget(placeholder: 'Área')),
                          const SizedBox(height: 5),
                          Container(
                            width: width * 0.46,
                            padding: const EdgeInsets.only(left: 15),
                            child: DropDownButtonWidget(
                              hint: 'Áreas...',
                              items: selectArea,
                              onChanged: (String? value) {
                                setState(() {
                                  valueArea = int.parse(value!);
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Padding(
                      padding: EdgeInsets.only(left: width * 0.065),
                      child: placeHolderWidget(placeholder: 'Contraseña')),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CustomTextField(
                      focusNode: _focusPassword,
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      obscureText: !showPasswordPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPasswordPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppTheme.primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            showPasswordPassword = !showPasswordPassword;
                          });
                        },
                      ),
                      onSubmitted: (term) {
                        _focusPassword.unfocus();
                        FocusScope.of(context)
                            .requestFocus(_focusConfirmPassword);
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                      padding: EdgeInsets.only(left: width * 0.065),
                      child:
                          placeHolderWidget(placeholder: 'Repetir contraseña')),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CustomTextField(
                      focusNode: _focusConfirmPassword,
                      controller: _confirmPasswordController,
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !showPasswordConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPasswordConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppTheme.primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            showPasswordConfirmPassword =
                                !showPasswordConfirmPassword;
                          });
                        },
                      ),
                      onSubmitted: (term) {
                        _focusConfirmPassword.unfocus();
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  FilledButtonWidget(
                    width: 170,
                    height: 45,
                    text: 'Registarse',
                    onPressed: () {
                      final keyAlertError = GlobalHelper.genKey();
                      if (_identificationController.text.trim() == '' ||
                          _firstNameController.text.trim() == '' ||
                          _lastNameController.text.trim() == '' ||
                          _userNameController.text.trim() == '' ||
                          _emailController.text.trim() == '' ||
                          _passwordController.text.trim() == '' ||
                          _confirmPasswordController.text.trim() == '' ||
                          _birthDateController.text.trim() == '' ||
                          _phoneController.text.trim() == '' ||
                          valueCharge == 0 ||
                          valueArea == 0) {
                        fp.showAlert(
                          key: keyAlertError,
                          content: AlertGeneric(
                            keyToClose: keyAlertError,
                            content: ErrorGeneric(
                              keyToClose: keyAlertError,
                              message:
                                  'Por favor, llena los campos requeridos para poder iniciar sesión.',
                            ),
                          ),
                        );
                      } else {
                        if (_passwordController.text.trim() ==
                            _confirmPasswordController.text.trim()) {
                          final body = {
                            "first_name": _firstNameController.text.trim(),
                            "last_name": _lastNameController.text.trim(),
                            "email": _emailController.text.trim(),
                            "user_name": _userNameController.text.trim(),
                            "password": _confirmPasswordController.text.trim(),
                            "identification":
                                _identificationController.text.trim(),
                            "phone": _phoneController.text.trim(),
                            "birth_date": _birthDateController.text.trim(),
                            "charge_id": valueCharge,
                            "area_id": valueArea,
                          };
                          register(body: body);
                        } else {
                          final errorPassworKey = GlobalHelper.genKey();
                          fp.showAlert(
                            key: errorPassworKey,
                            content: AlertGeneric(
                              keyToClose: errorPassworKey,
                              content: ErrorGeneric(
                                keyToClose: errorPassworKey,
                                message:
                                    'Las contraseñas que ingresaste no coinciden.',
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  TextButtonWidget(
                    text: 'Cancelar',
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                      fp.dismissAlert(key: widget.keyPage);
                    },
                    size: 16,
                    textColor: AppTheme.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
