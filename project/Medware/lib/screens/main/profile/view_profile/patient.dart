import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medware/components/action_button.dart';
import 'package:medware/components/cancel_button.dart';
import 'package:medware/screens/auth/login.dart';
import 'package:medware/screens/main/profile/edit_profile/change_password.dart';
import 'package:medware/screens/main/profile/view_profile/detail.dart';
import 'package:medware/screens/main/profile/view_profile/detailedList.dart';
import 'package:medware/screens/main/profile/view_profile/header.dart';
import 'package:medware/screens/main/profile/view_profile/label.dart';
import 'package:medware/utils/api/user/get_patient_by_id.dart';
import 'package:medware/utils/statics.dart';
import 'package:medware/utils/models/user/patient.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final int id = SharedPreference.getUserId();

  Patient patient = Patient(
    id: 0,
    nationalId: 'XXXXXXXXXXXXX',
    fName: 'F',
    mName: 'M',
    lName: 'L',
    phoneNumber: 'XXXXXXXXXX',
    password: 'XXXXXXXX',
    birthDate: DateTime.parse('0001-01-01T00:00:00'),
    bloodType: 0,
    profilePic: 0,
    medicalConditions: [],
    drugAllergies: [],
    allergies: [],
  );

  Future _loadPatient() async {
    var temp = await getPatientById(id);
    setState(() => patient = temp);
  }

  @override
  void initState() {
    super.initState();
    _loadPatient();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadPatient,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        backgroundColor: quaternaryColor,
        color: primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            children: [
              Header(
                role: 1,
                path: profilePictures[2],
                refresh: _loadPatient,
              ),
              Container(
                width: size.width * 0.85,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * 0.03,
                      ),
                      child: Label(
                        fName: patient.fName,
                        mName: patient.mName,
                        lName: patient.lName,
                        role: 'ผู้ป่วย',
                      ),
                    ),
                    Detail(
                      title: 'หมายเลขประจำตัวบัตรประชาชน',
                      detail: "**********${patient.nationalId.substring(10)}",
                      icon: Icons.badge_outlined,
                    ),
                    Detail(
                      title: 'เลขที่ประจําตัวผู้ป่วยนอก',
                      detail: patient.id.toString().padLeft(10, "0"),
                      icon: Icons.medical_information_outlined,
                    ),
                    Detail(
                      title: 'หมู่เลือด',
                      detail: bloodTypes[patient.bloodType],
                      icon: Icons.bloodtype_outlined,
                    ),
                    Detail(
                      title: 'เบอร์โทรศัพท์',
                      detail: patient.phoneNumber,
                      icon: Icons.phone_rounded,
                    ),
                    DetailedList(
                      title: 'โรคประจำตัว',
                      details: patient.medicalConditions,
                      icon: Icons.coronavirus_outlined,
                      refresh: _loadPatient,
                    ),
                    DetailedList(
                      title: 'การแพ้ยา',
                      details: patient.drugAllergies,
                      icon: Icons.vaccines_outlined,
                      refresh: _loadPatient,
                    ),
                    DetailedList(
                      title: 'ภูมิแพ้',
                      details: patient.allergies,
                      icon: Icons.sick_outlined,
                      refresh: _loadPatient,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * 0.075,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ActionButton(
                            text: 'เปลี่ยนรหัสผ่าน',
                            action: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePassword(
                                  oldPassword: patient.password,
                                ),
                              ),
                            ).then((value) async => await _loadPatient()),
                            percentWidth: 35,
                          ),
                          SizedBox(
                            width: size.width * 0.1,
                          ),
                          CancelButton(
                            text: 'ออกจากระบบ',
                            action: () {
                              HapticFeedback.lightImpact();
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('คุณแน่ใจหรือไม่?'),
                                  content: const Text(
                                      'คุณแน่ใจที่จะออกจากระบบหรือไม่?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('ไม่'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await SharedPreference.setToken('');
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Login(),
                                          ),
                                        );
                                      },
                                      child: const Text('ใช่'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            percentWidth: 35,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
