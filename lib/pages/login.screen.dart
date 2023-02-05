import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quoteapp/app/route.app.dart';
import '../Components/text_form_field.dart';
import '../providers/auth.provider.dart';

enum AuthMode { signup, login }

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordC1 = TextEditingController();

  bool isPasswordVisible = true;
  bool isPasswordVisible1 = true;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.login;

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    passwordC1 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 23, 155),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 20,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0),
                  blurRadius: 20,
                  offset: Offset(0, 5),
                ),
              ],
              color: Color.fromARGB(255, 35, 35, 35),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Column(
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(_authMode == AuthMode.login ? 'Login' : 'Sign Up',
                            style: const TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          height: 100,
                        ),
                        TextEnterArea(
                          controller: emailC,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          hintText: 'Enter your email Address',
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!p0.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextEnterArea(
                          controller: passwordC,
                          textInputAction: TextInputAction.next,
                          obscureText:
                              isPasswordVisible == false ? true : false,
                          hintText: 'Enter your Password',
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Please enter your Password';
                            }
                            if (p0.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (_authMode == AuthMode.signup &&
                                p0 != passwordC1.text) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible == false
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (_authMode == AuthMode.signup)
                          TextEnterArea(
                            enabled: _authMode == AuthMode.signup,
                            controller: passwordC1,
                            textInputAction: TextInputAction.next,
                            obscureText:
                                isPasswordVisible1 == false ? true : false,
                            hintText: 'Enter your Confirmed Password',
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Please enter your Password';
                              }
                              if (p0.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              if (p0 != passwordC.text) {
                                return 'Password does not match';
                              }
                              return null;
                            },
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible1 == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible1 = !isPasswordVisible1;
                                });
                              },
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) {
                              // Invalid!
                              return;
                            }
                            formKey.currentState!.save();
                            setState(() {
                              isLoading = true;
                            });

                            try {
                              if (_authMode == AuthMode.login) {
                                // // Log user in
                                await Provider.of<Auth>(context, listen: false)
                                    .login(
                                      emailC.text,
                                      passwordC.text,
                                    )
                                    .then(
                                      (value) => Navigator.of(context)
                                          .pushReplacementNamed(
                                        MyRouter.quotes,
                                      ),
                                    );
                              } else {
                                // Sign user up
                                await Provider.of<Auth>(context, listen: false)
                                    .signup(
                                  emailC.text,
                                  passwordC.text,
                                );
                              }
                            } on HttpException catch (error) {
                              var errorMessage = 'Authentication failed';
                              if (error.toString().contains('EMAIL_EXISTS')) {
                                errorMessage =
                                    'This email address is already in use.';
                              } else if (error
                                  .toString()
                                  .contains('INVALID_EMAIL')) {
                                errorMessage =
                                    'This is not a valid email address';
                              } else if (error
                                  .toString()
                                  .contains('WEAK_PASSWORD')) {
                                errorMessage = 'This password is too weak.';
                              } else if (error
                                  .toString()
                                  .contains('EMAIL_NOT_FOUND')) {
                                errorMessage =
                                    'Could not find a user with that email.';
                              } else if (error
                                  .toString()
                                  .contains('INVALID_PASSWORD')) {
                                errorMessage = 'Invalid password.';
                              }
                              _showErrorDialog(errorMessage);
                            } catch (error) {
                              const errorMessage =
                                  'Could not authenticate you. Please try again later.';
                              _showErrorDialog(errorMessage);
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor:
                                const Color.fromARGB(255, 0, 92, 167),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  _authMode == AuthMode.login
                                      ? 'Login'
                                      : 'Signup',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _switchAuthMode();
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 30),
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 92, 167),
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            child: Text(
                              "${_authMode == AuthMode.login ? 'Signup' : 'Login'} Instead",
                            )),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ),
          const Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(145, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
