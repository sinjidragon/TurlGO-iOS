import 'package:flutter/material.dart';

class AdoptionView extends StatefulWidget {
  const AdoptionView({super.key});

  @override
  State<AdoptionView> createState() => _AdoptionViewState();
}

class _AdoptionViewState extends State<AdoptionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("adoption_view")),
    );
  }
}