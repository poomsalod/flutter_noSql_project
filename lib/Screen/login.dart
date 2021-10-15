import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/Model/profile.dart';
import 'package:flutter_final/Screen/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  Profile profile = new Profile(email: "", password: "");
  final Future<FirebaseApp> _firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email"),
                      TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "กรุณาป้อนอีเมลด้วยครับ"),
                          EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String? email) {
                          profile.email = email!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Password"),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
                        obscureText: true,
                        onSaved: (String? password) {
                          profile.password = password!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: profile.email,
                                        password: profile.password)
                                    .then((value) => {
                                          print(profile.email +
                                              " " +
                                              profile.password),
                                          _formKey.currentState!.reset(),
                                          Navigator.popUntil(
                                              context, (route) => false),
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return HomeScreen();
                                          }))
                                        });
                              } on FirebaseAuthException catch (e) {
                                Fluttertoast.showToast(
                                  msg: e.message!,
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            }
                          },
                          child: Text("Login"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
