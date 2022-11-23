import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medware/screens/main/event/view_appointment/employee.dart'
    as employee;
import 'package:medware/screens/main/event/view_appointment/patient.dart'
    as patient;
import 'package:medware/utils/statics.dart';

class AppointmentCards extends StatelessWidget {
  final int role;
  final appointments;
  final Future<void> Function() refresh;

  const AppointmentCards({
    Key? key,
    required this.role,
    required this.appointments,
    required this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        appointments.length != 0
            ? Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: size.width * 0.095,
                  top: size.height * 0.05,
                ),
                child: Text(
                  'นัดหมายของคุณ',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.w700),
                ),
              )
            : SizedBox(),
        appointments.length == 0
            ? Padding(
                padding: EdgeInsets.all(size.width * 0.15),
                child: Text('ไม่มีการนัดหมายในตอนนี้...',
                    style: TextStyle(
                      color: tertiaryColor,
                      fontSize: size.width * 0.05,
                    )),
              )
            : ListView.builder(
                padding: EdgeInsets.only(bottom: size.height * 0.05),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: appointments.length,
                itemBuilder: (context, i) {
                  final keys = appointments.keys.toList();
                  final appointmentList = appointments[keys[i]];

                  return Column(
                    children: [
                      _DateTag(context, keys[i]),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appointmentList!.length,
                        itemBuilder: (context, j) {
                          final appointment = appointmentList[j];

                          return _AppointmentCard(
                            context,
                            role,
                            appointment,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
      ],
    );
  }

  Widget _AppointmentCard(BuildContext context, int role, appointment) {
    final size = MediaQuery.of(context).size;
    final fullDateFormatter = DateFormat('E d MMMM y');
    final timeFormatter = DateFormat.jm();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.width * 0.02,
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: quaternaryColor,
          borderRadius: BorderRadius.circular(
            size.width * 0.05,
          ),
        ),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => role == 0
                  ? employee.ViewAppointment(
                      appointment: appointment,
                      refresh: refresh,
                    )
                  : patient.ViewAppointment(
                      appointment: appointment,
                      refresh: refresh,
                    ),
            ),
          ),
          borderRadius: BorderRadius.circular(
            size.width * 0.05,
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: appointment.type == 1
                        ? Colors.amber[500]
                        : appointment.type == 2
                            ? Colors.blue[200]
                            : appointment.type == 3
                                ? Colors.red[400]
                                : Colors.grey,
                    borderRadius: BorderRadius.circular(
                      size.width * 0.03,
                    ),
                  ),
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Icon(
                    appointment.type == 1
                        ? Icons.medical_services_outlined
                        : appointment.type == 2
                            ? Icons.medical_services_outlined
                            : appointment.type == 3
                                ? Icons.water_drop_outlined
                                : Icons.settings,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointmentTypes[appointment.type],
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    Text(
                      '${fullDateFormatter.format(appointment.date)}\nเวลา ${timeFormatter.format(appointment.startTime)} - ${timeFormatter.format(appointment.finishTime)}',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _DateTag(BuildContext context, DateTime date) {
    final size = MediaQuery.of(context).size;
    final shortenedDateFormatter = DateFormat.MMMEd();

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.015,
      ),
      child: Container(
        width: size.width * 0.4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: quaternaryColor,
          borderRadius: BorderRadius.circular(size.width * 0.1),
        ),
        child: Text(
          shortenedDateFormatter.format(date),
          style: TextStyle(
              color: tertiaryColor,
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
