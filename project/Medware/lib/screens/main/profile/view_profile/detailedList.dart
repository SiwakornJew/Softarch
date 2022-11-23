import 'package:flutter/material.dart';
import 'package:medware/components/underlined_button.dart';
import 'package:medware/screens/main/profile/edit_profile/edit_medical_details.dart';
import 'package:medware/utils/statics.dart';

class DetailedList extends StatelessWidget {
  final String title;
  final List<String> details;
  final IconData icon;
  final Future<void> Function() refresh;

  const DetailedList({
    Key? key,
    required this.title,
    required this.details,
    required this.icon,
    required this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  details.length > 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: details
                              .map(
                                (detail) => Text(
                                  '\u2022 ${detail}',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: size.width * 0.035,
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : Text(
                          'ไม่มีข้อมูล${title}ของคุณ',
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
          UnderlinedButton(
            text: 'แก้ไข',
            color: primaryColor,
            action: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditMedicalDetails(
                  title: title,
                  details: details,
                ),
              ),
            ).then((value) async => await refresh()),
          ),
        ],
      ),
    );
  }
}
