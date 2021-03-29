import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    //isSignedIn();

  }

//  void isSignedIn() async {
//    setState(() {
//      loading = true;
//    });
//
//    preferences = await SharedPreferences.getInstance();
//
//    isLoggedIn = await googleSignIn.isSignedIn();
//
//    if(isLoggedIn == true) {
//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
//    }
//
//    setState(() {
//      loading = false;
//    });
//  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    );

    User firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

    if(firebaseUser != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance.collection("users").where("id",isEqualTo: firebaseUser.uid).get();
      final List<DocumentSnapshot> documents = result.docs;
      if(documents.length == 0) {
        // insert the user to our collection
        FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).set({
          "id" : firebaseUser.uid,
          "username" : firebaseUser.displayName,
          "profilePicture" : firebaseUser.photoURL
        });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoUrl", firebaseUser.photoURL);
      }else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("photoUrl", documents[0]['photoUrl']);
      }

      Fluttertoast.showToast(msg: "Login was successful");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }else {
      Fluttertoast.showToast(msg: "Login Failed");
    }
  }
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
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blue,
                      elevation: 0.0,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text('Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                        ),
                        ),
                      )
                    ),
                  ),

                  Expanded(child: Container()),

                  Divider(color: Colors.white,),

                  Text('Other login in option',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.red,
                        elevation: 0.0,
                        child: MaterialButton(
                          onPressed: () {
                            handleSignIn();
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text('Google',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                            ),
                          ),
                        )
                    ),
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


