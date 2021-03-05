import 'package:commerceapps/constans.dart';
import 'package:flutter/material.dart';
class CustomInput extends StatelessWidget {
  final String hintText;
  final Function (String)onChange;
  final Function (String)onSubmit;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPassowrdFiled;


  const CustomInput({Key key, this.hintText,this.onChange,this.onSubmit,this.focusNode,this.textInputAction,this.isPassowrdFiled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isPassowrdFiled=isPassowrdFiled??false;
    return Container(decoration: BoxDecoration(  color: Color(0xFFF2F2F2),
    borderRadius: BorderRadius.circular(12)),margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      child: TextField(obscureText: _isPassowrdFiled,textInputAction: textInputAction,onChanged: onChange,onSubmitted: onSubmit,focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 18)
        ,border: InputBorder.none,
          hintText:hintText?? "Hint Text .."),
      style: Constans.regularDarkText,));
  }
}
