import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:turlgo/feature/shared/component/page_indicator.dart';

import 'detail_view_model.dart';

class DetailView extends StatefulWidget {
  final String animalNo;

  const DetailView({super.key, required this.animalNo});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late DetailViewModel vm;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailViewModel>().setAnimalNo(widget.animalNo);
    });
  }

  @override
  Widget build(BuildContext context) {
    vm = context.watch<DetailViewModel>();

    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            '상세보기',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: RefreshIndicator(
            onRefresh: vm.getAnimalInfo,
            child: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: PreloadPageView.builder(
                          itemCount: vm.animalInfo.photoUrls.length,
                          itemBuilder: (context, index) {
                            final itemUrl = vm.animalInfo.photoUrls[index];
                            return Image.network(
                              'https://$itemUrl',
                              fit: BoxFit.cover,
                            );
                          },
                          onPageChanged: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          preloadPagesCount: 10,
                        ),
                      ),
                      Positioned(
                        bottom: 16,  // 하단 16px에 위치하도록 설정
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: PageIndicator(
                            itemCount: vm.animalInfo.photoUrls.length,
                            currentIndex: currentIndex,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              vm.animalInfo.name,
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 24,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            vm.animalInfo.breed,
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              color: Color(0xFF9CA3AF)
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xFFF9FAFB),
                                ),
                                height: 80,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '나이',
                                          style: TextStyle(
                                              fontFamily: 'Pretendard',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF4B5563)
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                            vm.animalInfo.age,
                                          style: TextStyle(
                                              fontFamily: 'Pretendard',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              ),
                            ),
                            SizedBox(width: 16), // 중간 간격
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xFFF9FAFB),
                                ),
                                height: 80,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '체중',
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF4B5563)
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '${vm.animalInfo.bodyWeight}kg',
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xFFF9FAFB),
                                ),
                                height: 80,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '성별',
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF4B5563)
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            vm.animalInfo.sex,
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                            SizedBox(width: 16), // 중간 간격
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xFFF9FAFB),
                                ),
                                height: 80,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '입소일',
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF4B5563)
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            vm.animalInfo.entranceDate,
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 9,
                    color: Color(0xFFF9FAFB),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(
                            '예상 비용',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 24,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Column(
                                  children: List.generate(vm.animalInfo.calculatedData.length, (index)  {
                                      final item = vm.animalInfo.calculatedData[index];
                                      return
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      item.name,
                                                    style: TextStyle(
                                                        fontFamily: 'Pretendard',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      color: Color(0xFF9CA3AF)
                                                    ),
                                                  ),
                                                  Text(
                                                      '${item.content}원',
                                                    style: TextStyle(
                                                        fontFamily: 'Pretendard',
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black
                                                    ),
                                                  ),
                                                ],
                                            ),
                                          ),
                                            SizedBox(height: 17,)
                                        ],
                                      );
                                  }),
                                ),
                                SizedBox(height: 40),
                                Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '합계',
                                        style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF9CA3AF)
                                        ),
                                      ),
                                      Text(
                                        '${vm.animalInfo.calculatedData.fold(0,(sum, item) => sum + item.content)}원',
                                        style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFEF798A)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 9,
                    width: double.infinity,
                    color: Color(0xFFF9FAFB),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '성격 및 특징',
                                style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text(
                                vm.animalInfo.introductionContent,
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                            SizedBox(height: 40,)
                          ]
                      )
                  )
                ],
              ),
            ),
        )
      );
    }
}
