import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sahlaprovider/bloc/addPranchvalidator.dart';
import 'package:sahlaprovider/myWidget/inputTextWidget.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';

class AddnewPranch extends StatefulWidget {
  @override
  _AddnewPranchState createState() => _AddnewPranchState();
}

class _AddnewPranchState extends State<AddnewPranch> {
  DatavalidatorAddPranch v = DatavalidatorAddPranch();

  Completer<GoogleMapController> _controller = Completer();

  TextEditingController address = TextEditingController();
  TextEditingController address_en = TextEditingController();

  CameraPosition _kGooglePlex;

  File _image;
  AllNetworking _allNetworking = AllNetworking();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LatLng _locationData;
  String title,
      titlen_en,
      phone,
      phone2,
      phone3,
      whatsapp,

      description,
      description_en,
      phone_second,
      phone_third,
      addersinmap,
      city_id;


bool svaedata=false;
  String token;
  final box = GetStorage();

  @override
  void initState() {

    token = box.read('token');
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(30.518043908795214, 31.575481854379177),
      zoom: 15,
    );
  }

  @override
  void dispose() {
    v.despoos();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // final CameraPosition _kLake = CameraPosition(
    //   bearing: 192.8334901395799,
    //   target: LatLng(37.43296265331129, -122.08832357078792),
    //   tilt: 59.45717697143555,
    //   zoom: 19.15192605649414);

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: mydrawer(context),
          appBar: AppBar(
            centerTitle: true,
            title: Text('اضافه فرع',
                style: TextStyle(
                  fontFamily: 'Arbf',
                  color: Colors.black,
                )),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 8),
              child: Column(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //  crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var image = await ImagePicker.platform.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 1000,
                              maxWidth: 1000,
                              imageQuality: 100);
                          setState(() {
                            if (image != null) {
                              _image = File(image.path);
                            }
                          });
                        },
                        child: Text('اضافة صورة المكان',
                            style: TextStyle(
                                fontFamily: 'Arbf',
                                color: hexToColor('#ed1c6f'),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      _image == null
                          ? Icon(Icons.camera_alt)
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_image),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 50, left: 50),
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        gradient: new LinearGradient(
                            colors: [
                              Colors.red[100],
                              Colors.red[900],
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('ﻣﻌﺮﺽ ﺍﻟﺼﻮﺭ',
                  //         style: TextStyle(
                  //             fontFamily: 'Arbf',
                  //             color: hexToColor('#ed1c6f'),
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold)),
                  //     SizedBox(
                  //       width: 50,
                  //     ),
                  //     Icon(Icons.camera_alt)
                  //   ],
                  // ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'الاسم بالكامل',
                    stram: v.arnameprPranch,
                    changedata: (st) {
                      v.changeName(st);
                      title = st;
                    },
                    inputtype: TextInputType.text,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'Full Name',
                    stram: v.ennamePranch,
                    changedata: (st) {
                      v.changeenName(st);

                      titlen_en = st;
                    },
                    inputtype: TextInputType.text,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'رقم التلفون',
                    stram: v.mobilePranch,
                    changedata: (st) {
                      v.changearmobile(st);

                      phone = st;
                    },
                    inputtype: TextInputType.phone,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'رقم التلفون ',
                    changedata: (st) {
                      phone2 = st;
                    },
                    inputtype: TextInputType.phone,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'رقم التلفون',
                    changedata: (st) {
                      phone3 = st;
                    },
                    inputtype: TextInputType.phone,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'رقم الوتس اب',
                    stram: v.whatsappPranch,
                    changedata: (st) {
                      v.changewhatsapp(st);

                      whatsapp = st;
                    },
                    inputtype: TextInputType.phone,
                  ),

                  SizedBox(
                    height: high * .01,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    maxLines: null,
                    controller: address,
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'العنوان',
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
                      hintText: 'العنوان',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: high * .01,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    maxLines: null,
                    controller: address_en,
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'address',
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
                      hintText: 'address',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    maxLines: null,
                    onChanged: (v){
                      description=v;
                    },
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'التفاصيل',
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
                      hintText: 'التفاصيل',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),   SizedBox(
                    height: high * .01,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    maxLines: null,
                    onChanged: (v){
                      description_en=v;
                    },
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'description',
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
                      hintText: 'description',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'العنوان علي الخريطه',
                    changedata: (st) {
                      addersinmap = st;
                    },
                    inputtype: TextInputType.text,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  Container(
                    height: high * .3,
                    child: Center(
                      child: _kGooglePlex == null
                          ? CircularProgressIndicator()
                          : GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,onTap: (LatLng mylocation){

                        _locationData=mylocation;
                        print(_locationData);
                      },
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                    ),
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
          svaedata?CircularProgressIndicator() :   GestureDetector(
                onTap:   () {
                  svaedata=true;
                  setState(() {
                    
                  });
                  _allNetworking
                      .add_branch(
                      token_id: token,
                      title: title,
                      location: addersinmap,
                      titlen_en: titlen_en ,
                      phone: phone  ,
                      address_en: address_en.text,
                      address: address.text,
                      whatsapp: whatsapp ,

                      description: description ,
                      description_en: description_en ,
                      phone_second: phone2 ,
                      phone_third: phone3,


                      lag: _locationData==null?37.43296265331129: _locationData.longitude ,
                      lat: _locationData==null?-122.08832357078792:   _locationData.latitude ,
                      file: _image)
                      .then((value) {
                    print(value);
                    Navigator.pop(context);
                  });

                  // print("_locationData.longitude");
                  // print(_locationData.longitude);
                  // print(_locationData.latitude);
                  // print(_locationData.accuracy);
                  // print(_locationData.time);
                }
                    ,
                child: Container(
                  height: high * .1,
                  width: width * 0.5,
                  child: Center(
                    child: Text('حفظ',
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.white,
                            fontSize: 25)),
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
                      borderRadius: BorderRadius.circular(5.0))

                ),
              )
                ],
              ),
            ),
          ),
        ));
  }
}
