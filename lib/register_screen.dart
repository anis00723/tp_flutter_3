import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants.dart';
import 'items_list_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _email = "";
  var _password = "";
  var _repeatPassword = "";

  Future<void> register(BuildContext context) async {
    final AuthResponse res = await supabase.auth.signUp(
      email: _email,
      password: _password,
    );
    final Session? session = res.session;
    final User? user = res.user;

    if (!mounted) return;

    if (user != null) {
      context.showSnackBar(message: "Registered successfully");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ItemsListScreen(),
        ),
      );
    } else {
      context.showErrorSnackBar(message: "Error while registering");
    }
  }

  onRegisterPressed(BuildContext context) async {
    // Validate if the password and the repeat password are the same
    // If they are not the same, show an error message
    // If they are the same, call the register method
    if (_password != _repeatPassword) {
      context.showErrorSnackBar(message: "Passwords are not the same");
      return;
    }
    await register(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Confirm Password",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _repeatPassword = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => onRegisterPressed(context),
                      child: const Text("Register"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
