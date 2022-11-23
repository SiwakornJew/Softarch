import 'package:flutter/material.dart';
import 'package:medware/screens/main/event/patient/event_type_picker.dart'
    as patient;
import 'package:medware/screens/main/event/employee/event_type_picker.dart'
    as employee;

const List<Widget> screens = [
  employee.AppointmentTypeScreen(),
  patient.EventTypePicker()
];
