import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:turlgo/feature/main/presentation/home/home_view_model.dart';
import 'package:turlgo/feature/shared/component/pressable_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeViewModel>().getAnimalList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: SafeArea(child:
        RefreshIndicator(
          onRefresh: vm.getAnimalList,
            child: ListView(
              children: [Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            'assets/images/logo.svg',
                            width: 85,
                            color: Color(0xFFCFD3DA),
                          )
                      )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 13, 20, 0),
                      child: PressableButton(
                        onTap: (){print("object");},
                        height: 140,
                        color: Color(0xFFFEF2C5),
                        borderRadius: BorderRadius.circular(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child:
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
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Image.asset(
                                  'assets/images/test_cat.png',
                                height: 250,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
                        child: Row(
                          children: [
                            Text(
                                '반려동물',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 18
                              ),
                            ),
                            Spacer(),
                            CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){context.go('/adoption');},
                                child: Row(
                                  children: [
                                    Text(
                                        '전체보기',
                                      style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Color(0xFF9CA3AF)
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 7),
                                      child: SvgPicture.asset(
                                        'assets/icons/back_reverse.svg',
                                        width: 6,
                                        color: Color(0xFF9CA3AF),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ],
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: SizedBox(
                        height: 200, // ListView 높이 고정
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: vm.animals.length,
                          itemBuilder: (context, index) {
                            final item = vm.animals[index];
                            return Padding(
                              padding: index == 0 ? EdgeInsets.only(left: 20, right: 6) :  EdgeInsets.symmetric(horizontal: 6),
                              child: PressableButton(
                                width: 150,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                onTap: () {
                                  print(item.name);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius : BorderRadius.only(
                                        topLeft : Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        'https://${item.photoUrls[0]}',
                                        height: 120,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left : 12, top: 10,
                                          ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                item.name,
                                              style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  item.species,
                                                  style: TextStyle(
                                                      fontFamily: 'Pretendard',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xFF6B7280),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/mini_dot.svg',
                                                    color: Color(0xFF6B7280),
                                                    width: 2,
                                                  ),
                                                ),
                                                Text(
                                                  item.age,
                                                  style: TextStyle(
                                                    fontFamily: 'Pretendard',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFF6B7280),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),Padding(
                  padding: EdgeInsets.fromLTRB(22, 20, 22, 0),
                  child: Row(
                    children: [
                      Text(
                        '입양 교육',
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                        ),
                      ),
                      Spacer(),
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){context.go('/education');},
                          child: Row(
                            children: [
                              Text(
                                '전체보기',
                                style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xFF9CA3AF)
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: SvgPicture.asset(
                                  'assets/icons/back_reverse.svg',
                                  width: 6,
                                  color: Color(0xFF9CA3AF),
                                ),
                              )
                            ],
                          )
                      ),
                    ],
                  )
              ),
            Padding(
              padding: EdgeInsets.only(top: 14),
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.videos.length,
                  itemBuilder: (context, index) {
                    final item = vm.videos[index];
                    return Padding(
                      padding: index == 0 ?  EdgeInsets.only(left: 20, right: 6) : EdgeInsets.symmetric(horizontal: 6),
                      child: PressableButton(
                        onTap: () {
                          context.push('/video',extra: item);
                        },
                        width: 320,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                              child: Image.network(
                                'https://img.youtube.com/vi/${item.videoId}/mqdefault.jpg',
                                width: 320,
                                fit: BoxFit.cover,
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    item.description,
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
                SizedBox(height: 30,)
            ]
              ),
            )
        )
      );
  }
}