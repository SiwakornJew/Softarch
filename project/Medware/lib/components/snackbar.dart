import 'package:flutter/material.dart';

class SnackBar_show {
  SnackBar_show._();
  static buildErrorSnackbar(BuildContext context, String error_text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        content: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            //set border radius more than 50% of height and width to make circle
          ),
          color: Colors.red,
          child: ListTile(
            leading: Icon(
              Icons.error_outline_outlined,
              color: Colors.white,
            ),
            title: Text(
              error_text,
              style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  static buildSuccessSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            //set border radius more than 50% of height and width to make circle
          ),
          color: Colors.green,
          child: ListTile(
            leading: Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.white,
            ),
            title: Text(
              text,
              style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
