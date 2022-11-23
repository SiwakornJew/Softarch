import 'package:medware/screens/main/event/patient/confirm_appointment.dart';
import 'package:medware/utils/statics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medware/screens/main/event/employee/patient_choosed.dart';
import 'package:medware/utils/models/user/patient.dart';
import 'package:medware/screens/main/event/employee/display_appointment.dart';

class DoctorCards extends StatelessWidget {
  final doctors;
  const DoctorCards({
    Key? key,
    required this.doctors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          doctors.length == 0
              ? Padding(
                  padding: EdgeInsets.all(size.width * 0.15),
                  child: Text('ไม่มีแพทย์ในขณะนี้...',
                      style: TextStyle(
                        color: tertiaryColor,
                        fontSize: size.width * 0.05,
                      )),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(bottom: size.height * 0.05),
                  shrinkWrap: true,
                  itemCount: doctors.length,
                  itemBuilder: (context, i) {
                    final keys = doctors.keys.toList();
                    final doctorsList = doctors[keys[i]];
                    return Column(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: doctorsList!.length,
                          itemBuilder: (context, j) {
                            final doctor = doctorsList[j];
                            return _DoctorCard(
                              context,
                              doctor,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
        ],
      ),
    );
  }
}

Widget _DoctorCard(BuildContext context, doctor) {
  final size = MediaQuery.of(context).size;

  return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.width * 0.02,
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: quaternaryColor,
          borderRadius: BorderRadius.circular(
            size.width * 0.03,
          ),
        ),
        child: InkWell(
          /*onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmAppointment(),
            ),
          ),*/
          borderRadius: BorderRadius.circular(
            size.width * 0.003,
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(doctor.doctor),
              ],
            ),
          ),
        ),
      ));
}


