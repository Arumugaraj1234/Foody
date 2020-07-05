import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foody/models/dish_data.dart';
import 'package:foody/screens/mobile_input_screen.dart';
import 'package:foody/support_files/api_services.dart';
import 'package:foody/widgets/rounded_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:foody/screens/home_screen.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkForUserLoggedInStatus();
  }

  void checkForUserLoggedInStatus() async {
    bool isUserLoggedIn = await ApiService.shared.getUserLoggedInStatus();
    if (isUserLoggedIn) {
      //Navigator.pushNamed(context, HomeScreen.id);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return HomeScreenProvider();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(child: Image.asset('images/folders.png')),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RoundedButton(
                        color: Colors.blue,
                        title: 'Google',
                        icon: Image.asset('images/google_icon.png'),
                        onTapped: () async {
                          FirebaseAuth _auth = FirebaseAuth.instance;
                          GoogleSignIn googleSignIn = GoogleSignIn();
                          final GoogleSignInAccount googleSignInAccount =
                              await googleSignIn.signIn();
                          final GoogleSignInAuthentication
                              googleSignInAuthentication =
                              await googleSignInAccount.authentication;

                          final AuthCredential credential =
                              GoogleAuthProvider.getCredential(
                            accessToken: googleSignInAuthentication.accessToken,
                            idToken: googleSignInAuthentication.idToken,
                          );
                          final AuthResult authResult =
                              await _auth.signInWithCredential(credential);
                          final FirebaseUser user = authResult.user;
//                          assert(!user.isAnonymous);
//                          assert(await user.getIdToken() != null);
//
//                          final FirebaseUser currentUser =
//                          await _auth.currentUser();
//                          assert(user.uid == currentUser.uid);
                          print('signInWithGoogle succeeded: $user');
                          if (user != null) {
                            String userId = user.uid == null ? '' : user.uid;
                            String name = user.displayName == null
                                ? ''
                                : user.displayName;
                            String email = user.email == null ? '' : user.email;

                            List<String> userDetails = [name, email, userId];
                            ApiService.shared.setUserLoggedInStatus(true);
                            ApiService.shared
                                .setUserDetails(userDetails: userDetails);
                            //Navigator.pushNamed(context, HomeScreen.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return HomeScreenProvider();
                              }),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RoundedButton(
                        color: Colors.green,
                        title: 'Phone',
                        icon: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onTapped: () {
//                          loginUser('+919912633995', context);
//                          print('Login with mobileno');
                          Navigator.pushNamed(context, MobileInputScreen.id);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return DishData();
      },
      child: HomeScreen(),
    );
  }
}
