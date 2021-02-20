import "dart:io";
import "dart:convert";
import 'dart:typed_data';

import 'package:sahlaprovider/myWidget/customDialog.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';

import 'package:sahlaprovider/scr/offer.dart';
import 'package:sahlaprovider/scr/pharmacy.dart';
import 'package:sahlaprovider/scr/product.dart';
import 'package:sahlaprovider/scr/visitorCount.dart';

import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_home_json.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

import 'QRread.dart';
import 'add_photography_requests.dart';
import 'get_all_orderSCr.dart';
import 'get_all_visitor_pointsSCR.dart';
import 'get_waiting_orders.dart';
import 'myorder.dart';

class Statisticss extends StatefulWidget {
  @override
  _StatisticssState createState() => _StatisticssState();
}

class _StatisticssState extends State<Statisticss> {
  Uint8List bytes = Uint8List(0);
  String _qrStringgnra = '';

  int _selectedIndex = 0;
  String token;
  String service_type = '0';
  bool serch = false;
  bool qrgnratt = false;
  bool activediscount = false;
  final box = GetStorage();
  AllNetworking _allNetworking = AllNetworking();
  File _imge;

  @override
  void initState() {
    token = box.read('token');
    service_type = box.read('service_type');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final high = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var color = Colors.red;
    List bottomitem = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        backgroundColor: Colors.red,
        icon: Icon(Icons.home),
        label: 'الرئيسية',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_cart_outlined,
        ),
        label: 'ﻣﻨﺘﺠﺎﺕ ﺍﻟﻔﺮﻉ',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'ﺍﻟﻌﺮﻭﺽ',
      ),
    ];
    return Scaffold(
      key: _scaffoldKey,
      drawer: mydrawer(context),
      body: swithscren(pos: _selectedIndex, width: width, high: high),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: hexToColor('#00abeb'),
        items: bottomitem,
        currentIndex: _selectedIndex,
        selectedItemColor: color, // Colors.amber[800],
        onTap: (i) {
          _selectedIndex = i;

          swithscren(pos: i, width: width, high: high);
          setState(() {});
        },
      ),
    );

    //swithscren(high: high, width: width, pos: _selectedIndex);
  }

  Widget swithscren({pos, high, width}) {
    if (pos == 0) {
      return StreamBuilder<Get_home_json>(
          stream:
              _allNetworking.get_home(token_id: token, lang: 'ar').asStream(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              Result data = snapshot.data.result;
              if (data.type == 0) {
                activediscount = false;
              } else {
                activediscount = true;
              }

              return Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black12,
                    actions: [],
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        Expanded(
                            child: TextField(
                          controller: _textEditingController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'بحث بالكود او رقم الهاتف '),
                        )),
                        GestureDetector(
                          onTap: () async {
                            // set up the buttons
                            Widget cancelButton = FlatButton(
                              child: Text("الفاء"),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                            );
                            Widget continueButton = FlatButton(
                              child: Text("تنفيذ"),
                              onPressed: () {



                             //   _textEditingController



                              },
                            );

                            if (!_textEditingController.text.trim().isEmpty) {
                              setState(() {
                                serch = true;
                              });
                              _allNetworking
                                  .check_coupon(
                                      token_id: token,
                                      coupon: _textEditingController.text)
                                  .then((value) {
                                // set up the AlertDialog
                               
                                print(value.data['status']);

                                if (value.data['status']) {
                                  String user_name =
                                      value.data['data']['user_name'];
                                  String user_phone =
                                      value.data['data']['user_phone'];
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) =>
                                        CustomDialog(
                                      Text2:
                                          "عدد النقاط ${value.data['data']['user_total_points']}",
                                      title: "كود الخصم",
                                      function: () {},
                                      buttonText2: "تنفيذ",
                                      description: "رقم الهاتف  $user_phone" +
                                          "\n" +
                                          "اسم المستخدم $user_name",
                                      buttonText: "الفاء",
                                      phone: false,
                                    ),
                                  );
                                } else {
                                  // set up the button
                                  Widget okButton = FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  );

                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("كود الخصم"),
                                    content: Text(value.data['message']),
                                    actions: [
                                      okButton,
                                    ],
                                  );

                                  // show the dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                }

                                setState(() {
                                  _textEditingController.text = "";
                                  serch = false;
                                });
                              });
                            }
                          },
                          child: serch
                              ? CircularProgressIndicator()
                              : Icon(
                                  Icons.apps_outlined,
                                  color: hexToColor('#00abeb'),
                                ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!_textEditingController.text.trim().isEmpty) {
                              setState(() {
                                serch = true;
                              });
                              _allNetworking
                                  .check_phone(
                                      token_id: token,
                                      coupon: _textEditingController.text)
                                  .then((value) {
                                // set up the AlertDialog
                                print('tttttttttttttttttttttttttttttttttt');
                                print(value.data['status']);

                                if (value.data['status']) {
                                  String user_name =
                                      value.data['data']['user_name'];
                                  String user_phone =
                                      value.data['data']['user_phone'];
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) =>
                                        CustomDialog(
                                      Text2:
                                          "عدد النقاط ${value.data['data']['user_total_points']}",
                                      title: "",
                                      function: () {},
                                      buttonText2: "تنفيذ",
                                      description: "رقم الهاتف  $user_phone" +
                                          "\n" +
                                          "اسم المستخدم $user_name",
                                      buttonText: "الفاء",
                                      phone: true,
                                    ),
                                  );
                                } else {
                                  // set up the button
                                  Widget okButton = FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  );

                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("كود الخصم"),
                                    content: Text(value.data['message']),
                                    actions: [
                                      okButton,
                                    ],
                                  );

                                  // show the dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                }

                                setState(() {
                                  _textEditingController.text = "";
                                  serch = false;
                                });
                              });
                            }
                          },
                          child: serch
                              ? CircularProgressIndicator()
                              : Icon(
                                  Icons.phone,
                                  color: hexToColor('#00abeb'),
                                ),
                        ),

                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: high * 0.04,
                          width: high * 0.05,
                          child: Image.asset(
                            'assets/images/log.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  drawer: mydrawer(context),
                  body: SafeArea(
                    top: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // serchWidget(width: width, high: high, fun: fun),
                            // SizedBox(
                            //   height: high * .02,
                            // ),
                            //
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               Add_Photography_Requests()),
                            //     );
                            //   },
                            //   child: Container(
                            //       height: high * .1,
                            //       width: width * 0.5,
                            //       child: Center(
                            //         child: Text('طلب تصميم وتصوير',
                            //             style: TextStyle(
                            //                 fontFamily: 'Arbf',
                            //                 color: Colors.white,
                            //                 fontSize: 25)),
                            //       ),
                            //       decoration: BoxDecoration(
                            //           color: hexToColor('#00abeb'),
                            //           gradient: new LinearGradient(
                            //               colors: [
                            //                 Colors.red[100],
                            //                 Colors.red[900],
                            //               ],
                            //               begin: Alignment.centerLeft,
                            //               end: Alignment.centerRight,
                            //               tileMode: TileMode.clamp),
                            //           borderRadius: BorderRadius.circular(10))),
                            // ),
                            SizedBox(
                              height: high * .02,
                            ),
                      Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                          GestureDetector(
                          onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) =>
                      Get_all_order(token)),
                      );
                      },
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: hexToColor('#00abeb'),
                                              gradient: new LinearGradient(
                                                  colors: [
                                                    Colors.orange[100],
                                                    Colors.orange[900],
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  tileMode: TileMode.clamp),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          width: width * .3,
                                          height: width * .3,
                                          child: Center(
                                            child: Text(
                                              data.totalSelling.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'Arbf',
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: .01,
                                        ),
                                        Text(
                                          "عدد الكوبونات",
                                          style: TextStyle(
                                              fontFamily: 'Arbf',
                                              color: Colors.black,
                                              fontSize: 25),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VisitorCount(token)),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: hexToColor('#00abeb'),
                                              gradient: new LinearGradient(
                                                  colors: [
                                                    Colors.purpleAccent[100],
                                                    Colors.purpleAccent[700],
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  tileMode: TileMode.clamp),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          width: width * .3,
                                          height: width * .3,
                                          child: Center(
                                            child: Text(
                                              data.totalViews.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'Arbf',
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: .01,
                                        ),
                                        Text(
                                          "عدد الزوار",
                                          style: TextStyle(
                                              fontFamily: 'Arbf',
                                              color: Colors.black,
                                              fontSize: 25),
                                        )
                                      ],
                                    ),
                                  )
                                ],

                            ),
                            SizedBox(
                              height: high * .02,
                            ),
                            Container(
                              height: 1,
                              width: width * .7,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: high * .02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: width * .3,
                                      height: width * .3,
                                      decoration: BoxDecoration(
                                          color: hexToColor('#00abeb'),
                                          gradient: new LinearGradient(
                                              colors: [
                                                Colors.brown[100],
                                                Colors.brown[700],
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              tileMode: TileMode.clamp),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data.datePackege,
                                              style: TextStyle(
                                                  fontFamily: 'Arbf',
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                            // Text(
                                            //   '20-20',
                                            //   style: TextStyle(
                                            //       fontFamily: 'Arbf',
                                            //       color: Colors.white,
                                            //       fontSize: 25),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: .01,
                                    ),
                                    Text(
                                      "ﺗﺎﺭﻳﺦ ﺍﻻﺷﺘﺮﺍﻙ ",
                                      style: TextStyle(
                                          fontFamily: 'Arbf',
                                          color: Colors.black,
                                          fontSize: 25),
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 1;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: width * .3,
                                        height: width * .3,
                                        decoration: BoxDecoration(
                                            color: hexToColor('#00abeb'),
                                            gradient: new LinearGradient(
                                                colors: [
                                                  Colors.pinkAccent[100],
                                                  Colors.pinkAccent[700],
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                tileMode: TileMode.clamp),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Center(
                                          child: Text(
                                            data.totalProduct.toString(),
                                            style: TextStyle(
                                                fontFamily: 'Arbf',
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: .01,
                                      ),
                                      Text(
                                        " ﻋﺪﺩ ﺍﻟﻤﻨﺘﺠﺎﺕ",
                                        style: TextStyle(
                                            fontFamily: 'Arbf',
                                            color: Colors.black,
                                            fontSize: 25),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),

                            SizedBox(
                              height: high * .02,
                            ),
                            Container(
                              height: 1,
                              width: width * .7,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: high * .02,
                            ),
Row( mainAxisAlignment: MainAxisAlignment.spaceAround,children: [

  service_type == '1'
      ? GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Pharmacy()),
      );
    },
    child: Column(
      children: [
        Container(
          width: width * .3,
          height: width * .3,
          decoration: BoxDecoration(
              color: hexToColor('#00abeb'),
              gradient: new LinearGradient(
                  colors: [
                    Colors.tealAccent[100],
                    Colors.tealAccent[700],
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  tileMode: TileMode.clamp),
              borderRadius:
              BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              snapshot.data.result.totalOrders
                  .toString(),
              style: TextStyle(
                  fontFamily: 'Arbf',
                  color: Colors.white,
                  fontSize: 25),
            ),
          ),
        ),
        SizedBox(
          height: .01,
        ),
        Text(
          "سلة المشتروات",
          style: TextStyle(
              fontFamily: 'Arbf',
              color: Colors.black,
              fontSize: 25),
        )
      ],
    ),
  )
      : SizedBox(),



  service_type == '1'
      ? GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyOrder()),
      );
    },
    child: Column(
      children: [
        Container(
          width: width * .3,
          height: width * .3,
          decoration: BoxDecoration(
              color: hexToColor('#00abeb'),
              gradient: new LinearGradient(
                  colors: [
                    Colors.tealAccent[100],
                    Colors.tealAccent[700],
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  tileMode: TileMode.clamp),
              borderRadius:
              BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              snapshot.data.result.totalOrders
                  .toString(),
              style: TextStyle(
                  fontFamily: 'Arbf',
                  color: Colors.white,
                  fontSize: 25),
            ),
          ),
        ),
        SizedBox(
          height: .01,
        ),
        Text(
          "سلة المشتروات",
          style: TextStyle(
              fontFamily: 'Arbf',
              color: Colors.black,
              fontSize: 25),
        )
      ],
    ),
  )
      : SizedBox(),
  GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Get_all_visitor_points(token)),
      );
    },
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: hexToColor('#00abeb'),
              gradient: new LinearGradient(
                  colors: [
                    Colors.lime[100],
                    Colors.lime[700],
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  tileMode: TileMode.clamp),
              borderRadius:
              BorderRadius.circular(10.0)),
          width: width * .3,
          height: width * .3,
          child: Center(
            child: Text(
              data.totalPoints.toString(),
              style: TextStyle(
                  fontFamily: 'Arbf',
                  color: Colors.white,
                  fontSize: 25),
            ),
          ),
        ),
        SizedBox(
          height: .01,
        ),
        Text(
          "ﻋﺪﺩ نقاط ",
          style: TextStyle(
              fontFamily: 'Arbf',
              color: Colors.black,
              fontSize: 25),
        )
      ],
    ),
  ),],),



                            SizedBox(
                              height: high * .02,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                qrgnratt
                                    ? CircularProgressIndicator()
                                    : GestureDetector(
                                        onTap: () async {
                                          int idOfQR = await box.read('id');
                                          await _generateBarCode(
                                              box.read('id').toString());

                                          //  Get.to(QRRead(),
                                          //     transition: Transition.leftToRightWithFade);
                                        },
                                        child: Container(
                                          height: high * .07,
                                          width: width * 0.4,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(" انشاء  QR ",
                                                    style: TextStyle(
                                                      fontFamily: 'Arbf',
                                                      color: Colors.white,
                                                    )),
                                                Icon(
                                                  Icons.qr_code,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: hexToColor('#00abeb'),
                                              gradient: new LinearGradient(
                                                  colors: [
                                                    Colors.red[100],
                                                    Colors.red[900],
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  tileMode: TileMode.clamp),
                                              borderRadius:
                                                  BorderRadius.circular(40.0)),
                                        ),
                                      ),
                                GestureDetector(
                                  onTap: () {
                                    if (activediscount) {
                                      _allNetworking
                                          .create_coupon(
                                              token_id: token, type: 0)
                                          .then((value) {});
                                      setState(() {});
                                    } else {
                                      _allNetworking
                                          .create_coupon(
                                              token_id: token, type: 1)
                                          .then((value) {});
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    height: high * .07,
                                    width: width * 0.4,
                                    child: Center(
                                      child: activediscount
                                          ? Text(
                                              " الغاء  ${data.serviceCoupon}",
                                              style: TextStyle(
                                                  fontFamily: 'Arbf',
                                                  color: Colors.white,
                                                  fontSize: 25))
                                          : Text(" تفعيل اكواد الخصم ",
                                              style: TextStyle(
                                                fontFamily: 'Arbf',
                                                color: Colors.white,
                                              )),
                                    ),
                                    decoration: BoxDecoration(
                                        color: hexToColor('#00abeb'),
                                        gradient: new LinearGradient(
                                            colors: [
                                              Colors.red[100],
                                              Colors.red[900],
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            tileMode: TileMode.clamp),
                                        borderRadius:
                                            BorderRadius.circular(40.0)),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    } else if (pos == 1) {
      return ProductScr();
    } else if (pos == 2) {
      return OfferScr();
    }
    return Container();
  }

  Future _generateBarCode(String inputCode) async {
    qrgnratt = true;
    setState(() {});

    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
    File.fromRawPath(result); //_imge=
    final success = await ImageGallerySaver.saveImage(this.bytes);

    String imageString = base64Encode(this.bytes);
    print(imageString);

    await _allNetworking
        .save_QR(token_id: token, file: imageString)
        .then((value) {
      print(value.data);

      Get.dialog(
        AlertDialog(
          title: Text(''),
          content: Text("تم حفظ الصوره في مكتبة الصور"),
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

    qrgnratt = false;
    setState(() {});
  }
}

