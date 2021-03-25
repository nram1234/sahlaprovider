import 'dart:io';

import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/scr/branch.dart';
import 'package:sahlaprovider/scr/contactwithmanager.dart';
import 'package:sahlaprovider/scr/doc_profile.dart';
import 'package:sahlaprovider/scr/login.dart';
import 'package:sahlaprovider/scr/myprofile.dart';
import 'package:sahlaprovider/scr/notificationScr.dart';
import 'package:sahlaprovider/scr/pointScr.dart';
import 'package:sahlaprovider/scr/qrClient.dart';
import 'package:sahlaprovider/scr/remembering.dart';
import 'package:sahlaprovider/scr/ticketdetails.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

import '../main.dart';
//
// Widget mydrawer(context) {
//   AllNetworking _allNetworking = AllNetworking();
//   String phone;
//   String point;
//
//   final box = GetStorage();
//   String service_type = box.read('service_type');
//   print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
//   print(service_type);
//   print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
//   return Drawer(
//     child: Container(
//       padding: EdgeInsets.only(right: 50, left: 50),
//       color: Colors.red,
//       child: ListView(
//         children: [
//           SizedBox(
//             height: 100,
//           ),
//           ListTile(
//             title: Text(box.read('name'),
//                 style: TextStyle(
//                     fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
//             onTap: () {},
//           ),
//           Container(
//             color: Colors.white,
//             height: 2,
//           ),
//           service_type == '1'
//               ? ListTile(
//                   title: Text('حذف النقاط',
//                       style: TextStyle(
//                           fontFamily: 'Arbf',
//                           color: Colors.white,
//                           fontSize: 25)),
//                   onTap: () {
//                     Get.dialog(
//                       AlertDialog(
//                         title: Text(''),
//                         content: Column(
//                           children: [
//                             TextFormField(
//                               onChanged: (s) {
//                                 phone = s;
//                               },
//                               textAlign: TextAlign.center,
//                               keyboardType: TextInputType.phone,
//                               style: TextStyle(
//                                 fontFamily: 'Arbf',
//                                 color: hexToColor('#ed1c6f'),
//                               ),
//                               decoration: InputDecoration(
//                                 labelText: 'رقم الهاتف',
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.red, width: 2),
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.red, width: 2),
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 hintStyle: TextStyle(
//                                   fontFamily: 'Arbf',
//                                   color: hexToColor('#ed1c6f'),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             TextFormField(
//                               onChanged: (s) {
//                                 point = s;
//                               },
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontFamily: 'Arbf',
//                                 color: hexToColor('#ed1c6f'),
//                               ),
//                               decoration: InputDecoration(
//                                 labelText: 'عدد النقاط',
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.red, width: 2),
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.red, width: 2),
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 hintStyle: TextStyle(
//                                   fontFamily: 'Arbf',
//                                   color: hexToColor('#ed1c6f'),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         actions: <Widget>[
//                           FlatButton(
//                             child: Text("CLOSE"),
//                             onPressed: () {
//                               print(phone);
//
//                               Get.back();
//                             },
//                           ),
//                           FlatButton(
//                             child: Text("تنفيذ"),
//                             onPressed: () {
//                               print(phone);
//
//                               _allNetworking
//                                   .empty_points(
//                                       total_points: point,
//                                       phone: phone,
//                                       token_id: box.read('token'))
//                                   .then((value) {
//                                 Get.dialog(
//                                   AlertDialog(
//                                     title: Text(''),
//                                     content: Text(value.data['message']),
//                                     actions: <Widget>[
//                                       FlatButton(
//                                         child: Text("CLOSE"),
//                                         onPressed: () {
//                                           Get.back();
//                                         },
//                                       )
//                                     ],
//                                   ),
//                                   barrierDismissible: false,
//                                 );
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                       barrierDismissible: false,
//                     );
//
//                     //_allNetworking.empty_points(total_points: null, phone: null)
//                   },
//                 )
//               : SizedBox(),
//           Container(
//             color: Colors.white,
//             height: 2,
//           ),
//           ListTile(
//             title: Text("ﺑﺮﻭﻓﺎﻳﻞ",
//                 style: TextStyle(
//                     fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
//             onTap: () {
//               // Get.to(Profilee(),transition: Transition.cupertino);
//
//               if (service_type == '3') {
//
//
//
//
//
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Doc_Profile(context)),
//                 );
//               } else {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Profilee(context)),
//                 );
//               }
//             },
//           ),
//           Container(
//             color: Colors.white,
//             height: 2,
//           ),
//           ListTile(
//             title: Text("ﺍﻟﻔﺮﻭﻉ",
//                 style: TextStyle(
//                     fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Branch()),
//               );
//               // Get.to(Branch(),transition: Transition.cupertino);
//             },
//           ),
//           Container(
//             color: Colors.white,
//             height: 2,
//           ),
//           ListTile(
//             title: Text("ﺗﻨﺒﻴﻬﺎﺕ",
//                 style: TextStyle(
//                     fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NotificationScr()),
//               );
//               //     Get.to(NotificationScr(),transition: Transition.cupertino);
//             },
//           ),
//           Container(
//             color: Colors.white,
//             height: 2,
//           ),
//           service_type == '1'
//               ? ListTile(
//                   title: Text("ﻛﻮﺑﻮﻧﺎﺕ ﺧﺼﻢ",
//                       style: TextStyle(
//                           fontFamily: 'Arbf',
//                           color: Colors.white,
//                           fontSize: 25)),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => QRClient()),
//                     );
//                   },
//                 )
//               : SizedBox(),
//           service_type == '1'
//               ? Container(
//                   color: Colors.white,
//                   height: 2,
//                 )
//               : SizedBox(),
//           ListTile(
//             title: Text("ﺗﻮﺍﺻﻞ ﻣﻊ ﺍﻻﺩﺍﺭﺓ",
//                 style: TextStyle(
//                     fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Remembering()),
//               );
//
//               //Get.to(Remembering(),);
//             },
//           ),
//           service_type == '1'
//               ? Container(
//                   color: Colors.white,
//                   height: 2,
//                 )
//               : SizedBox(),
//           service_type == '1'
//               ? ListTile(
//                   title: Text("النقاط",
//                       style: TextStyle(
//                           fontFamily: 'Arbf',
//                           color: Colors.white,
//                           fontSize: 25)),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => PointScr()),
//                     );
//
//                     //Get.to(Remembering(),);
//                   },
//                 )
//               : SizedBox(),
//           Container(
//             color: Colors.white,
//             height: 2,
//           ),
//           ListTile(
//               title: Text("ﺗﺴﺠﻴﻞ ﺍﻟﺨﺮﻭﺝ",
//                   style: TextStyle(
//                       fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
//               onTap: () {
//                 _allNetworking
//                     .logout(
//                         token_id: box.read('token'),
//                         firebase_token: box.read('firebase_token'))
//                     .then(
//                   (value) async {
//                     await box.remove(
//                       'phone',
//                     );
//                     await box.remove('firebase_token');
//                     await box.remove('name');
//
//                     await box.remove('token');
//                     await box.remove('email');
//                     await box.remove('id');
//                     Get.offAll(LoginScr());
//                     //   Navigator.pushAndRemoveUntil(
//                     //       context,
//                     //       new MaterialPageRoute(
//                     //           builder: (context) =>
//                     //               LoginScr()),
//                     //           (Route<dynamic> route) => false  );
//                     // });
//                   },
//                 );
//               })
//         ],
//       ),
//     ),
//     elevation: 8,
//   );
// }
class Mydrawer extends StatefulWidget {
  @override
  _MydrawerState createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  AllNetworking _allNetworking = AllNetworking();
  String phone;
  String point;

  final box = GetStorage();
  String service_type;



  @override

  void initState() {
    super.initState();
     service_type = box.read('service_type');
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(right: 50, left: 50),
        color: Colors.red,
        child: ListView(
          children: [
            SizedBox(
              height: 100,
            ),
            ListTile(
              title: Text(box.read('name'),
                  style: TextStyle(
                      fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
              onTap: () {},
            ),
            Container(
              color: Colors.white,
              height: 2,
            ),
            service_type == '1'
                ? ListTile(
              title: Text('حذف النقاط',
                  style: TextStyle(
                      fontFamily: 'Arbf',
                      color: Colors.white,
                      fontSize: 25)),
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    title: Text(''),
                    content: Column(
                      children: [
                        TextFormField(
                          onChanged: (s) {
                            phone = s;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'رقم الهاتف',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (s) {
                            point = s;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'عدد النقاط',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        )
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("CLOSE"),
                        onPressed: () {
                          print(phone);

                          Get.back();
                        },
                      ),
                      FlatButton(
                        child: Text("تنفيذ"),
                        onPressed: () {
                          print(phone);

                          _allNetworking
                              .empty_points(
                              total_points: point,
                              phone: phone,
                              token_id: box.read('token'))
                              .then((value) {
                            Get.dialog(
                              AlertDialog(
                                title: Text(''),
                                content: Text(value.data['message']),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("CLOSE"),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  )
                                ],
                              ),
                              barrierDismissible: false,
                            );
                          });
                        },
                      )
                    ],
                  ),
                  barrierDismissible: false,
                );

                //_allNetworking.empty_points(total_points: null, phone: null)
              },
            )
                : SizedBox(),
            Container(
              color: Colors.white,
              height: 2,
            ),
            ListTile(
              title: Text("ﺑﺮﻭﻓﺎﻳﻞ",
                  style: TextStyle(
                      fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
              onTap: () async{
                // Get.to(Profilee(),transition: Transition.cupertino);

                if (service_type == '3') {

                  final value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Doc_Profile(context)),

                  );
                  setState(() {

                  });




                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Doc_Profile(context)),
                  // );
                } else {
                  final value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profilee(context)),

                  );
                  setState(() {

                  });





                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Profilee(context)),
                  // );
                }
              },
            ),
            Container(
              color: Colors.white,
              height: 2,
            ),
            ListTile(
              title: Text("ﺍﻟﻔﺮﻭﻉ",
                  style: TextStyle(
                      fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Branch()),
                );
                // Get.to(Branch(),transition: Transition.cupertino);
              },
            ),
            Container(
              color: Colors.white,
              height: 2,
            ),
            ListTile(
              title: Text("ﺗﻨﺒﻴﻬﺎﺕ",
                  style: TextStyle(
                      fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScr()),
                );
                //     Get.to(NotificationScr(),transition: Transition.cupertino);
              },
            ),
            Container(
              color: Colors.white,
              height: 2,
            ),
            service_type == '1'
                ? ListTile(
              title: Text("ﻛﻮﺑﻮﻧﺎﺕ ﺧﺼﻢ",
                  style: TextStyle(
                      fontFamily: 'Arbf',
                      color: Colors.white,
                      fontSize: 25)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRClient()),
                );
              },
            )
                : SizedBox(),
            service_type == '1'
                ? Container(
              color: Colors.white,
              height: 2,
            )
                : SizedBox(),
            ListTile(
              title: Text("ﺗﻮﺍﺻﻞ ﻣﻊ ﺍﻻﺩﺍﺭﺓ",
                  style: TextStyle(
                      fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Remembering()),
                );

                //Get.to(Remembering(),);
              },
            ),
            service_type == '1'
                ? Container(
              color: Colors.white,
              height: 2,
            )
                : SizedBox(),
            service_type == '1'
                ? ListTile(
              title: Text("النقاط",
                  style: TextStyle(
                      fontFamily: 'Arbf',
                      color: Colors.white,
                      fontSize: 25)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PointScr()),
                );

                //Get.to(Remembering(),);
              },
            )
                : SizedBox(),
            Container(
              color: Colors.white,
              height: 2,
            ),
            ListTile(
                title: Text("ﺗﺴﺠﻴﻞ ﺍﻟﺨﺮﻭﺝ",
                    style: TextStyle(
                        fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
                onTap: () {
                  _allNetworking
                      .logout(
                      token_id: box.read('token'),
                      firebase_token: box.read('firebase_token'))
                      .then(
                        (value) async {
                      await box.remove(
                        'phone',
                      );
                      await box.remove('firebase_token');
                      await box.remove('name');

                      await box.remove('token');
                      await box.remove('email');
                      await box.remove('id');
                      Get.offAll(LoginScr());
                      //   Navigator.pushAndRemoveUntil(
                      //       context,
                      //       new MaterialPageRoute(
                      //           builder: (context) =>
                      //               LoginScr()),
                      //           (Route<dynamic> route) => false  );
                      // });
                    },
                  );
                })
          ],
        ),
      ),
      elevation: 8,
    );
  }
}
