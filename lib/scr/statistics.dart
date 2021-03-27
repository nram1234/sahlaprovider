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

import 'add_doctor_out_reservation.dart';
import 'add_photography_requests.dart';
import 'add_wedding_reservation.dart';
import 'buy_prescription_request.dart';
import 'doc_profile.dart';
import 'get_all_orderSCr.dart';
import 'get_all_visitor_pointsSCR.dart';
import 'get_list_reservation.dart';

import 'get_list_wedding_reservation.dart';
import 'list_appointments.dart';
import 'list_doctors_services.dart';
import 'list_weddings_services.dart';
import 'myorder.dart';
import 'myprofile.dart';

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
    print('0000000000000000000000000000000000000000000000');
    print(service_type);
    print('0000000000000000000000000000000000000000000000');
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
        icon: service_type == '3'
            ? ImageIcon(
                AssetImage('assets/images/medical.png'),
                color: Colors.grey,
              )
            : Icon(
                Icons.shopping_cart_outlined,
              ),
        label: service_type == '3'
            ? 'خدمات اضافيه'
            : service_type == '2'
                ? 'مستحضرات التجميل'
                : service_type == '4'
                    ? 'خدمات اضافية'
                    : 'الاقسام و المنتجات',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'ﺍﻟﻌﺮﻭﺽ',
      ),
    ];

    return WillPopScope(onWillPop: () async {
      final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return

              CustomDialog(
                Text2:
                " ",
                title: "تنبية",
                function: () { Navigator.of(context).pop(true);},
                buttonText2: "اغلاق",
                description: "هل تريد اغلاق التطبيق؟",
                buttonText: "الفاء",
                phone: false,
              );



            //
            //   AlertDialog(
            //   content: Text('Are you sure you want to exit?'),
            //   actions: <Widget>[
            //     FlatButton(
            //       child: Text('No'),
            //       onPressed: () {
            //         Navigator.of(context).pop(false);
            //       },
            //     ),
            //     FlatButton(
            //       child: Text('Yes, exit'),
            //       onPressed: () {
            //         Navigator.of(context).pop(true);
            //       },
            //     ),
            //   ],
            // );
          }
      );

      return value == true;
    },
      child: Scaffold(
        key: _scaffoldKey,
        drawer:Mydrawer(),// mydrawer(context),
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
      ),
    );

    //swithscren(high: high, width: width, pos: _selectedIndex);
  }

  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _picked;

  Future<String> selecttime({BuildContext context}) async {
    _picked = await showTimePicker(context: context, initialTime: _time);

    return _picked.format(context);
  }

  String starttime = 'من ';
  String endtime = 'الي ';

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
                              hintText:
                                  service_type == '1'
                                      ? 'بحث بالكود او رقم التليفون '
                                      : 'رقم التليفون'),
                        )),
                        service_type == '1' || service_type == '0'
                            ? GestureDetector(
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

                                  if (!_textEditingController.text
                                      .trim()
                                      .isEmpty) {
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
                                            description:
                                                "رقم التليفون  $user_phone" +
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
                              )
                            : SizedBox(),
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
                  drawer: Mydrawer(),// mydrawer(context),
                  body: SafeArea(
                    top: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //  serchWidget(width: width, high: high, fun: fun),
                            Container(
                              width: width,
                              child: Text(
                                snapshot.data.result.servicesTypeName +
                                    "\n" +
                                    box.read('name'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red,
                                border: Border.all(
                                  width: 1.0,
                                  color: const Color(0xFFE37272),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFF4F4F4)
                                        .withOpacity(0.8),
                                    offset: Offset(0, 2.0),
                                    blurRadius: 2.0,
                                  ),
                                ],
                              ),
                            ),

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
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: GestureDetector(
                                  onTap: () {},
                                  child: item_home_list(
                                      icon: 'assets/images/time.png',
                                      keyupdata: 0,
                                      dat: false,
                                      width: width,
                                      number: ' من ${snapshot.data.result.fromHrs} ' +
                                          "\n" +
                                          ' الي ${snapshot.data.result.toHrs} ',
                                      name: "مواعيد العمل")),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Add_Photography_Requests()),
                                    );
                                  },
                                  child: item_home_list(
                                      icon: 'assets/images/cam.png',
                                      keyupdata: 0,
                                      dat: false,
                                      number: "",
                                      //data.totalProduct.toString(),
                                      width: width,
                                      name: "طلب تصميم وتصوير")),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           VisitorCount(token)),
                                    // );
                                  },
                                  child: item_home_list(
                                      fun: () {
                                        _allNetworking
                                            .subscription_renewal(
                                                token_id: token)
                                            .then((value) {
                                          Get.snackbar(
                                              '', value.data['message']);
                                          setState(() {});
                                        }).catchError((e) {
                                          print(e);
                                        });
                                      },
                                      icon: 'assets/images/calendar.png',
                                      dat: true,
                                      width: width,
                                      number: data.startDate,
                                      number2: data.endDate,
                                      keyupdata: data.keyUpdate,
                                      name: "ﺗﺎﺭﻳﺦ ﺍﻻﺷﺘﺮﺍﻙ")),
                            ),

                            service_type == '3'
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Get_list_reservation()),
                                          );
                                        },
                                        child: item_home_list(
                                            icon:
                                                'assets/images/scoreboard.png',
                                            keyupdata: 0,
                                            dat: false,
                                            number: "",
                                            // data.totalProduct.toString(),
                                            width: width,
                                            name: 'طلبات الحجوزات')),
                                  )
                                : service_type == '4'
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Get_list_wedding_reservation()),
                                              );
                                            },
                                            child: item_home_list(
                                                icon:
                                                    'assets/images/wedding.png',
                                                keyupdata: 0,
                                                dat: false,
                                                number: "",
                                                // data.totalProduct.toString(),
                                                width: width,
                                                name:
                                                    "الحجوزات")),
                                      )
                                    : SizedBox(),
                            service_type == '1'
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyOrder()),
                                          );
                                        },
                                        child: item_home_list(
                                            icon:
                                                'assets/images/shopping_cart.png',
                                            keyupdata: 0,
                                            dat: false,
                                            width: width,
                                            number: snapshot
                                                .data.result.totalOrders
                                                .toString(),
                                            name: "طلبات")),
                                  )
                                : SizedBox(),

                            service_type == '3' || service_type == '4'
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (service_type == '3') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Add_Doctor_Out_Reservation()),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Add_Wedding_Reservation()),
                                            );
                                          }
                                        },
                                        child: item_home_list(
                                            icon: 'assets/images/booking.png',
                                            keyupdata: 0,
                                            dat: false,
                                            number: "",
                                            //data.totalProduct.toString(),
                                            width: width,
                                            name: "اضافة حجز خارجي")),
                                  )
                                : SizedBox(),

                            service_type == '0'
                                ? SizedBox()
                                : service_type == '3'
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        List_Appointments()),
                                              );
                                            },
                                            child: item_home_list(
                                                icon:
                                                    'assets/images/medical.png',
                                                keyupdata: 0,
                                                dat: false,
                                                number: "",
                                                //data.totalProduct.toString(),
                                                width: width,
                                                name: "مواعيد الكشف")),
                                      )
                                    : SizedBox(),

                            service_type == '0'
                                ? SizedBox()
                                : service_type == '4'
                                    ? SizedBox()
                                    // GestureDetector(
                                    //             onTap: () {
                                    //               Navigator.push(
                                    //                 context,
                                    //                 MaterialPageRoute(
                                    //                     builder: (context) =>
                                    //                         List_weddings_services()),
                                    //               );
                                    //             },
                                    //             child: item_home_list(
                                    //                 icon: 'assets/images/food.png',
                                    //                 keyupdata: 0,
                                    //                 dat: false,
                                    //                 number: "",
                                    //                 // data.totalProduct.toString(),
                                    //                 width: width,
                                    //                 name: "خدمات القاعة"))
                                    : service_type == '1'
                                        ? Container()
                                        // GestureDetector(
                                        //     onTap: () {
                                        //       setState(() {
                                        //         _selectedIndex = 1;
                                        //       });
                                        //     },
                                        //     child: item_home_list(
                                        //         icon: 'assets/images/box.png',
                                        //         keyupdata: 0,
                                        //         dat: false,
                                        //         width: width,
                                        //         number: data.totalProduct
                                        //             .toString(),
                                        //         name: "الاقسام و المنتجات"))
                                        : service_type == '2'
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Pharmacy()),
                                                      );
                                                    },
                                                    child: item_home_list(
                                                        icon:
                                                            'assets/images/pills.png',
                                                        keyupdata: 0,
                                                        dat: false,
                                                        number: "",
                                                        // data.totalProduct.toString(),
                                                        width: width,
                                                        name: 'تسعير روشتات')),
                                              )
                                            :SizedBox(),
                          service_type == '2' ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 8.0),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Buy_prescription_request()),
                                                          );
                                                        },
                                                        child: item_home_list(
                                                            icon:
                                                                'assets/images/medical_prescription.png',
                                                            keyupdata: 0,
                                                            dat: false,
                                                            number: "",
                                                            // data.totalProduct.toString(),
                                                            width: width,
                                                            name:
                                                                "طلب شراء روشتات ")),
                                                  )
                                                : SizedBox(),




                            service_type == '2'
                                ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyOrder()),
                                    );
                                  },
                                  child: item_home_list(
                                      icon:
                                      'assets/images/shopping_cart.png',
                                      keyupdata: 0,
                                      dat: false,
                                      width: width,
                                      number: snapshot
                                          .data.result.totalOrders
                                          .toString(),
                                      name: "طلبات شراء مستحضرات تجميل")),
                            )
                                : SizedBox(),


                            service_type == '3'
                                ? SizedBox()
                                : service_type == '2'
                                    ? SizedBox()
                                    : service_type == '0'
                                        ? SizedBox()
                                        : service_type == '4'
                                            ? SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Get_all_visitor_points(
                                                                    token)),
                                                      );
                                                    },
                                                    child: item_home_list(
                                                        icon:
                                                            'assets/images/scoreboard.png',
                                                        keyupdata: 0,
                                                        dat: false,
                                                        number: data.totalPoints
                                                            .toString(),
                                                        width: width,
                                                        name: "ﻋﺪﺩ نقاط")),
                                              ),

//=========================================================================  GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             Get_all_visitor_points(token)),
//                                   );
//                                 },
//                                 child: item_home_list(
//                                     icon: 'assets/images/scoreboard.png',keyupdata: data.keyUpdate,
//                                     number: data.totalPoints.toString(),
//                                     width: width,
//                                     name: "ﻋﺪﺩ نقاط")),======================

                            //    : SizedBox(height: 1,),

                            service_type != '0' || service_type != '1'
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: GestureDetector(
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
                                            keyupdata: 0,
                                            dat: false,
                                            width: width,
                                            number:
                                                data.totalSelling.toString(),
                                            name: "عدد الكوبونات")),
                                  ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: GestureDetector(
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
                                      keyupdata: 0,
                                      dat: false,
                                      width: width,
                                      number: data.totalSelling.toString(),
                                      name: "عدد الزوار")),
                            ),

                            Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: GestureDetector(
                                        onTap: () async{
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
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           Doc_Profile()),
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
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           Profilee()),
                                            // );
                                          }
                                        },
                                        child: item_home_list(
                                            icon: 'assets/images/t.png',
                                            keyupdata: 0,
                                            dat: false,
                                            number: "",
                                            width: width,
                                            name: "تعديل البروفيل")),
                                  ),

                            //==============================
                            qrgnratt
                                ? CircularProgressIndicator()
                                : service_type == '1' //|| service_type == '0'
                                    ? GestureDetector(
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
                                      )
                                    : SizedBox(),
                            SizedBox(
                              height: high * .02,
                            ),
                            service_type == '1' //|| service_type == '0'Z
                                ? GestureDetector(
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
                                      width: width * 0.8,
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
                                : SizedBox()
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
      if (service_type == '3') {
        return List_Doctors_Services(() {
          _selectedIndex = 0;

          setState(() {});
        });
      } else if (service_type == '4') {
        return List_weddings_services();
      } else {
        return ProductScr(() {
          _selectedIndex = 0;

          setState(() {});
        });
      }
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

  Widget screnbyservice_type(String service_type) {
    if (service_type == '1') {}
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  Widget item_home_list(
      {String name,
      String number,
      String icon,
      width,
      int keyupdata,
      fun,
      number2,
      bool dat}) {
    print("111111111111111111111111111111");
    print(keyupdata);
    print("111111111111111111111111111111");
    return Container(
      width: width,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: keyupdata == 1 ? Colors.red[100] : Colors.white,
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
            child:keyupdata == 1
                ? GestureDetector(
              onTap: keyupdata == 1 ? fun : null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                    height: 75,
                    color: Colors.red,
                    width: 75,
                    child: Center(
                        child: Text(
                            keyupdata == 1
                                ? 'تجديد الاشتراك'
                                : ' تم ارسال الطلب',
                            style: TextStyle(
                                fontFamily: 'Arbf',
                                color: Colors.white,
                                fontSize: 10)))),
              ),
            ):
            Container(
              padding: EdgeInsets.all(20),
              height: 75,
              color: Colors.red,
              width: 75,
              child: Image.asset(
                icon,
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 1,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(name,
                    style: TextStyle(
                        fontFamily: 'Arbf', color: Colors.black, fontSize: 15)),
                 SizedBox(width: 8,)  ,
                dat
                    ? Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(" من " + number,
                                style: TextStyle(
                                    fontFamily: 'Arbf',
                                    color: Colors.red,
                                    fontSize: 13)),
                            Text(" الي " + number2,
                                style: TextStyle(
                                    fontFamily: 'Arbf',
                                    color: Colors.red,
                                    fontSize: 13)),
                          ],
                        ))
                    : Flexible(
                        child: Text(number,
                            style: TextStyle(
                                fontFamily: 'Arbf',
                                color: Colors.red,
                                fontSize: 12)),
                      ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
