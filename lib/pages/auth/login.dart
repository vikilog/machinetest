import 'package:flutter/material.dart';
import 'package:machinetest/services/locator.dart';
import 'package:machinetest/services/navigation.dart';
import 'package:machinetest/widgets/appbar.dart';
import 'package:machinetest/widgets/loading.dart';

import '../../services/auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool signUp = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: signUp ? 'SignUp' : 'Login', showBackButton: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              signUp ? "Create Account" : "Welcome back!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              signUp ? "Create account to continue" : "Login to continue",
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: '*********'),
              ),
            ),
            GestureDetector(
                onTap: () => {
                      signUp
                          ? signUpWithEmailAndPassword()
                          : logInWithEmailAndPassword()
                    },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: loading ? Colors.white : Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: loading
                        ? const Loading()
                        : Text(
                            signUp ? "Create account" : "Login",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                signUp ? "Already have an account" : "Don't have an account?",
                style: const TextStyle(fontSize: 15),
              ),
              GestureDetector(
                onTap: () => {
                  setState(() {
                    signUp = !signUp;
                  })
                },
                child: Text(
                  signUp ? " Login" : " Register",
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  logInWithEmailAndPassword() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      showSnackBar("Please enter email and password");
    } else {
      try {
        setState(() {
          loading = true;
        });
        var data = await locator<Auth>()
            .signIn(email.text.trim(), password.text.trim());
        if (data != null) {
          showSnackBar("Login successfully");
        }
        return locator<NavigationService>().navigateToAndRemove('/bottomBar');
      } catch (e) {
        showSnackBar(e.toString());
        setState(() {
          loading = false;
        });
      }
    }
  }

  signUpWithEmailAndPassword() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      showSnackBar("Please enter email and password");
    } else {
      try {
        setState(() {
          loading = true;
        });
        var data = await locator<Auth>()
            .signUp(email.text.trim(), password.text.trim());
        if (data != null) {
          showSnackBar("Account created successfully");
        }
        return locator<NavigationService>().navigateToAndRemove('/bottomBar');
      } catch (e) {
        showSnackBar(e.toString());
        setState(() {
          loading = false;
        });
      }
    }
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
