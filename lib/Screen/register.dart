import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/Model/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              title: const Text('Register'),
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
                                    .createUserWithEmailAndPassword(
                                        email: profile.email,
                                        password: profile.password)
                                    .then((value) => {
                                          print(profile.email +
                                              " " +
                                              profile.password),
                                          Fluttertoast.showToast(
                                            msg: "สร้างบัญชีเรียบร้อยแล้ว",
                                            gravity: ToastGravity.CENTER,
                                          ),
                                          _formKey.currentState!.reset(),
                                          Navigator.pop(context)
                                        });
                              } on FirebaseAuthException catch (e) {
                                Fluttertoast.showToast(
                                  msg: e.message!,
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            }
                          },
                          child: Text("Register"),
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
