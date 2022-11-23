import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medware/components/action_button.dart';
import 'package:medware/screens/main/profile/edit_profile/input_field.dart';
import 'package:medware/utils/api/user/edit_profile_info.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';
import 'package:medware/utils/statics.dart';

class ChangePassword extends StatefulWidget {
  final String oldPassword;
  const ChangePassword({Key? key, required this.oldPassword}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final int id = SharedPreference.getUserId();
  final _newPwdController = TextEditingController();
  final _reNewPwdController = TextEditingController();
  String _errMsg = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future<void> onSubmit() async {
      if (_newPwdController.text != '' && _reNewPwdController.text != '') {
        if (_newPwdController.text.length < 8) {
          setState(() => _errMsg = 'รหัสผ่านต้องมีความยาวอย่างน้อย 8 ตัวอักษร');
        } else if (_newPwdController.text != _reNewPwdController.text) {
          setState(() => _errMsg = 'โปรดกรอกรหัสผ่านใหม่ให้ตรงกัน');
        } else if (_newPwdController.text.length >= 8 &&
            _reNewPwdController.text.length >= 8 &&
            _newPwdController.text == _reNewPwdController.text) {
          setState(() => _errMsg = '');
          var res = await editProfileInfo(
            id: id,
            newPassword: _newPwdController.text,
          );
          res.statusCode == 200
              ? Navigator.pop(context)
              : print(res.statusCode);
        }
      } else {
        setState(() => _errMsg = 'โปรดกรอกข้อมูลให้ครบถ้วน');
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('เปลี่ยนรหัสผ่าน'),
        centerTitle: true,
        toolbarHeight: size.height * 0.1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'NotoSansThai',
          fontWeight: FontWeight.w700,
          fontSize: size.width * 0.06,
          color: primaryColor,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                InputField(
                  label: 'รหัสผ่านใหม่',
                  placeholder: 'กรอกรหัสผ่าน',
                  error: '',
                  isNextable: true,
                  isPassword: true,
                  controller: _newPwdController,
                ),
                InputField(
                  label: 'กรอกรหัสผ่านใหม่อีกครั้ง',
                  placeholder: 'กรอกรหัสผ่าน',
                  error: _errMsg,
                  isNextable: false,
                  isPassword: true,
                  controller: _reNewPwdController,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.width * 0.1),
              child: ActionButton(
                text: 'ยืนยัน',
                action: onSubmit,
                percentWidth: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
