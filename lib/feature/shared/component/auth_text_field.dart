import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


enum AuthTextFieldType {
  normal,
  password,
  email,
  custom
}

class AuthTextField extends StatefulWidget {
  final String prefixIconPath;
  final AuthTextFieldType type;
  final String? hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final Widget? customSuffixIcon;

  const AuthTextField({
    super.key,
    required this.prefixIconPath,
    required this.type,
    this.hintText,
    this.controller,
    this.onTap,
    this.focusNode,
    this.customSuffixIcon
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isShowPassword = false;

  Widget? _buildSuffixIcon() {
    switch (widget.type) {
      case AuthTextFieldType.password:
        return GestureDetector(
          onTap: () {
            setState(() {
              isShowPassword = !isShowPassword;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              isShowPassword
                  ? 'assets/icons/open_eye.svg'
                  : 'assets/icons/close_eye.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                Color(0xFFA7A7A7),
                BlendMode.srcIn,
              ),
            ),
          ),
        );

      case AuthTextFieldType.email:
        return Padding(
          padding: EdgeInsets.fromLTRB(0, 14, 12, 14),
            child:
              SizedBox(
                height: 15,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                    onPressed: widget.onTap,
                    child: Text(
                      "인증",
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFFE6989D)
                      ),
                    )
                ),
              )
        );
      case AuthTextFieldType.custom:
        return widget.customSuffixIcon;

      case AuthTextFieldType.normal:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: widget.type == AuthTextFieldType.password && !isShowPassword,
      style: TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Color(0xFF595959)
      ),
      decoration: InputDecoration(
          isDense: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFFA7A7A7)
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              widget.prefixIconPath,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 20,
            minHeight: 20,
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 20,
            minHeight: 20,
          ),
          suffixIcon: _buildSuffixIcon(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(
                  color: Color(0xFFEDEDED)
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(
                  color: Color(0xFFFFDADA)
              )
          )
      ),
      cursorColor: Color(0xFFA7A7A7),
      cursorWidth: 2.0,
      cursorHeight: 14.0,
    );
  }
}