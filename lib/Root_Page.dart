import 'package:covid19/dashboards/User_Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:covid19/Auth.dart';
import 'covid_registration/LoginPage.dart';
class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => new _RootPageState();

}
enum AuthStatus{
  notSignedIn,
  SignedIn
}
class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  @override
  void initState(){
    super.initState();
    widget.auth.currentUser().then((userId){
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn:AuthStatus.SignedIn;
      });

    });
  }
  void _signedIn(){
    setState(() {
      authStatus= AuthStatus.SignedIn;
    });

  }
  void _signedOut(){
    setState(() {
      authStatus= AuthStatus.notSignedIn;
    });

  }
  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(auth: widget.auth,
          onSignedIn:_signedIn,
        );
      case AuthStatus.SignedIn:
        return new User_Dashboard(auth: widget.auth,
            onSignedOut:_signedOut
        );

    }
  }
}