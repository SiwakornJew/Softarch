import 'package:flutter/material.dart';
import 'package:medware/screens/main/calendar/employee/calendar.dart'
    as employee;
import 'package:medware/screens/main/calendar/patient/calendar.dart' as patient;

const List<Widget> screens = [
  employee.CalendarScreen(),
  patient.CalendarScreen(),
  MaterialApp(),
];
