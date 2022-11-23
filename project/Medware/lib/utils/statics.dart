import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF1C6758);
Color secondaryColor = const Color(0xFF3D8361);
Color tertiaryColor = const Color(0xFFD6CDA4);
Color quaternaryColor = const Color(0xFFEEF2E6);

String baseUrl = 'https://medware1.herokuapp.com';

List<String> employeeRoles = [
  '',
  'แพทย์',
  'พยาบาล',
];

List<String> appointmentTypes = [
  '',
  'นัดหมายพิเศษ',
  'ตรวจสุขภาพ',
  'บริจาคเลือด',
];

List<String> notificationTypes = [
  '',
  'ระบบ',
  'เลื่อนนัด',
  'ยกเลิก',
  'โอนถ่าย',
];

List<String> bloodTypes = [
  '',
  'A (positive)',
  'A (negative)',
  'B (positive)',
  'B (negative)',
  'O (positive)',
  'O (negative)',
  'AB (positive)',
  'AB (negative)',
];

List<String> departments = [
  '',
  'ดูแลก่อนคลอด', // ANC
  'ห้องคลอด', // LR
  'ผู้ป่วยโรคหัวใจและหลอดเลือด', // CCU
  'อุบัติเหตุและฉุกเฉิน', // ER
  'ผู้ป่วยวิกฤต', // ICU
  'ผู้ป่วยนอก', // IPD
  'ผู้ป่วยใน', // OPD
  'ห้องปฏิบัติการ', // LAB
  'อายุรกรรม', // MED
  'สูตินรีเวช', // OB-GYN
  'ห้องผ่าตัด', // OR
  'ผู้ป่วยที่มีปัญหาเรื่องกระดูก', // ORTHO
  'กุมารเวชกรรม', // PED
  'หู คอ จมูก', // ENT
  'ศัลยกรรม', // SUR
  'เวชศาสตร์ฟื้นฟู', // PT
  'เภสัชกรรม', // RX
  'วิสัญญี', // AN
];

List<String> profilePictures = [
  'assets/images/profile/d.png',
  'assets/images/profile/m1.png',
  'assets/images/profile/m2.png',
  'assets/images/profile/m3.png',
  'assets/images/profile/f1.png',
  'assets/images/profile/f2.png',
  'assets/images/profile/f3.png',
];
