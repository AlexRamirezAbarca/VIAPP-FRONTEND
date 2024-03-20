import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:viapp/env/theme/app_theme.dart';

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget({
    super.key,
    this.items,
    this.onChanged,
    this.value,
    this.hint,
    this.validator, this.onSaved,
  });

  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String? value;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  List<double> customHeights = [40.0, 50.0, 30.0];
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Material(
      //   elevation: 4,
      //   borderRadius: BorderRadius.circular(10),
      //   child: Container(
      //     height: 45,
      //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      //   ),
      // ),
      DropdownButtonFormField2<String>(
        onSaved: widget.onSaved,
        isExpanded: true,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Color(0xFFAEAEAE),
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
          filled: true,
          fillColor: AppTheme.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppTheme.borderLineTextField),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppTheme.borderLineTextField),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.borderLineTextField),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          // focusedErrorBorder: OutlineInputBorder(
          //     borderSide: const BorderSide(color: AppTheme.errors, width: 0.3),
          //     borderRadius: BorderRadius.circular(10)),
          // errorBorder: OutlineInputBorder(
          //     borderSide: const BorderSide(color: AppTheme.errors, width: 0.3),
          //     borderRadius: BorderRadius.circular(10)),
          // Add more decoration..
        ),
        hint: Text(
          widget.hint ?? '',
          style: const TextStyle(
            color: Color(0xFFAEAEAE),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        items: widget.items,
        onChanged: widget.onChanged,
        value: widget.value,
        validator: widget.validator,
        buttonStyleData: const ButtonStyleData(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(10)),
          //   color: AppTheme.reportAlert,
          // ),
          height: 18,
          overlayColor: MaterialStatePropertyAll(AppTheme.white),
          elevation: 0,
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppTheme.primaryColor,
          ),
          openMenuIcon: Icon(
            Icons.keyboard_arrow_up_outlined,
            color: AppTheme.primaryColor,
          ),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          // useSafeArea: false,
          // scrollPadding: EdgeInsets.all(10),
          //openInterval :const Interval(0.25, 0.5, curve: Curves.fastEaseInToSlowEaseOut),
          isOverButton: true,
          elevation: 3,
          maxHeight: 225,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          offset: const Offset(0, -48),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(10),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),

        menuItemStyleData: MenuItemStyleData(
          height: 40,
          selectedMenuItemBuilder: (context, child) {
            return Container(
              height: 40,
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.circular(10),
                color: AppTheme.black12,
              ),
              child: child,
            );
          },
          padding: const EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    ]);
  }
}
