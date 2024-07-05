import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/reusable_text.dart';

showAlertDialog({
required BuildContext context,
required String message,
String? btnText})
{

  return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: ReusableText(
              text: message, 
              style: appstyle(15, AppConst.white, FontWeight.normal)),
          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          actions: [

            TextButton(
                onPressed: (){
              Navigator.pop(context);
            },
                child: Text(btnText??"OK",style: appstyle(17, AppConst.grey, FontWeight.w500),))
          ],
        );
      });
}