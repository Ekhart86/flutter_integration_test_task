import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_integration_test_task/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _testEmail = 'wiotest@gmail.com';
  static const _testPassword = 'wiotestpass';

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _inputPadding = const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.pink[200],
                radius: 60.0,
                child: const Text(
                  'WIO',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 48.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: _inputPadding,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is empty';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Email is incorrect';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                autofocus: false,
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: _inputPadding,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is empty';
                  }
                  if (value.length < 8) {
                    return 'Password is too short';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_emailController.text != _testEmail) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'The user with email ${_emailController.text} was not found.',
                            ),
                          ),
                        );
                      } else if (_passwordController.text != _testPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Invalid password for user ${_emailController.text}',
                            ),
                          ),
                        );
                      } else {
                        _passwordController.clear();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              email: _emailController.text,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 45),
                    primary: Colors.lightBlueAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('Log In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
