import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:turlgo/feature/main/presentation/home/test/result/test_result_view_model.dart';
import 'package:turlgo/feature/model/animal_preference.dart';

class TestResultView extends StatefulWidget {

  final AnimalPreference animalPref;
  const TestResultView({super.key, required this.animalPref});

  @override
  State<TestResultView> createState() => _TestResultViewState();
}

class _TestResultViewState extends State<TestResultView> {
  late TestResultViewModel vm;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TestResultViewModel>().setPref(widget.animalPref);
    });
  }

  @override
  Widget build(BuildContext context) {
    vm = context.watch<TestResultViewModel>();
    
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
        width: double.infinity,
        color: Colors.white,
        child: vm.isLoading ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/images/result_cat.png',
              width: 300,
            ),
            Text(
                'AI가 응답을 생성하는 중이에요!',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(
              height: 100,
              child: LoadingIndicator(
                  indicatorType: Indicator.ballPulseSync,
                  colors: const [Colors.grey],
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                  pathBackgroundColor: Colors.black
              ),
            )
          ],
        ) : ListView(
          children: [
        Padding(
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
                  SizedBox(height: 20),
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
                                '진단결과',
                                style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color(0xFFBA51CD)
                                ),
                              ),
                              Text(
                                '를 통해',
                                style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '반려동물을 찾아보세요!',
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/result_cat.png',
                        width: 60,
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  Container( //주관식 형태
                      decoration: BoxDecoration(
                          color: Color(0xFFFDF2F8),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      width: double.infinity,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text(
                                '추천견종',
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                color: Color(0xFFEF798A)
                              ),
                            ),
                            SizedBox(height: 14,),
                            Column(
                              children: List.generate(
                                vm.results.length,
                                  (index) {
                                    final item = vm.results[index];
                                    return Column(
                                      children: [
                                        Text(
                                            '• ${item.breed} - ${item.personality}',
                                            softWrap: true,
                                          style: TextStyle(
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Color(0xFF374151)
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                      color: Color(0xFFE5E7EB),
                                                    ),
                                                  ),
                                                  LayoutBuilder(
                                                    builder: (context, constraints) {
                                                      return Container(
                                                        width: constraints.maxWidth * (int.parse(item.percentage.replaceAll('%', ''))/100),
                                                        height: 12,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                          color: Color(0xFFEF798A),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Text(
                                                item.percentage,
                                              style: TextStyle(
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  color: Color(0xFFEF798A)
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                              ),
                            ),
                            SizedBox(height: 24,)
                          ],
                        ),
                      )
                  ),
                  SizedBox(height: 24,),
                  Container( //주관식 형태
                      decoration: BoxDecoration(
                          color: Color(0xFFFEFCE8),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      width: double.infinity,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24,),
                            Text(
                                "견종별 특징",
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color(0xFF854D0E)
                              ),
                            ),
                            Column(
                                children: List.generate(
                                    vm.results.length,
                                        (index) {
                                      final item = vm.results[index];
                                      return Column(
                                        children: [
                                          Text(
                                            '• ${item.breed}: ${item.traits}',
                                            softWrap: true,
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: Color(0xFF374151)
                                            ),
                                          ),
                                          SizedBox(height: 10)
                                        ],
                                      );
                                    }
                                )
                            ),
                            SizedBox(height: 12,)
                          ],
                        ),
                      )
                  ),
                  SizedBox(height: 30,)
                ],
              ),
            ),
          ),
          ],
        )
      ),
      ]
    )
    )
    );
  }
}