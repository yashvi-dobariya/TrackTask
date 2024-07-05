
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/common/helper/db_helper.dart';
import 'package:todo/common/routes/routes.dart';
import 'package:todo/common/widgets/show_dialogue.dart';

final authRepositoryProvider=Provider((ref) => AuthRepository(auth: FirebaseAuth.instance));

class AuthRepository {

  AuthRepository({required this.auth});
  final FirebaseAuth auth;

  void verifyOtp({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted}) async{

    try{
      final credential=PhoneAuthProvider.credential(
          verificationId: smsCodeId,
          smsCode: smsCode);
      await auth.signInWithCredential(credential);
      if(!mounted){
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    }on FirebaseAuth
    catch(e){
      showAlertDialog(context: context, message: e.toString());
      //print("${e.toString()}");
     
    }
  }
  
  void sendOtp({
  required BuildContext context,
  required String phone,
  }) async{

  try{
    await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e){
          showAlertDialog(context: context, message: e.toString());
        },
        codeSent: (smsCodeId,resendCodeId){
          DBHelper.createUser(1);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.otp,
                (route) => false,
            arguments:{
              'phone':phone,
              'smsCodeId':smsCodeId
            });
        },
        codeAutoRetrievalTimeout: (String smsCodeId){});
    
  } on FirebaseAuth 
  catch(e){
    showAlertDialog(context: context, message: e.toString());


  }

  }


}