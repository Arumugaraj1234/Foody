import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foody/screens/home_screen.dart';
import 'package:foody/support_files/api_services.dart';

class MobileInputScreen extends StatefulWidget {
  static const String id = 'mobile_input_screen';
  @override
  _MobileInputScreenState createState() => _MobileInputScreenState();
}

class _MobileInputScreenState extends State<MobileInputScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            print('Send to home screen');
          } else {
            ApiService.shared.showToastMessage(
                message: 'Your mobile no not yet registered',
                place: ToastGravity.BOTTOM,
                duration: Toast.LENGTH_LONG,
                bgColor: Colors.grey);
          }
          //This callback would gets called when verification is done automatically
        },
        verificationFailed: (AuthException exception) {
          print(exception);
          ApiService.shared.showToastMessage(
              message: 'Your mobile no not yet registered',
              place: ToastGravity.BOTTOM,
              duration: Toast.LENGTH_LONG,
              bgColor: Colors.grey);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Cancel"),
                      textColor: Colors.white,
                      color: Colors.black,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);
                        print('Credential: $credential');

                        AuthResult result =
                            await _auth.signInWithCredential(credential);
                        print('Result: $result');

                        FirebaseUser user = result.user;
                        print('User: $user');
                        if (user != null) {
                          String userId = user.uid == null ? '' : user.uid;
                          String name =
                              user.displayName == null ? '' : user.displayName;
                          String email = user.email == null ? '' : user.email;

                          List<String> userDetails = [name, email, userId];
                          ApiService.shared.setUserLoggedInStatus(true);
                          ApiService.shared
                              .setUserDetails(userDetails: userDetails);
                          Navigator.pushNamed(context, HomeScreen.id);
                        } else {
                          ApiService.shared.showToastMessage(
                              message: 'Invalid otp entered',
                              place: ToastGravity.BOTTOM,
                              duration: Toast.LENGTH_LONG,
                              bgColor: Colors.grey);
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Mobile Number"),
                    controller: _phoneController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.green),
                    child: FlatButton(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                      ),
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        final phone = '+91' + _phoneController.text.trim();
                        if (_phoneController.text.trim().length == 10) {
                          loginUser(phone, context);
                        } else {
                          ApiService.shared.showToastMessage(
                              message: 'Please provide valid mobile no',
                              place: ToastGravity.BOTTOM,
                              duration: Toast.LENGTH_LONG,
                              bgColor: Colors.grey);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
