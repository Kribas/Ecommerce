import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  String gender;

  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Stack(
        children: <Widget>[
          Image.asset('images/backgroundImage.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Full Name",
                                  icon: Icon(Icons.person),
                                ),
                                keyboardType: TextInputType.text,
                                controller: _nameTextController,
                                validator: (value) {
                                  if(value.isEmpty) {
                                    return "The name field cannot be empty";
                                  }
                                  return null;
                                }
                            ),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email",
                                icon: Icon(Icons.alternate_email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailTextController,
                              validator: (value) => !value.contains('@') ? "Field must contain a valid email" : null,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  icon: Icon(Icons.lock_outline),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller: _passwordTextController,
                                validator: (value) {
                                  if(value.isEmpty) {
                                    return "The password field cannot be empty";
                                  }else if(value.length < 6) {
                                    return "The password has to be atleast 6 characters long";
                                  }
                                  return null;
                                }
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  icon: Icon(Icons.lock_outline),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller: _confirmPasswordController,
                                validator: (value) {
                                  if(value.isEmpty) {
                                    return "The password field cannot be empty";
                                  }else if(value.length < 6) {
                                    return "The password has to be atleast 6 characters long";
                                  }
                                  return null;
                                }
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () {},
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text('Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                ),
                              ),
                            )
                        ),
                      ),


                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text("Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red
                            ),),
                          )
                      )
                    ],
                  )
              ),
            ),
          ),
          Visibility(
              visible: loading ?? true,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.9),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ))
        ],

      ),
    );

  }
}
