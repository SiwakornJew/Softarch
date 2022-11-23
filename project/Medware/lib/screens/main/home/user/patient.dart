import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:medware/screens/main/home/user/appointment_cards.dart';
import 'package:medware/screens/main/home/user/contact.dart';
import 'package:medware/screens/main/home/user/header.dart';
import 'package:medware/utils/api/appointment/get_patient_appointments.dart';
import 'package:medware/utils/models/appointment/patient_appointment.dart';
import 'package:medware/utils/statics.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final int role = SharedPreference.getUserRole();
  final int id = SharedPreference.getUserId();
  final String name = SharedPreference.getUserFName();

  Map<DateTime, List<PatientAppointment>> sortedValidAppointments = {};
  Future _loadAppointments() async {
    var appointments = await getPatientAppointments(id);
    setState(
      () => sortedValidAppointments = groupBy(
        appointments,
        (PatientAppointment pa) => pa.date,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadAppointments,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        backgroundColor: secondaryColor,
        color: quaternaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.only(bottom: 140),
          child: Column(
            children: [
              Header(role: role, name: name),
              AppointmentCards(
                role: role,
                appointments: sortedValidAppointments,
                refresh: _loadAppointments,
              ),
              Contact(),
            ],
          ),
        ),
      ),
    );
  }
}
