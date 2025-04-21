import 'package:flutter/material.dart';

class EducationView extends StatefulWidget {
  const EducationView({super.key});

  @override
  State<EducationView> createState() => _EducationViewState();
}

class _EducationViewState extends State<EducationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("education_view")),
    );
  }
}