import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medware/utils/statics.dart';

class DateTimeCard extends StatelessWidget {
  final DateTime date;
  final DateTime startTime;
  final DateTime finishTime;

  const DateTimeCard({
    Key? key,
    required this.date,
    required this.startTime,
    required this.finishTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.18,
      decoration: BoxDecoration(
        color: quaternaryColor,
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _Date(context, date),
          VerticalDivider(
            color: primaryColor,
            width: 5,
            thickness: 1,
            indent: size.height * 0.02,
            endIndent: size.height * 0.02,
          ),
          _Time(context, startTime, finishTime),
        ],
      ),
    );
  }

  Widget _Date(BuildContext context, DateTime date) {
    final size = MediaQuery.of(context).size;
    final dateFormatter = DateFormat('d MMMM y');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: size.width * 0.02),
          child: Icon(
            Icons.date_range,
            size: size.width * 0.1,
            color: primaryColor,
          ),
        ),
        Text(
          'วันที่',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w300,
            fontSize: size.width * 0.035,
          ),
        ),
        Text(
          dateFormatter.format(date),
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: size.width * 0.04,
          ),
        ),
      ],
    );
  }

  Widget _Time(BuildContext context, DateTime startTime, DateTime finishTime) {
    final size = MediaQuery.of(context).size;
    final timeFormatter = DateFormat.jm();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: size.width * 0.02),
          child: Icon(
            Icons.access_time,
            size: size.width * 0.1,
            color: primaryColor,
          ),
        ),
        Text(
          'เวลา',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w300,
            fontSize: size.width * 0.035,
          ),
        ),
        Text(
          '${timeFormatter.format(startTime)} - ${timeFormatter.format(finishTime)}',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: size.width * 0.04,
          ),
        ),
      ],
    );
  }
}
