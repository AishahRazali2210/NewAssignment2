import 'dart:async';
import 'dart:convert';
import 'package:assignment_2/config.dart';
import 'package:assignment_2/registrationScreen.dart';
import 'package:assignment_2/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Homestay Raya",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              CircularProgressIndicator(),
              Text("Version 0.1b")
            ]),
      ),
    );
  }

  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _email = (prefs.getString('email')) ?? '';
    String _pass = (prefs.getString('pass')) ?? '';
    if (_email.isNotEmpty) {
      http.post(Uri.parse("${Config.SERVER}homestayraya/php/login_user.php"),
          body: {"email": _email, "password": _pass}).then((response) {
        var jsonResponse = json.decode(response.body);
        if (response.statusCode == 200 && jsonResponse['status'] == "success") {
          var jsonResponse = json.decode(response.body);
          User user = User.fromJson(jsonResponse['data']);
          Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => const RegistrationScreen())));
        } else {
          User user = User(
              id: "0",
              email: "unregistered",
              name: "unregistered",
              phone: "0123456789",
              address: 'na',
              regdate: "0",
              credit: '0');
          Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => const RegistrationScreen())));
        }
      });
    } else {
      User user = User(
          id: "0",
          email: "unregistered",
          name: "unregistered",
          phone: "0123456789",
          address: 'na',
          regdate: "0",
          credit: '0');
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => const RegistrationScreen())));
    }
  }
}
