import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toss_heads_or_tails/utils/common.dart';


extension DialogExtensions on BuildContext {
  Future<void> showMessageDialog(String? msg,{Color textColor:const Color(0xFF000E36)}) async{
   await showDialog(
        context: this,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              msg??"Null 1008",
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              )
            ],
          );
        });
  }

}
