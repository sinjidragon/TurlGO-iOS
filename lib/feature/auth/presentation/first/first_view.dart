import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:turlgo/feature/shared/component/pressable_button.dart';

class FirstView extends StatefulWidget {
  const FirstView({super.key});

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: SafeArea(child:
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top : 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 165,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 12),
                        child: Text(
                            "새로운 가족을 만나는 장소",
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            color: Color(0xFF5F5B5B),
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(40, 50, 40, 80),
                        child: Image.asset(
                          'assets/images/first_cat.png',
                          fit: BoxFit.contain,
                          height: 300,
                        ),
                      ),
                      PressableButton(
                          onTap: () {
                            context.push('/signup');
                          },
                          child: Text(
                            '회원가입',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500
                            ),
                          )
                      ),
                      CupertinoButton(
                          onPressed: () {
                              context.push('/login');
                            },
                          child:
                          Text(
                              "기존 계정으로 로그인",
                            style: TextStyle(
                                color: Color(0xFF5F5B5B),
                              fontFamily: 'Pretendard',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
  }
}