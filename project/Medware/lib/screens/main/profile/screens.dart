import 'package:flutter/material.dart';
import 'package:medware/screens/main/profile/view_profile/employee.dart'
    as employee;
import 'package:medware/screens/main/profile/view_profile/patient.dart'
    as patient;

const List<Widget> screens = [
  employee.Profile(),
  patient.Profile(),
  MaterialApp(),
];
