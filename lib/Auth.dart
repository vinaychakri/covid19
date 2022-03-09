import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
abstract class BaseAuth{
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}
class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(String email, String password) async{
    var authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return authResult.user.uid;
  }
  Future<String> createUserWithEmailAndPassword(String email, String password) async{
    var authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return authResult.user.uid;
  }
  Future<String> currentUser() async{
    var authResult = await _firebaseAuth.currentUser;
    return authResult.uid;
  }
  Future<void> signOut()async{
    return _firebaseAuth.signOut();
  }
}
