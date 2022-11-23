import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medware/utils/api/auth/api_service.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';
import 'package:medware/utils/statics.dart';

import '../../../../components/text_field.dart';
import '../../../../utils/models/auth/employee/employee_register_request_model.dart';
import '../../../auth/login.dart';

class AddEmployee extends StatelessWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AddDoctorForm();
  }
}

class AddDoctorForm extends StatefulWidget {
  const AddDoctorForm({super.key});

  @override
  State<AddDoctorForm> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctorForm> {
  final _addDocUname = TextEditingController();
  final _addDocName = TextEditingController();
  final _addDocPhoneNum = TextEditingController();
  final _addDocPassword = TextEditingController();
  final _addDocCpassword = TextEditingController();

  bool _validate = false;
  String? selectedDepartment = 'ดูแลก่อนคลอด';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _addDocUname.dispose();
    _addDocName.dispose();
    _addDocPhoneNum.dispose();
    _addDocPassword.dispose();
    _addDocCpassword.dispose();
    super.dispose();
  }

  craeteRegisterSuccessDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "เพิ่มบัญชีแพทย์สำเร็จ",
              style: TextStyle(fontFamily: 'NotoSansThai'),
            ),
            actions: <Widget>[
              MaterialButton(
                  child: Text("เข้าสู่ระบบ"),
                  onPressed: () {
                    Navigator.push(
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
              "โปรดตรวจสอบข้อมูลอีกครั้ง",
              style: TextStyle(fontFamily: 'NotoSansThai'),
            ),
          );
        });
  }

  String? get _errorUname {
    final text = _addDocUname.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    if (text.length < 13) {
      return 'ข้อมูลไม่ถูกต้อง';
    }
    return null;
  }

  String? get _errorName {
    final text = _addDocName.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  String? get _errorPhoneNum {
    final text = _addDocPhoneNum.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  String? get _errorPassword {
    final text = _addDocPassword.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  String? get _errorCPassword {
    final text = _addDocCpassword.value.text;
    final text2 = _addDocPassword.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    if (text != text2) {
      return 'รหัสผ่านไม่ต้องกัน';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                    const Radius.circular(15.0),
                  )),
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              margin: EdgeInsets.fromLTRB(60.0, 70.0, 60.0, 10.0),
              child: Column(
                children: <Widget>[
                  Column(children: <Widget>[
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('สร้างบัญชีแพทย์',
                            style: TextStyle(
                                fontSize: 20,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter')),
                      ),
                      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    ),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('หมายเลขบัตรประชาชน',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: secondaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _addDocUname,
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
                              child: Text('ชื่อ - นามสกุล',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: secondaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _addDocName,
                              validator: _errorName,
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
                              child: Text('เบอร์โทรศัพท์',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: secondaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _addDocPhoneNum,
                              validator: _errorPhoneNum,
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
                              child: Text('รหัสผ่าน',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: secondaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _addDocPassword,
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
                                      color: secondaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _addDocCpassword,
                              validator: _errorCPassword,
                              obscureText: true,
                            ),
                          ),
                          // Container(
                          //   child: Align(
                          //     alignment: Alignment.topLeft,
                          //     child: Text('แผนก',
                          //         style: TextStyle(
                          //             fontSize: 12,
                          //             color: secondaryColor,
                          //             fontFamily: 'NotoSansThai')),
                          //   ),
                          //   padding: EdgeInsets.fromLTRB(
                          //       size.width * 0.01, size.width * 0.01, 0, 0),
                          // ),
                          // Container(
                          //   child: DropdownButton<String>(
                          //     value: selectedDepartment,
                          //     items: departments
                          //         .map((item) => DropdownMenuItem<String>(
                          //               value: item,
                          //               child: Text(
                          //                 item,
                          //                 style: TextStyle(
                          //                     fontFamily: 'NotoSansThai',
                          //                     fontSize: 12,
                          //                     color: secondaryColor),
                          //               ),
                          //             ))
                          //         .toList(),
                          //     onChanged: (item) =>
                          //         setState(() => selectedDepartment = item),
                          //   ),
                          //   padding: EdgeInsets.fromLTRB(
                          //       size.width * 0.01, 0, size.width * 0.2, 0),
                          // ),
                        ]),
                        margin: EdgeInsets.all(size.width * 0.01)),
                  ]),
                  Container(
                    child: Row(children: <Widget>[
                      Container(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.all(size.width * 0.01),
                              textStyle: const TextStyle(fontSize: 12),
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          },
                          child: const Text(
                            'ออกจากระบบ',
                            style: TextStyle(
                                color: const Color(0xFFEEF2E6),
                                fontFamily: 'Inter'),
                          ),
                        ),
                      ),
                      Container(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(
                                    size.width * 0.05,
                                    size.width * 0.01,
                                    size.width * 0.05,
                                    size.width * 0.01),
                                textStyle: const TextStyle(fontSize: 12),
                                backgroundColor: tertiaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              EmployeeRegisterRequestModel model =
                                  EmployeeRegisterRequestModel(
                                employeeFirstName: _addDocName.text,
                                employeeMiddleName: '',
                                employeeLastName: '',
                                employeeDepartment: 0,
                                employeeIsAdmin: false,
                                employeeNationalId: _addDocUname.text,
                                employeePassword: _addDocPassword.text,
                                employeePhoneNumber: _addDocPhoneNum.text,
                                employeeRole: 1,
                              );
                              if (_addDocName.text == '' ||
                                  _addDocUname == '' ||
                                  _addDocPassword == '' ||
                                  _addDocPhoneNum == '' ||
                                  _addDocPassword == '' ||
                                  _addDocCpassword == '') {
                                craeteRegisterAlreadyExistDialog(context);
                                print("Input still null");
                              } else {
                                APIService.employeeRegister(model)
                                    .then((response) {
                                  if (response.statusCode == '0') {
                                    print("Register Success");
                                    craeteRegisterSuccessDialog(context);
                                  } else if (response.statusCode == '1') {
                                    print("NationalID already exist");
                                    craeteRegisterAlreadyExistDialog(context);
                                  } else {
                                    print("Register Faild " +
                                        response.statusCode);
                                    craeteRegisterFailedDialog(context);
                                  }
                                });
                              }
                              setState(() {
                                _addDocUname.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                              });
                            },
                            child: const Text(
                              'ยืนยัน',
                              style: TextStyle(
                                  color: const Color(0xFF1C6758),
                                  fontFamily: 'Inter'),
                            ),
                          ),
                          padding: EdgeInsets.all(size.width * 0.01),
                          margin: EdgeInsets.all(size.width * 0.03)),
                    ]),
                    padding: EdgeInsets.fromLTRB(
                        size.width * 0.12, size.width * 0.01, 0.0, 0.0),
                  ),
                ],
              ))
        ])));
  }
}
