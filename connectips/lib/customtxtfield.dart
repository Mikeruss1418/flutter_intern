  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';

  import 'constants.dart';

  class CustomTxtField extends StatelessWidget {
    final TextEditingController controller;
    final FocusNode? focusNode;
    final String labeltxt;
    final String? Function(String?)? validator;
    final void Function()? ontap;
    final void Function(String?)? onchanged;
    final Icon? prefixicon;
    final Icon? suffixicon;
    final TextInputType? keyboardtype;
    final int? minlines;
    final int? maxlen;
  final List<TextInputFormatter>? inputformatter;  
    final Widget? suffix;
    final int? maxlines;
    final bool? readonly;
    const CustomTxtField(
        {super.key,
        required this.controller,
        required this.labeltxt,
        this.focusNode,
        this.keyboardtype,
        this.prefixicon,
        this.onchanged,
        this.maxlen,
        this.inputformatter,
        this.suffix,
        this.suffixicon,
        this.maxlines,
        this.minlines,
        this.readonly = false,
        this.ontap,
        this.validator});

    @override
    Widget build(BuildContext context) {
      return TextFormField(
        ///*
        ///for focusnode addlistener with function of setstate to change the ui, and also dispose and remove the listener
        ///
        /// */
        maxLength: maxlen,
        inputFormatters: inputformatter,
        focusNode: focusNode,
        onChanged: onchanged,
        keyboardType: keyboardtype,
        onTap: ontap,
        style: style.copyWith(color: Colors.black, fontSize: 13.sp),
        readOnly: readonly!,
        minLines: minlines,
        maxLines: maxlines,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixicon,
          suffixIcon: suffixicon,
          labelText: labeltxt,
          suffix: suffix,
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 16.sp),
          alignLabelWithHint: true,
          filled: true,
          // floatingLabelBehavior: FloatingLabelBehavior.always,//always show the labe at the op of the field
          floatingLabelStyle: TextStyle(fontSize: 22.sp, color: themecolor),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.redAccent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide:  BorderSide(color: themecolor, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey[400]!)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.yellow),
          ),
        ),
        validator: validator,
      );
    }
  }
