import 'package:flutter/material.dart';
import 'package:medware/screens/main/home/admin/add_doc.dart';
import 'package:medware/screens/main/home/admin/home.dart' as admin;
import 'package:medware/screens/main/home/user/employee.dart' as employee;
import 'package:medware/screens/main/home/user/patient.dart' as patient;

const List<Widget> screens = [employee.Home(), patient.Home(), AddEmployee()];
