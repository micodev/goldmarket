import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key key,
      this.text,
      this.keyboardType,
      this.maxLines = 1,
      this.hintText = "",
      this.inputFormatters,
      this.isPassword = false,
      this.edgePadding = const EdgeInsets.symmetric(horizontal: 30)})
      : super(key: key);
  final int maxLines;
  final TextEditingController text;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final EdgeInsets edgePadding;
  final List<TextInputFormatter> inputFormatters;
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.edgePadding,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPassword,
              controller: widget.text,
              textDirection: TextDirection.ltr,
              textAlign: widget.isPassword && widget.text.text != ""
                  ? TextAlign.left
                  : TextAlign.right,
              style: TextStyle(fontSize: 20),
              maxLines: widget.maxLines,
              maxLength: 20,
              onChanged: (text) {
                setState(() {});
              },
              decoration: InputDecoration(
                counterText: "",
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.black26),
                contentPadding: EdgeInsets.only(bottom: 10),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
