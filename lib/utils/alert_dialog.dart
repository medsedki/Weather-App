import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ALertDialog {
  static showSimpleAlert(
    BuildContext context,
    description,
    btnText,
    onPress,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      useSafeArea: true,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          content: Text(
            description,
            textAlign: TextAlign.center,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: GestureDetector(
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      btnText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () => onPress(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
