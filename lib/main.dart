// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication.dart';

final auth = Authentication();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login Demo',
      getPages: [
        GetPage(
          name: "/",
          page: () => LoginScreen(),
        ),
        GetPage(
          name: "/login",
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignupPage(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
      ],
      defaultTransition: Transition.rightToLeft,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _isObscure = true.obs;
  var _isVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
      body: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
              width: 200,
            ),

            // Login text Widget
            Center(
              child: Container(
                height: 200,
                width: 400,
                alignment: Alignment.center,
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(
              height: 60,
              width: 10,
            ),

            // Wrong Password text
            Obx(
              () => Visibility(
                visible: _isVisible.value,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Wrong credentials entered",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),

            // Textfields for username and password fields
            Obx(
              () => Container(
                height: 140,
                width: 530,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onTap: () {
                        _isVisible.value = false;
                      },
                      controller: usernameController, // Controller for Username
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Username",
                          contentPadding: EdgeInsets.all(20)),
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    TextFormField(
                        onTap: () {
                          _isVisible.value = false;
                        },
                        controller:
                            passwordController, // Controller for Password
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            contentPadding: EdgeInsets.all(20),
                            // Adding the visibility icon to toggle visibility of the password field
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure.value
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                _isObscure.value = !(_isObscure.value);
                              },
                            )),
                        obscureText: _isObscure.value),
                  ],
                ),
              ),
            ),

            // Submit Button
            Container(
              width: 570,
              height: 70,
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text("Submit", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (auth.fetchCredentials(
                        usernameController.text, passwordController.text)) {
                      Get.offNamed("/home");
                    } else {
                      _isVisible.value = true;
                    }
                  }),
            ),

            // Register
            Container(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Center(
                    child: RichText(
                  text: TextSpan(
                    text: "Dont have an account? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                          text: " Register here",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => {Get.toNamed("/signup")}),
                    ],
                  ),
                )))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "Company name, Inc",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
                height: 400,
                width: 200,
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  "Successfull login!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
          ),
          Container(
            height: 100,
            width: 570,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 2,
                ),
                child: Text("Logout", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Get.offNamed('/login');
                }),
          )
        ],
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
      body: SignupPageContent(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Company name, Inc",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}

class SignupPageContent extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  var _isVisible = false.obs;
  var _isObscure1 = true.obs;
  var _isObscure2 = true.obs;
  var returnVisibilityString = "".obs;

  bool returnVisibility(String password1, String password2, String username) {
    if (password1 != password2) {
      returnVisibilityString.value = "Passwords do not match";
    } else if (username == "") {
      returnVisibilityString.value = "Username cannot be empty";
    } else if (password1 == "" || password2 == "") {
      returnVisibilityString.value = "Password fields cant be empty";
    } else if (!auth.isPasswordCompliant(password1)) {
      returnVisibilityString.value = "Not password compliant";
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Sized Box
          SizedBox(
            height: 37.5,
            width: 400,
          ),

          // Signup Text
          Center(
            child: Container(
              height: 245,
              width: 400,
              alignment: Alignment.center,
              child: Text(
                "Signup",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Wrong password text
          Obx(
            () => Visibility(
              visible: _isVisible.value,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Text(
                  returnVisibilityString.value,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),

          // Signup Info
          Obx(
            () => Container(
              height: 215,
              width: 530,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onTap: () {
                      _isVisible.value = false;
                    },
                    controller: usernameController, // Controller for Username
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  TextFormField(
                    onTap: () {
                      _isVisible.value = false;
                    },

                    controller: passwordController1, // Controller for Password
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        contentPadding: EdgeInsets.all(20),
                        // Adding the visibility icon to toggle visibility of the password field
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure1.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            _isObscure1.value = !_isObscure1.value;
                          },
                        )),
                    obscureText: _isObscure1.value,
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  TextFormField(
                    onTap: () {
                      _isVisible.value = false;
                    },

                    controller: passwordController2, // Controller for Password
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Re-enter Password",
                        contentPadding: EdgeInsets.all(20),
                        // Adding the visibility icon to toggle visibility of the password field
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure2.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            _isObscure2.value = !_isObscure2.value;
                          },
                        )),
                    obscureText: _isObscure2.value,
                  ),
                ],
              ),
            ),
          ),

          // Signup Submit button
          Container(
            width: 570,
            height: 70,
            padding: EdgeInsets.only(top: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  if (kDebugMode) {
                    print(
                        "Username: ${usernameController.text}\npassword: ${passwordController1.text}\nretry password ${passwordController2.text}");
                  }

                  if (usernameController.text != "" &&
                      passwordController1.text == passwordController2.text &&
                      passwordController2.text != "" &&
                      auth.isPasswordCompliant(passwordController1.text)) {
                    if (!auth.checkUserRepeat(usernameController.text)) {
                      auth.insertCredentials(
                          usernameController.text, passwordController1.text);

                      Get.snackbar(
                        "Signup Successful",
                        "The signup has been successful",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        borderRadius: 20,
                        animationDuration: Duration(milliseconds: 500),
                        backgroundGradient: LinearGradient(colors: [
                          Colors.white,
                          Colors.grey,
                        ]),
                        boxShadows: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(5, 5),
                            spreadRadius: 5,
                            blurRadius: 8,
                          ),
                        ],
                        dismissDirection: DismissDirection.horizontal,
                        duration: Duration(milliseconds: 2000),
                        icon: Icon(
                          Icons.thumb_up,
                        ),
                        overlayBlur: 0.8,
                      );
                      Get.offAllNamed('/login');
                    } else {
                      returnVisibilityString.value = "Username already exists";
                      _isVisible.value = true;
                    }
                  } else {
                    _isVisible.value = returnVisibility(
                        passwordController1.text,
                        passwordController2.text,
                        usernameController.text);
                  }
                }),
          ),
        ],
      ),
    );
  }
}
