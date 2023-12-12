import 'package:construction_app/authentication/login.dart';
import 'package:construction_app/authentication/register.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  // ignore: unnecessary_const
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color.fromARGB(255, 97, 224, 159),
                      offset: Offset(0, 1),
                    )
                  ]),
            ),
            title: const Text(
              'Construction',
              style: TextStyle(
                  fontFamily: 'Lobster', fontSize: 25, color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0.0,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  text: 'Login',
                ),
                Tab(
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  text: 'Register',
                )
              ],
              indicatorColor: Colors.white,
              indicatorWeight: 6,
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
                // ignore: unnecessary_const
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color.fromARGB(255, 253, 253, 253),
                    offset: Offset(0, 1),
                  )
                ]),
            child:
                const TabBarView(children: [LoginScreen(), RegisterScreen()]),
          ),
        ));
  }
}
