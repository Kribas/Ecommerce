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
          fit: BoxFit.cover,
          width: double.infinity,
          ),
          Container(
            color: Colors.red.withOpacity(0.2),
            width: double.infinity,
            height: double.infinity,
          ),

          Container(
            alignment: Alignment.center,
            child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email = "
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTextController,
                    validator: (value) => !value.contains('@') ? "Field must contain a valid email" : null,
                  )
                ],
              )),
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

      bottomNavigationBar: Container(

        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
          child: FlatButton(
              color: Colors.red,
              onPressed: () {
                handleSignIn();
              },
              child: Text(
                "Sign in / Sign up with google",
                style: TextStyle(color: Colors.white),
              )),
        ),

      ),

    );

    }
  }


