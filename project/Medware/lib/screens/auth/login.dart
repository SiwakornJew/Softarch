import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:medware/components/text_field.dart';
import 'package:medware/screens/auth/register.dart';
import 'package:medware/screens/main/home/admin/add_doc.dart';
import 'package:medware/screens/main/main_screen.dart';
import 'package:medware/utils/api/auth/api_service.dart';
import 'package:medware/utils/statics.dart';
import 'package:medware/utils/models/auth/patient/paitent_login_request_model.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';

import '../../utils/models/auth/employee/employee_login_request_model.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginForm();
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginState();
}

class _LoginState extends State<LoginForm> {
  TextEditingController _unameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool _validate = false;
  bool isAPICallProcess = false;

  @override
  void dispose() {
    _unameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  String? get _errorUname {
    final text = _unameTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดใส่ข้อมูล';
    }
    if (text.length < 13) {
      return 'ข้อมูลไม่ถูกต้อง';
    }
    return null;
  }

  String? get _errorPassword {
    final text = _passwordTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดใส่ข้อมูล';
    }
    return null;
  }

  craeteRegisterInputNullDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "โปรดกรอกข้อมูลให้ถูกต้อง",
              style: TextStyle(fontFamily: 'NotoSansThai'),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: globalFormKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: secondaryColor,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  'MEDWARE',
                  style: TextStyle(
                      fontSize: 30,
                      color: quaternaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansThai'),
                ),
              ),
              padding: EdgeInsets.fromLTRB(0.0, size.width * 0.1, 0.0, 0.0),
              margin: EdgeInsets.fromLTRB(0.0, size.width * 0.1, 0.0, 0.0),
            ),
            Container(
              decoration: new BoxDecoration(
                  color: primaryColor,
                  borderRadius: new BorderRadius.all(
                    const Radius.circular(15.0),
                  )),
              padding: EdgeInsets.fromLTRB(size.width * 0.001, size.width * 0.1,
                  size.width * 0.02, size.width * 0.02),
              margin: EdgeInsets.fromLTRB(size.width * 0.15, size.width * 0.1,
                  size.width * 0.15, size.width * 0.1),
              child: Column(children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('เข้าสู่ระบบผู้ใช้',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: quaternaryColor,
                                  fontFamily: 'NotoSansThai')),
                        ),
                        margin: EdgeInsets.fromLTRB(
                            size.width * 0.01,
                            size.width * 0.01,
                            size.width * 0.01,
                            size.width * 0.05)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('หมายเลขบัตรประชาชน',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: quaternaryColor,
                                        fontFamily: 'NotoSansThai')),
                              ),
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.01,
                                  size.width * 0.0,
                                  size.width * 0,
                                  size.width * 0),
                              margin: EdgeInsets.fromLTRB(
                                  size.width * 0.01,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0)),
                          Container(
                              child: CustomTextField(
                                controller: _unameTextController,
                                validator: _errorUname,
                                obscureText: false,
                              ),
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.01,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0),
                              margin: EdgeInsets.fromLTRB(
                                  size.width * 0.01,
                                  size.width * 0.01,
                                  size.width * 0,
                                  size.width * 0.01)),
                        ]),
                        padding: EdgeInsets.all(size.width * 0.01),
                        margin: EdgeInsets.all(size.width * 0.02)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('รหัสผ่าน',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: quaternaryColor,
                                        fontFamily: 'NotoSansThai')),
                              ),
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.01,
                                  size.width * 0.0,
                                  size.width * 0,
                                  size.width * 0),
                              margin: EdgeInsets.fromLTRB(
                                  size.width * 0.01,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0)),
                          Container(
                              child: CustomTextField(
                                controller: _passwordTextController,
                                validator: _errorPassword,
                                obscureText: true,
                              ),
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.01,
                                  size.width * 0,
                                  size.width * 0,
                                  size.width * 0),
                              margin: EdgeInsets.fromLTRB(
                                  size.width * 0.01,
                                  size.width * 0.01,
                                  size.width * 0,
                                  size.width * 0.01)),
                        ]),
                        padding: EdgeInsets.all(size.width * 0.01),
                        margin: EdgeInsets.all(size.width * 0.02)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(5.0),
                                  textStyle: const TextStyle(fontSize: 15),
                                  backgroundColor: tertiaryColor),
                              onPressed: () {
                                if (_unameTextController.text == '' ||
                                    _passwordTextController.text == '') {
                                  craeteRegisterInputNullDialog(context);
                                } else {
                                  //Employee
                                  if (_unameTextController.text[0] == 'D' ||
                                      _unameTextController.text[0] == 'd') {
                                    EmployeeLoginRequestModel empModel =
                                        EmployeeLoginRequestModel(
                                      nationalCardId: _unameTextController.text
                                          .substring(1),
                                      password: _passwordTextController.text,
                                    );
                                    APIService.employeeLogin(empModel)
                                        .then((response) async {
                                      // await SharedPreference.setIsAdmin(false);
                                      if (response.payload.isAdmin == true) {
                                        await SharedPreference.setIsAdmin(
                                            response.payload.isAdmin);
                                        await SharedPreference.setToken(
                                            response.payload.authtoken);
                                        await SharedPreference.setUserRole(1);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddEmployee()),
                                        );
                                      } else {
                                        if (response.statusCode == '0') {
                                          await SharedPreference.setIsAdmin(
                                              false);
                                          await SharedPreference.setToken(
                                              response.payload.authtoken);
                                          await SharedPreference.setUserFName(
                                              response
                                                  .payload.employeeFirstName);
                                          await SharedPreference
                                              .setUserNationalId(int.parse(
                                                  response.payload
                                                      .employeeNationalId));
                                          await SharedPreference.setUserId(
                                              response.payload.employeeId !=
                                                      null
                                                  ? int.parse(response
                                                      .payload.employeeId)
                                                  : 0);
                                          await SharedPreference.setUserRole(0);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MainScreen()),
                                          );
                                        } else if (response.statusCode == '1') {
                                          print("Employee not found");
                                        } else {
                                          print("Employee not found");
                                        }
                                      }
                                    });
                                  } else {
                                    //Patient
                                    PatientLoginRequestModel model =
                                        PatientLoginRequestModel(
                                      nationalCardId: _unameTextController.text,
                                      password: _passwordTextController.text,
                                    );
                                    APIService.patientLogin(model)
                                        .then((response) async {
                                      await SharedPreference.setIsAdmin(false);
                                      if (response.statusCode == '0') {
                                        print("Patient Login Success");
                                        await SharedPreference.setToken(
                                            response.payload.authtoken);
                                        await SharedPreference.setUserFName(
                                            response.payload.patientFirstName);
                                        await SharedPreference
                                            .setUserNationalId(int.parse(
                                                response.payload
                                                    .patientNationalId));
                                        await SharedPreference.setUserId(
                                            response.payload.patientId != null
                                                ? int.parse(
                                                    response.payload.patientId)
                                                : 0);
                                        await SharedPreference.setUserRole(1);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainScreen()),
                                        );
                                      } else if (response.statusCode == '1') {
                                        print("User not found");
                                      } else {
                                        print("Patient Login Failed");
                                      }
                                    });
                                  }
                                }

                                setState(() {
                                  _unameTextController.text.isEmpty ||
                                          _passwordTextController.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;
                                });
                              },
                              child: Text(
                                'เข้าสู่ระบบ',
                                style: TextStyle(
                                    color: quaternaryColor,
                                    fontFamily: 'NotoSansThai'),
                              ),
                            ),
                          ),
                          Container(
                            child: Text.rich(TextSpan(
                                style: TextStyle(
                                  fontSize: 27,
                                ),
                                children: [
                                  TextSpan(
                                      style: TextStyle(
                                          color: quaternaryColor,
                                          decoration: TextDecoration.underline,
                                          fontSize: 13,
                                          fontFamily: 'NotoSansThai'),
                                      text: "สร้างบัญชี",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Register()),
                                          );
                                        }),
                                ])),
                            padding: EdgeInsets.fromLTRB(
                                size.width * 0.001,
                                size.width * 0.02,
                                size.width * 0,
                                size.width * 0),
                          )
                        ]),
                        padding: EdgeInsets.all(size.width * 0.001),
                        margin: EdgeInsets.all(size.width * 0.05)),
                  ],
                )
              ]),
            )
          ],
        )));
  }
}
