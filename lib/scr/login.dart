import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/scr/statistics.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/agent_login_JSON.dart';
import 'package:sahlaprovider/utilitie/push_notifcation.dart';

class LoginScr extends StatefulWidget {
  @override
  _LoginScrState createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  PushNotificationManagger _pushNotificationManagger =
      PushNotificationManagger();

  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  bool login = false;
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.asset('assets/images/log.png'),
    ),
  );

  final loginButton = Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {},
      padding: EdgeInsets.all(12),
      color: hexToColor('#00abeb'),
      child: Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
    ),
  );

  final forgotLabel = FlatButton(
    child: Text(
      'Forgot password?',
      style: TextStyle(color: Colors.black54),
    ),
    onPressed: () {},
  );

  //phone: '022428241', password: '123456'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            TextFormField(
                keyboardType: TextInputType.phone,
                controller: phone,
                decoration: InputDecoration(  fillColor: Colors.white,
                  filled: true,
                  labelText: ' رقم الهاتف',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color:Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: 'رقم الهاتف',
                  hintStyle: TextStyle(
                    fontFamily: 'Arbf',
                    color: Colors.white,
                  ),
                )),
            SizedBox(height: 8.0),
            TextFormField(
              obscureText: true,
              controller: password,
              decoration: InputDecoration( fillColor: Colors.white,
                filled: true,
                labelText: ' كلمه السر',
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                hintText: ' كلمه السر',
                hintStyle: TextStyle(
                  fontFamily: 'Arbf',
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 24.0),
            login
                ? Container(
                    height: 100, width: 100, child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: () async {
                        if (phone.text != null && password.text != null) {
                          login = true;
                          setState(() {});
                          await _pushNotificationManagger
                              .init()
                              .then((valueee) async {
                            print(valueee);
                            await _allNetworking.Login(
                                    phone: phone.text,
                                    password: password.text,
                                    firebase_token: valueee,
                                    lang: 'ar')
                                .then((value) async {
                              Agent_login_JSON data = Agent_login_JSON.fromJson(
                                  json.decode(value.body));
                              if (data.status) {
                                await box.write(
                                    'phone', data.result.agentData.phone);
                                await box.write('firebase_token', valueee);
                                await box.write(
                                    'name', data.result.agentData.name);

                                await box.write(
                                    'token', data.result.agentData.token);
                                await box.write(
                                    'email', data.result.agentData.email);
                                await box.write('id', data.result.agentData.id);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => Statisticss()),
                                    (Route<dynamic> route) => false);
                              } else {
                                Get.snackbar('', data.message);
                              }

                              login = false;
                              setState(() {});
                            });
                          });
                        }
                      },
                      padding: EdgeInsets.all(12),
                      color: Colors.red[900],
                      child: Text('تسجيل الدخول',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
            //  forgotLabel
          ],
        ),
      ),
    );
  }
}
