import 'package:flutter/material.dart';

class MyView extends StatefulWidget {
  const MyView({super.key});

  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF9FAFB),
      child: SafeArea(
          child:
          ListView(
            children: [
              SizedBox(height: 30,),

            ],
        )
      ),
    );
  }
}