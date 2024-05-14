import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate_code/src/config/custom_typedefs.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvanceTextFormFieldWithLabel extends StatefulWidget {
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final String? titleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final bool isMandatoryField;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefixIcon;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final OnValidator? validator;
  final OnFieldSubmitted? onFieldSubmitted;
  final OnChanged? onChanged;
  final OnEditComplete? onEditComplete;
  final OnSaved? onSaved;
  final OnTapOutside? onTapOutside;
  final AutovalidateMode? autovalidateMode;
  final Widget? suffixIcon;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final double width;

  const AdvanceTextFormFieldWithLabel({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.enabled = true,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.validator,
    this.initialValue,
    this.backgroundColor,
    this.maxLength,
    this.maxLines = 1,
    this.titleText,
    this.tittleTextStyle,
    this.additionalTittleText,
    this.isMandatoryField = false,
    this.textInputAction,
    this.labelText,
    this.onFieldSubmitted,
    this.focusNode,
    this.onEditComplete,
    this.onSaved,
    this.autovalidateMode,
    this.suffixIcon,
    this.suffix,
    this.onTapOutside,
    this.inputFormatters,
    this.width = 300,
  });

  @override
  State<AdvanceTextFormFieldWithLabel> createState() => _AdvanceTextFormFieldWithLabelState();
}

class _AdvanceTextFormFieldWithLabelState extends State<AdvanceTextFormFieldWithLabel> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    //for dark and light theme
    Color fillColor = theme.brightness==Brightness.light? AppColors.secondaryColorLight : AppColors.topSheet;

    return Container(
      height: 42.h,
      width: widget.width.w,
      decoration: const BoxDecoration(
        color: AppColors.primaryColorDark,
      ),
      child: TextFormField(
        autovalidateMode: widget.autovalidateMode,
        key: widget.key,
        initialValue: widget.initialValue,
        controller: widget.controller,
        focusNode: widget.focusNode,
        inputFormatters: widget.inputFormatters,
        textAlign: TextAlign.center,
        onChanged: (value) {
          widget.onChanged?.call(value);
        },
        onTap: (){

        },
        onTapOutside: (event){
          FocusScope.of(context).requestFocus(FocusNode());
          widget.onTapOutside?.call(event);
        },
        onFieldSubmitted: (value){
          widget.onFieldSubmitted?.call(value);
        },
        onSaved: (value){
          widget.onSaved?.call(value);
        },
        cursorColor: Colors.blue,
        style: theme.textTheme.bodyMedium,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
          ),
          //prefixIcon: prefixIcon,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          suffix: widget.suffix,
          // prefixIconConstraints: BoxConstraints(
          //   maxHeight: 16.h,
          // ),
          errorStyle: theme.textTheme.labelMedium?.copyWith(
            color: AppColors.red,
          ),
          border: InputBorder.none,
          hintText: widget.hintText,
          //labelText: widget.labelText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textColorDark.withOpacity(.7),
          ),
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textColorDark,
          ),
          enabled: widget.enabled,
          counterText: "",
        ),
      ),
    );

  }
}
