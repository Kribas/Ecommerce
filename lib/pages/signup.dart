import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopsolutions/db/users.dart';
import 'package:flutter/material.dart';
import 'package:shopsolutions/pages/Home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserServices _userServices = UserServices();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  String gender;
  String groupValue = "male";
  bool hidePass = true;
  bool hideConfirmPass = true;

  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      resizeToAvoidBottomInset: false,
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
                                    border: InputBorder.none

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
                                  border: InputBorder.none
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
                        child: Container(
                          color: Colors.white.withOpacity(0.4),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("male",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),),

                                  trailing: Radio(value: "male",
                                      groupValue: groupValue,
                                      onChanged: (e) => valueChanged(e)),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("female",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  trailing: Radio(value: "female",
                                      groupValue: groupValue,
                                      onChanged: (e) => valueChanged(e)),
                                ),
                              )
                            ],
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
                            child: ListTile(
                              title: TextFormField(
                                obscureText: hidePass,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none
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
                              trailing: IconButton(onPressed: () {

                                if(hidePass == true) {
                                  setState(() {
                                    hidePass = false;
                                  });
                                }else if(hidePass == false){
                                  setState(() {
                                    hidePass = true;
                                  });

                                }

                              },
                                  icon: Icon(Icons.remove_red_eye)),

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
                            child: ListTile(
                              title: TextFormField(
                                obscureText: hideConfirmPass,
                                  decoration: InputDecoration(
                                    labelText: "Confirm Password",
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none
                                  ),

                                  keyboardType: TextInputType.emailAddress,
                                  controller: _confirmPasswordController,
                                  validator: (value) {
                                    if(value.isEmpty) {
                                      return "The password field cannot be empty";
                                    }else if(value.length < 6) {
                                      return "The password has to be atleast 6 characters long";
                                    }else if(_passwordTextController.text!=value) {
                                      return "the passwords do not match";
                                    }
                                    return null;
                                  }
                              ),
                                trailing: IconButton(onPressed: () {
                                  if(hideConfirmPass == true) {
                                    setState(() {
                                      hideConfirmPass = false;
                                    });
                                  }else if(hideConfirmPass == false){
                                    setState(() {
                                      hideConfirmPass = true;
                                    });

                                  }
                                },
                                    icon: Icon(Icons.remove_red_eye))
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.red.shade700,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () async {
                                validateForm();
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text('Sign up',
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
                                color: Colors.blue
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

  valueChanged(e) {
    setState(() {
      if(e == "male") {
        groupValue = e;
        gender = e;
      }else if(e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }

  Future validateForm() async {
    FormState formState = _formKey.currentState;
    if(formState.validate()) {
      formState.reset();
     final User user = firebaseAuth.currentUser;
     if(user == null) {
       firebaseAuth.createUserWithEmailAndPassword(
           email: _emailTextController.text,
           password: _passwordTextController.text)
       .then((user) => {
          _userServices.createUser(
              {
                "username": _nameTextController.text,
                "email": _emailTextController.text,
                "userId": user.user.uid,
                "gender": gender,
              }
          )
       }).catchError((err) => {print(err.toString())});

       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
     }
    }
  }
}
