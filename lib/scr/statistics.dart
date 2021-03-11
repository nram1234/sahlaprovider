import "dart:io";
import "dart:convert";
import 'dart:typed_data';

import 'package:sahlaprovider/myWidget/customDialog.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';

import 'package:sahlaprovider/scr/offer.dart';
import 'package:sahlaprovider/scr/pharmacy.dart';
import 'package:sahlaprovider/scr/product.dart';
import 'package:sahlaprovider/scr/qrClient.dart';
import 'package:sahlaprovider/scr/visitorCount.dart';

import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_home_json.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

import 'package:permission_handler/permission_handler.dart';

import 'add_photography_requests.dart';
import 'buy_prescription_request.dart';
import 'doc_profile.dart';
import 'get_all_orderSCr.dart';
import 'get_all_visitor_pointsSCR.dart';
import 'get_list_reservation.dart';

import 'get_list_wedding_reservation.dart';
import 'list_appointments.dart';
import 'list_weddings_services.dart';
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
  List<Widget> homebagelist = [];

  @override
  void initState() {
    token = box.read('token');
    service_type = box.read('service_type');
    _requestPermission();
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
            print(snapshot);
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
                              child: Text("إلغاء"),
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
                                      description: "رقم التليفون  $user_phone" +
                                          "\n" +
                                          "اسم المستخدم $user_name",
                                      buttonText: "الفاء",
                                      phone: false,
                                    ),
                                  );
                                } else {
                                  // set up the button
                                  Widget okButton = TextButton(
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
                                  color: Colors.red,
                                ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            print("888888888888888888");

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
                                  Widget okButton = TextButton(
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
                                  color: Colors.red,
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
                          //  serchWidget(width: width, high: high, fun: fun),
                            SizedBox(
                              height: high * .02,
                            ),
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
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Add_Photography_Requests()),
                                  );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/medical.png',
                                    number: "",//data.totalProduct.toString(),
                                    width: width,
                                    name: "طلب تصميم وتصوير")),







                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           VisitorCount(token)),
                                  // );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/calendar.png',
                                    width: width,
                                    number: data.datePackege,
                                    name: "ﺗﺎﺭﻳﺦ ﺍﻻﺷﺘﺮﺍﻙ")),
                            SizedBox(
                              height: 8,
                            ),
                            // service_type == '1'
                            //     ?

                            // service_type == '1'
                            //     ?
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            List_Appointments()),
                                  );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/medical.png',
                                    number: "",//data.totalProduct.toString(),
                                    width: width,
                                    name: "مواعيد الكشف")),
                            //    : SizedBox(height: 1,),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Get_list_wedding_reservation()),
                                  );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/wedding.png',
                                    number:"",// data.totalProduct.toString(),
                                    width: width,
                                    name: "حجز قاعات افرح ودور مناسبات")),
                            SizedBox(
                              height: high * .02,
                            ),

                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Buy_prescription_request()),
                                  );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/medical_prescription.png',
                                    number:"",// data.totalProduct.toString(),
                                    width: width,
                                    name: "تسعير روشتة")),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = 1;
                                  });
                                },
                                child: item_home_list(
                                    icon: 'assets/images/box.png',
                                    width: width,
                                    number: data.totalProduct.toString(),
                                    name: "ﻋﺪﺩ ﺍﻟﻤﻨﺘﺠﺎﺕ")),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Get_all_visitor_points(token)),
                                  );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/scoreboard.png',
                                    number:data.totalPoints.toString(),
                                    width: width,
                                    name: "ﻋﺪﺩ نقاط")),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Get_all_order(token)),
                                  );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/coupon.png',
                                    width: width,
                                    number: data.totalSelling.toString(),
                                    name: "عدد الكوبونات")),
                            SizedBox(
                              height: 8,
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
                                child: item_home_list(
                                    icon: 'assets/images/community.png',
                                    width: width,
                                    number: data.totalSelling.toString(),
                                    name: "عدد الزوار")),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyOrder()),
                                  );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/shopping_cart.png',
                                    width: width,
                                    number: snapshot.data.result.totalOrders
                                        .toString(),
                                    name: "سلة المشتروات")),
                            SizedBox(
                              height: 8,
                            ),

                            // service_type == '1'
                            //     ?
                            GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Doc_Profile()),
                                      );
                                    },
                                    child: item_home_list(
                                        icon: 'assets/images/scoreboard.png',
                                        number: "",
                                        width: width,
                                        name: "تعديل البروفيل")),
                             //   : SizedBox(),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            //
                            // SizedBox(
                            //   height: 8,
                            // ),



                            ///===============================================================================
                            ///
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Pharmacy()),
                                  );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/pills.png',
                                    number:"",// data.totalProduct.toString(),
                                    width: width,
                                    name: "Pharmacy")),
                            SizedBox(
                              height: 8,
                            ),



                            // SizedBox(
                            //   height: 8,
                            // ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            List_weddings_services()),
                                  );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/food.png',
                                    number:"",// data.totalProduct.toString(),
                                    width: width,
                                    name: "خدمات القاعة")),
                            SizedBox(
                              height: 8,
                            ),

                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Get_list_reservation()),
                                  );
                                },
                                child: item_home_list(
                                    icon: 'assets/images/scoreboard.png',
                                    number:"",// data.totalProduct.toString(),
                                    width: width,
                                    name: "Get_list_reservation")),
                            SizedBox(
                              height: 8,
                            ),
                            //==============================
                            qrgnratt
                                ? CircularProgressIndicator()
                                : GestureDetector(
                                    onTap: () async {
                                      int idOfQR = await box.read('id');
                                      print(
                                          '5555555555555555555555555555555555555555555');
                                      print(box.read('id'));
                                      await _generateBarCode(
                                          box.read('id').toString());

                                      //  Get.to(QRRead(),
                                      //     transition: Transition.leftToRightWithFade);
                                    },
                                    child: Container(
                                      height: high * .07,
                                      width: width * 0.8,
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
                            SizedBox(
                              height: high * .02,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (activediscount) {
                                  _allNetworking
                                      .create_coupon(token_id: token, type: 0)
                                      .then((value) {});
                                  setState(() {});
                                } else {
                                  _allNetworking
                                      .create_coupon(token_id: token, type: 1)
                                      .then((value) {});
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: high * .07,
                                width: width * 0.8,
                                child: Center(
                                  child: activediscount
                                      ? Text(" الغاء  ${data.serviceCoupon}",
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
                                    borderRadius: BorderRadius.circular(40.0)),
                              ),
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
      return ProductScr(() {
        _selectedIndex = 0;

        setState(() {});
      });
    } else if (pos == 2) {
      return OfferScr(() {
        _selectedIndex = 0;

        setState(() {});
      });
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
    print(success);
    await _allNetworking
        .save_QR(token_id: token, file: imageString)
        .then((value) {
      print(value.data);

      Get.dialog(
        AlertDialog(
          title: Text(''),
          content: Text("تم حفظ الصوره في مكتبة الصور"),
          actions: <Widget>[
            TextButton(
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

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  Widget item_home_list({String name, String number, String icon, width}) {
    return Container(
      width: width,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFF0F0F0),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF4F4F4).withOpacity(0.8),
            offset: Offset(0, 2.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 50,
              width: 50,
              child: Image.asset(
                icon,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 1,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(name,
                    style: TextStyle(
                        fontFamily: 'Arbf', color: Colors.black, fontSize: 20)),
                Expanded(flex: 1, child: SizedBox()),
                Text(number,
                    style: TextStyle(
                        fontFamily: 'Arbf', color: Colors.red, fontSize: 20)),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
