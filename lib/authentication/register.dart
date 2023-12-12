import 'dart:io';

import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/screens/widgets/custom_text_field.dart';
import 'package:construction_app/screens/widgets/error_dailog.dart';
import 'package:construction_app/screens/widgets/loading_dailog.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> formValidation() async {
    if (passwordController.text == confirmPasswordController.text) {
      if (confirmPasswordController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneController.text.isNotEmpty) {
        //start uploading img /firestore
        // if (productController.isLoading.value == true) {
        showDialog(
            context: context,
            builder: (e) {
              return LoadingDailog(message: "Registering Account.");
            });
        // }

        //save info in  store
        productController.register(
            nameController.text.toString().trim(),
            phoneController.text.toString().trim(),
            emailController.text.toString().trim(),
            passwordController.text.toString().trim());
      } else {
        showDialog(
            context: context,
            builder: (e) {
              return const ErrorDailog(
                  message:
                      "Please write the complete required info in registraion.");
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (e) {
            return ErrorDailog(message: "Password do not  match.");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    data: Icons.person,
                    hintText: "Name",
                    isObsecre: false,
                  ),
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
                  CustomTextField(
                    controller: confirmPasswordController,
                    data: Icons.lock,
                    hintText: "Confirm password",
                    isObsecre: true,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    data: Icons.phone,
                    hintText: "Phone",
                    isObsecre: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                formValidation();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.cyan,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 20)),
              child: const Text(
                "Sign Up",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
