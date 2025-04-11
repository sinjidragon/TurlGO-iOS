import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:turlgo/feature/shared/component/pressable_button.dart';
import 'package:turlgo/feature/shared/router/app_router.dart';

class FirstView extends StatefulWidget {
  const FirstView({super.key});

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // 화면 넘침을 방지하기 위해 ScrollView 추가
        child: Container(
          color: Color(0xFFFFFFFF),
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
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
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20), // 여백 추가
                Image.asset(
                  'assets/images/first_cat.png',
                  width: 326,
                  height: 326,
                ),
                SizedBox(height: 30), // 여백 추가
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
                  child: Column(
                    children: [
                      PressableButton(
                        onTap: () {
                          context.push('/signup');
                        },
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color(0xFFFFFFFF),
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
                          onPressed: () {
                            print("hello");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}