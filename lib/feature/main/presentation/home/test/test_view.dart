import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turlgo/feature/model/animal_preference.dart';
import 'package:turlgo/feature/shared/component/pressable_button.dart';
import 'package:turlgo/feature/shared/util/show_toast.dart';

enum HouseType { apartment, singleFamilyHouse, multiFamilyHouse }
enum PrefAnimal { cat, dog }
enum SheddSens {very, low, no}
enum HasAllergy {yes, no}



class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  HouseType? _scHouseType;
  PrefAnimal? _scPrefAnimal;
  SheddSens? _scSheddSens;
  HasAllergy? _scHasAllergy;

  final TextEditingController refPerController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        '마이펫 테스트',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                color: Color(0xFFFCE4E8),
                                width: 2.0,
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 33),
                            child: Column(
                              children: [
                                SizedBox(height: 23),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '# AI 반려동물 매칭',
                                          style: TextStyle(
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF888888),
                                              fontSize: 14
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '나에게',
                                              style: TextStyle(
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16
                                              ),
                                            ),
                                            Text(
                                              ' 꼭 맞는 ',
                                              style: TextStyle(
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Color(0xFFBA51CD)
                                              ),
                                            ),
                                            Text(
                                              '반려동물을',
                                              style: TextStyle(
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '찾아보세요!',
                                          style: TextStyle(
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16
                                          ),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      'assets/images/test_cat.png',
                                      width: 60,
                                    )
                                  ],
                                ),
                                SizedBox(height: 12,),
                                Container(
                                    width: double.infinity,
                                    height: 2,
                                    color : Color(0xFFF3E8FF)
                                ),
                                SizedBox(height: 24,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFAF5FF),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20,),
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                            '1. 주거 형태를 알려주세요!',
                                          style: TextStyle(
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Radio<HouseType>(
                                                  value: HouseType.apartment,
                                                  groupValue: _scHouseType,
                                                  onChanged: (HouseType? value) {
                                                    setState(() {
                                                      _scHouseType = value;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                    "아파트",
                                                    style: TextStyle(
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 14
                                                ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio<HouseType>(
                                                  value: HouseType.singleFamilyHouse,
                                                  groupValue: _scHouseType,
                                                  onChanged: (HouseType? value) {
                                                    setState(() {
                                                      _scHouseType = value;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "단독주택",
                                                  style: TextStyle(
                                                      fontFamily: 'Pretendard',
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 14
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio<HouseType>(
                                                  value: HouseType.multiFamilyHouse,
                                                  groupValue: _scHouseType,
                                                  onChanged: (HouseType? value) {
                                                    setState(() {
                                                      _scHouseType = value;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "다세대 주택/빌라",
                                                  style: TextStyle(
                                                      fontFamily: 'Pretendard',
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 14
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ),
                                SizedBox(height: 24,),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFAF5FF),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20,),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            '2. 선호하는 동물을 알려주세요!',
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 40),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Radio<PrefAnimal>(
                                                    value: PrefAnimal.dog,
                                                    groupValue: _scPrefAnimal,
                                                    onChanged: (PrefAnimal? value) {
                                                      setState(() {
                                                        _scPrefAnimal = value;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "강아지",
                                                    style: TextStyle(
                                                        fontFamily: 'Pretendard',
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 14
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio<PrefAnimal>(
                                                    value: PrefAnimal.cat,
                                                    groupValue: _scPrefAnimal,
                                                    onChanged: (PrefAnimal? value) {
                                                      setState(() {
                                                        _scPrefAnimal = value;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "고양이",
                                                    style: TextStyle(
                                                        fontFamily: 'Pretendard',
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 14
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                ),
                                SizedBox(height: 24),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFAF5FF),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20,),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            '3. 원하는 성격/특성을 적어주세요!',
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                          child: CupertinoTextField(
                                            controller: refPerController,
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 13
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    )
                                ),
                                SizedBox(height: 24),
                              Container(
                              decoration: BoxDecoration(
                              color: Color(0xFFFAF5FF),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    '4. 털에 대해 얼마나 민감하신가요?',
                                    style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Radio<SheddSens>(
                                            value: SheddSens.no,
                                            groupValue: _scSheddSens,
                                            onChanged: (SheddSens? value) {
                                              setState(() {
                                                _scSheddSens = value;
                                              });
                                            },
                                          ),
                                          Text(
                                            "없음",
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio<SheddSens>(
                                            value: SheddSens.low,
                                            groupValue: _scSheddSens,
                                            onChanged: (SheddSens? value) {
                                              setState(() {
                                                _scSheddSens = value;
                                              });
                                            },
                                          ),
                                          Text(
                                            "적음",
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio<SheddSens>(
                                            value: SheddSens.very,
                                            groupValue: _scSheddSens,
                                            onChanged: (SheddSens? value) {
                                              setState(() {
                                                _scSheddSens = value;
                                              });
                                            },
                                          ),
                                          Text(
                                            "높음",
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                                SizedBox(height: 24,),
                                Container( //주관식 형태
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFAF5FF),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20,),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            '5. 하루 몇시간 정도 같이 보낼수 있으신가요?',
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20),
                                          child: CupertinoTextField(
                                            controller: timeController,
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 13
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    )
                                ),
                                SizedBox(height: 24,),
                                Container( //주관식 형태
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFAF5FF),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20,),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            '6. 반려동물을 위해 어느정도의 돈을 쓸수 있나요?',
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20),
                                          child: CupertinoTextField(
                                            controller: budgetController,
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 13
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    )
                                ),
                                SizedBox(height: 24,),
                                Container( //라디오형태
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFAF5FF),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20,),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            '7. 알레르기 여부를 알려주세요!',
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 40),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Radio<HasAllergy>(
                                                    value: HasAllergy.yes,
                                                    groupValue: _scHasAllergy,
                                                    onChanged: (HasAllergy? value) {
                                                      setState(() {
                                                        _scHasAllergy = value;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "네",
                                                    style: TextStyle(
                                                        fontFamily: 'Pretendard',
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 14
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio<HasAllergy>(
                                                    value: HasAllergy.no,
                                                    groupValue: _scHasAllergy,
                                                    onChanged: (HasAllergy? value) {
                                                      setState(() {
                                                        _scHasAllergy = value;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "아니오",
                                                    style: TextStyle(
                                                        fontFamily: 'Pretendard',
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 14
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                ),
                                SizedBox(height: 50,),
                                PressableButton(
                                    onTap: (){
                                      if (_scHasAllergy != null &&
                                          _scHouseType != null &&
                                          _scPrefAnimal != null &&
                                          _scSheddSens != null &&
                                          refPerController.text.isNotEmpty &&
                                          timeController.text.isNotEmpty &&
                                          budgetController.text.isNotEmpty) {

                                        context.push(
                                          '/test_result',
                                          extra: AnimalPreference(
                                            housingType: _scHouseType!,
                                            preferredAnimal: _scPrefAnimal!,
                                            preferredPersonality: refPerController.text,
                                            sheddingSensitivity: _scSheddSens!,
                                            availableTime: timeController.text,
                                            budget: budgetController.text,
                                            hasAllergy: _scHasAllergy!,
                                          ),
                                        );
                                      }

                                      else {
                                        showToast("모든 항목을 작성해주세요!");
                                      }
                                    },
                                    child: Text(
                                      "진단하기",
                                      style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                        color: Colors.white
                                      ),
                                    )
                                ),
                                SizedBox(height: 30,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              )
            ],
          ),
        )
    );
  }
}