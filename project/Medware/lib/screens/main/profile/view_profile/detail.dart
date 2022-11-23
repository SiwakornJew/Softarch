import 'package:flutter/material.dart';
import 'package:medware/utils/statics.dart';

class Detail extends StatelessWidget {
  final String title;
  final String detail;
  final IconData icon;
  const Detail(
      {Key? key, required this.title, required this.detail, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
      width: double.infinity,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.05),
            child: Icon(
              icon,
              color: primaryColor,
              size: size.width * 0.1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
              Text(
                detail,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: size.width * 0.035,
                ),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
