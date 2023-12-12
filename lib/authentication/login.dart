import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/screens/widgets/custom_text_field.dart';
import 'package:construction_app/screens/widgets/error_dailog.dart';
import 'package:construction_app/screens/widgets/loading_dailog.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //login

      showDialog(
          context: context,
          builder: (c) {
            return const LoadingDailog(
              message: "Checking Credentials",
            );
          });
      productController.login(emailController.text.toString().trim(),
          passwordController.text.toString().trim());
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDailog(
              message: "Please write email/password",
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: emailController,
                  data: Icons.email,
                  hintText: "Email",
                  isObsecre: false,
                ),
                CustomTextField(
                  controller: passwordController,
                  data: Icons.lock,
                  hintText: "Password",
                  isObsecre: true,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => formValidation(),
            style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 20)),
            child: const Text(
              "Login",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
