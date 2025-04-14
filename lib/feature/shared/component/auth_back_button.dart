import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart'; // context.pop() 사용 시 필요

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          context.pop();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/back.svg',
              height: 14,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "뒤로가기",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
