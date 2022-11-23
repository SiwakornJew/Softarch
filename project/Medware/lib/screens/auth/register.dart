import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medware/components/text_field.dart';
import 'package:medware/screens/auth/login.dart';
import 'package:medware/utils/statics.dart';
import 'package:medware/utils/models/auth/patient/patient_register_request_model.dart';

import '../../utils/api/auth/api_service.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RegisterForm();
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterForm> {
  TextEditingController _unameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _cpasswordTextController = TextEditingController();
  TextEditingController _fnameTextController = TextEditingController();
  TextEditingController _lnameTextController = TextEditingController();

  bool _validate = false;
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _unameTextController.dispose();
    _passwordTextController.dispose();
    _cpasswordTextController.dispose();
    _fnameTextController.dispose();
    _lnameTextController.dispose();
    super.dispose();
  }

  String? selectedBloodtype = 'A (positive)';

  String? get _errorUname {
    final text = _unameTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    if (text.length < 13) {
      return 'หมายเลขบัตรประชาชนไม่ถูกต้อง';
    }
    return null;
  }

  String? get _errorfName {
    final text = _fnameTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  String? get _errorlName {
    final text = _fnameTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  String? get _errorPassword {
    final text = _passwordTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  String? get _errorCPassword {
    final text = _cpasswordTextController.value.text;
    final text2 = _passwordTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text != text2) {
      return 'รหัสผ่านไม่ตรงกัน';
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  craeteRegisterSuccessDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "สมัครสมาชิกสำเร็จ",
              style: TextStyle(fontFamily: 'NotoSansThai'),
            ),
            actions: <Widget>[
              MaterialButton(
                  child: Text("เข้าสู่ระบบ"),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  })
            ],
          );
        });
  }

  craeteRegisterFailedDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "ระบบขัดข้อง",
              style: TextStyle(fontFamily: 'NotoSansThai'),
            ),
          );
        });
  }

  craeteRegisterAlreadyExistDialog(BuildContext context) {
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
        key: _key,
        resizeToAvoidBottomInset: false,
        backgroundColor: secondaryColor,
        body: Column(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  color: primaryColor,
                  borderRadius: new BorderRadius.all(
                    const Radius.circular(15.0),
                  )),
              padding: EdgeInsets.fromLTRB(size.width * 0.07,
                  size.height * 0.05, size.width * 0.07, size.height * 0.04),
              margin: EdgeInsets.fromLTRB(
                  size.width * 0.1, size.height * 0.1, size.width * 0.1, 0.0),
              child: Column(children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Center(
                          child: Text(
                            'สร้างบัญชีผู้ใช้',
                            style: TextStyle(
                                fontSize: 20,
                                color: quaternaryColor,
                                fontFamily: 'NotoSansThai'),
                          ),
                        ),
                      ),
                      padding:
                          EdgeInsets.fromLTRB(0.0, 0.0, 0.0, size.width * 0.05),
                    ),
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
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _unameTextController,
                              validator: _errorUname,
                              obscureText: false,
                            ),
                          ),
                        ]),
                        margin: EdgeInsets.all(size.width * 0.01)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('ชื่อ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: quaternaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _fnameTextController,
                              validator: _errorfName,
                              obscureText: false,
                            ),
                          ),
                        ]),
                        margin: EdgeInsets.all(size.width * 0.01)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('นามสกุล',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: quaternaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _lnameTextController,
                              validator: _errorlName,
                              obscureText: false,
                            ),
                          ),
                        ]),
                        margin: EdgeInsets.all(size.width * 0.01)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('กรุ๊ปเลือด',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: quaternaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: DropdownButton<String>(
                              value: selectedBloodtype,
                              dropdownColor: primaryColor,
                              items: bloodTypes
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              fontFamily: 'NotoSansThai',
                                              fontSize: 12,
                                              color: quaternaryColor),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (item) =>
                                  setState(() => selectedBloodtype = item),
                            ),
                            padding: EdgeInsets.fromLTRB(
                                size.width * 0.01, 0, size.width * 0.37, 0),
                          ),
                        ]),
                        margin: EdgeInsets.all(size.width * 0.01)),
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
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _passwordTextController,
                              validator: _errorPassword,
                              obscureText: true,
                            ),
                          ),
                        ]),
                        margin: EdgeInsets.all(size.width * 0.01)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('ยืนยันรหัสผ่าน',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: quaternaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _cpasswordTextController,
                              validator: _errorCPassword,
                              obscureText: true,
                            ),
                          ),
                        ]),
                        margin: EdgeInsets.all(size.width * 0.01)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(7.0),
                                  textStyle: const TextStyle(fontSize: 20),
                                  backgroundColor: tertiaryColor),
                              onPressed: () {
                                if (_fnameTextController.text == '' ||
                                    _passwordTextController == '' ||
                                    _unameTextController == '' ||
                                    _lnameTextController == '') {
                                  craeteRegisterAlreadyExistDialog(context);
                                } else {
                                  PatientRegisterRequestModel model =
                                      PatientRegisterRequestModel(
                                    patientFirstName: _fnameTextController.text,
                                    patientMiddleName: '',
                                    patientLastName: _lnameTextController.text,
                                    patientNationalId:
                                        int.parse(_unameTextController.text),
                                    patientPhoneNumber: '0931244774',
                                    patientBirthDate: '2016-11-09', //Fake data
                                    patientLocation: '',
                                    patientBloodType:
                                        selectedBloodtype.toString(),
                                    patientProfileIndex: 1,
                                    patientPassword:
                                        _passwordTextController.text,
                                  );
                                  APIService.patientRegister(model)
                                      .then((response) {
                                    if (response.statusCode == '0') {
                                      print("Register Success");
                                      craeteRegisterSuccessDialog(context);
                                    } else if (response.statusCode == '1') {
                                      print("NationalID already exist");
                                      craeteRegisterAlreadyExistDialog(context);
                                    } else {
                                      print(response.statusCode);
                                      craeteRegisterFailedDialog(context);
                                    }
                                  });
                                }

                                setState(() {
                                  _unameTextController.text.isEmpty ||
                                          _passwordTextController
                                              .text.isEmpty ||
                                          _cpasswordTextController
                                              .text.isEmpty ||
                                          _fnameTextController.text.isEmpty ||
                                          _lnameTextController.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;
                                });
                              },
                              child: Text(
                                'สร้างบัญชี',
                                style: TextStyle(
                                    fontSize: 12,
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
                                        fontSize: 13,
                                        fontFamily: 'NotoSansThai',
                                        decoration: TextDecoration.underline,
                                      ),
                                      text: "ย้อนกลับ",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pop(context);
                                        }),
                                ])),
                            padding: EdgeInsets.fromLTRB(
                                0, size.width * 0.03, 0.0, 0),
                          ),
                        ]),
                        margin: EdgeInsets.fromLTRB(
                            0.0, size.width * 0.04, 0.0, 0.0)),
                  ],
                )
              ]),
            )
          ],
        ));
  }
}
