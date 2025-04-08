import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstView extends StatefulWidget{
  const FirstView({super.key});

  @override
  State<FirstView> createState() => _FirstViewState();

}

class _FirstViewState extends State<FirstView> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          color : Color(0x00EF798A),
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 166,
                    height: 39,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Text(
                    "새로운 가족을 만나는 장소",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                    ),
                  ),
                ),
                Spacer(),
                Image.asset(
                  'assets/images/first_cat.png',
                  width: 326,
                  height: 326,
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
                  child:
                    Column(
                      children: [
                        GestureDetector(
                          onTap: ()  async {
                            setState(() {
                              _isPressed = true;
                            });
                            await Future.delayed(Duration(milliseconds: 80));
                            setState(() {
                              _isPressed = false;
                            });
                          },
                          child:
                          AnimatedScale(
                            scale: _isPressed ? 0.95 : 1.0,
                            duration: Duration(milliseconds: 80),
                            child:
                            Container(
                              width: 280,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Color(0xFFEF798A),
                                borderRadius: BorderRadius.circular(50)
                              ),
                              alignment: Alignment.center,
                              child:
                                Text(
                                    "회원가입",
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color(0xFFFFFFFF)
                                  ),
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: CupertinoButton(
                              child: Text(
                                "기존 계정으로 로그인",
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onPressed: (){
                                print("hello");
                              }
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      );
  }
}