import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turlgo/feature/auth/presentation/signup/signup_view_model.dart';
import 'package:turlgo/feature/shared/component/auth_back_button.dart';
import 'package:turlgo/feature/shared/component/auth_text_field.dart';
import 'package:turlgo/feature/shared/component/keyboard_dismiss_wrapper.dart';
import 'package:turlgo/feature/shared/component/pressable_button.dart';

class SignupView extends StatefulWidget{
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignupViewModel>();
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: KeyboardDismissWrapper(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AuthBackButton()
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 50),
                      child:
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 165,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        "회원가입",
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            color: Color(0xFF5F5B5B),
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 50, 35, 80),
                      child: SizedBox(
                        height: 300,
                        child: Padding(
                            padding: EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                child: Text(
                                    "아이디",
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 14,
                                      color: Color(0xFFA7A7A7),
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              IgnorePointer(
                                ignoring: false,
                                child: AuthTextField(
                                  type: AuthTextFieldType.normal,
                                  prefixIconPath: 'assets/icons/my.svg',
                                  controller: vm.idEditingController,
                                  hintText: '아이디를 입력해주세요',
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                                  child: SizedBox(
                                    height: 17,
                                    child: vm.errorMessage.isNotEmpty?
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top : 2),
                                          child:
                                          SvgPicture.asset(
                                            'assets/icons/mini_dot.svg',
                                            height: 5,
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            vm.errorMessage,
                                            style: TextStyle(
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFEF798A),
                                              fontSize: 12
                                            ),
                                          ),
                                        )
                                      ],
                                    ): null
                                  )
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "비밀번호",
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 14,
                                      color: Color(0xFFA7A7A7),
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              AuthTextField(
                                controller: vm.passwordEditingController,
                                  prefixIconPath: 'assets/icons/password.svg',
                                  type: AuthTextFieldType.password,
                                hintText: '비밀번호를 입력해주세요',
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    PressableButton(
                        width: 280,
                        onTap: () {
                          if (!vm.isLoading) {
                            Future.microtask(() async {
                              await vm.checkUserName();
                              if (vm.isFirstSuccess) {
                                context.push('/signup_email',extra: {
                                  'id': vm.idEditingController.text,
                                  'password': vm.passwordEditingController.text,
                                });
                              }
                            });
                          }
                        },
                        child: vm.isLoading ?
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/mini_dot.svg',
                                height: 8,
                              ),
                              SizedBox(width: 10,),
                              SvgPicture.asset(
                                'assets/icons/mini_dot.svg',
                                height: 8,
                              ),
                              SizedBox(width: 10,),
                              SvgPicture.asset(
                                'assets/icons/mini_dot.svg',
                                height: 8,
                              ),
                            ],
                          ),
                        ) :
                        Text(
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
                        child: Text(
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
                )
            ),
          ),
        ),
      ),
    );
  }
}