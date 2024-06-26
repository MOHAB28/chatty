import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      backgroundColor: color,
    );
  }

  static void showL(BuildContext context, [Widget? loader, Color? color]) {
    //set up the AlertDialog
    Dialog alert = Dialog(
      backgroundColor: color ?? Colors.transparent,
      elevation: 2.0,
      insetPadding: EdgeInsets.zero,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 25.0),
          color: Colors.white,
          child: loader ?? const CircularProgressIndicator(),
        ),
      ),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      barrierColor: color ?? Colors.transparent,
      builder: (BuildContext context) {
        //prevent Back button press
        return PopScope(
          canPop: false,
          child: alert,
        );
      },
    );
  }

  static hideL(BuildContext context) async {
    Navigator.pop(context);
  }
}
