import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turlgo/feature/auth/presentation/signup/signup_email_view_model.dart';
import 'package:turlgo/feature/shared/component/auth_back_button.dart';
import 'package:turlgo/feature/shared/component/auth_text_field.dart';
import 'package:turlgo/feature/shared/component/pressable_button.dart';

class SignupEmailView extends StatefulWidget {
  final String id;
  final String password;

  const SignupEmailView({super.key, required this.id, required this.password});

  @override
  State<SignupEmailView> createState() => _SignupEmailViewState();
}

class _SignupEmailViewState extends State<SignupEmailView> {
  @override
  void initState() {
    super.initState();
    final vm = context.read<SignupEmailViewModel>();
    vm.setCredentials(widget.id, widget.password);
  }



  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignupEmailViewModel>();
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          FocusScope.of(context).unfocus();
        },
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
                                  "이메일",
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
                                type: vm.isTimerRunning ?
                                AuthTextFieldType.custom:
                                    AuthTextFieldType.email
                                ,
                                customSuffixIcon: Padding(
                                    padding: EdgeInsets.only(right: 12),
                                  child : Text(
                                    '${vm.remainingSeconds ~/ 60}:${(vm.remainingSeconds % 60).toString().padLeft(2, '0')}',
                                      style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Color(0xFFE6989D)
                                      )
                                  )
                                ),
                                onTap: (){vm.sendEmail();},
                                prefixIconPath: 'assets/icons/email.svg',
                                controller: vm.emailEditingController,
                                hintText: '이메일을 입력해주세요',
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
                                  "인증번호",
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 14,
                                      color: Color(0xFFA7A7A7),
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              PinCodeTextField(
                                autoDisposeControllers: false,
                                controller: vm.verifyCodeEditingController,
                                textStyle: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 25,
                                  color: Color(0xFFA7A7A7),
                                  fontWeight: FontWeight.w400,
                                ),
                                showCursor: false,
                                appContext: context,
                                length: 6,
                                animationType: AnimationType.none,
                                pinTheme: PinTheme(
                                  fieldWidth: 50,
                                  fieldHeight: 60,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(12),
                                  activeColor: Color(0xFFEDEDED),
                                  selectedColor: Color(0xFFFFDADA),
                                  inactiveColor: Color(0xFFEDEDED),
                                ),
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
                              await vm.verify();
                              if (vm.isVerify ) {
                                await vm.signup();
                                if(vm.isSignUpFinish){
                                  print("회원가입 성공");
                                }
                              };
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
