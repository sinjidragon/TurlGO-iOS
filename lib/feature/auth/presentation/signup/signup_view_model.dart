import 'package:flutter/cupertino.dart';

class SignupViewModel extends ChangeNotifier {
  final TextEditingController idEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();

  void dispose() {
    idEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  List<String> get userInfo => [idEditingController.text,passwordEditingController.text];
}