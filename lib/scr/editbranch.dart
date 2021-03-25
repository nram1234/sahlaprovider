import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_edit_branch_JSON.dart';

class EditPranch extends StatefulWidget {
  int bid;
  String tok;

  EditPranch({this.bid});

  @override
  _EditPranchState createState() => _EditPranchState();
}

class _EditPranchState extends State<EditPranch> {

  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlexfromweb;
  CameraPosition _kGooglePlex;
  bool setcaruntloction = false;
  File _image;
  AllNetworking _allNetworking = AllNetworking();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  TextEditingController title = TextEditingController();
  TextEditingController titlen_en = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  TextEditingController phone3 = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController twetter = TextEditingController();
  TextEditingController insta = TextEditingController();

  TextEditingController description = TextEditingController();
  TextEditingController description_en = TextEditingController();

  TextEditingController addersinmap = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController mail = TextEditingController();

  TextEditingController address = TextEditingController();
  TextEditingController address_en = TextEditingController();
  LatLng mlocation;
  bool svaedata=false;
  // getloc() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   _locationData = await location.getLocation();
  //   _kGooglePlex = CameraPosition(
  //     target: LatLng(_locationData.latitude, _locationData.longitude),
  //     zoom: 15,
  //   );
  //   setState(() {
  //     print(_kGooglePlex.target);
  //   });
  // }

  String token;
  final box = GetStorage();

  @override
  void initState() {
    //  getloc();
    token = box.read('token');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // final CameraPosition _kLake = CameraPosition(
    //   bearing: 192.8334901395799,
    //   target: LatLng(37.43296265331129, -122.08832357078792),
    //   tilt: 59.440717697143555,
    //   zoom: 19.151926040649414);

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            drawer: Mydrawer(),// mydrawer(context),
            appBar: AppBar(actions: [GestureDetector(
              onTap: () {
                Navigator.pop(context, false);
              }, child: Icon(Icons.arrow_forward_outlined),)
            ],
              centerTitle: true,
              title: Text('تعديل فرع',
                  style: TextStyle(
                    fontFamily: 'Arbf',
                    color: Colors.black,
                  )),
            ),
            body: FutureBuilder<Preparation_edit_branch_JSON>(
              future: _allNetworking.preparation_edit_branch(
                  token_id: token, id_branch: widget.bid),
              builder: (conrtex, snap) {
                if (snap.hasData && snap.data.status) {
                  title.text = snap.data.result.allProducts.brancheName;
                  titlen_en.text = snap.data.result.allProducts.brancheNameEn;
                  phone.text = snap.data.result.allProducts.phone;
                  phone2.text = snap.data.result.allProducts.phoneSecond;
                  phone3.text = snap.data.result.allProducts.phoneThird;
                  whatsapp.text = snap.data.result.allProducts.whatsapp;
                  address.text = snap.data.result.allProducts.address;
                  address_en.text = snap.data.result.allProducts.addressEn;
                  description.text = snap.data.result.allProducts.description;
                  description_en.text =
                      snap.data.result.allProducts.descriptionEn;
                  mlocation=LatLng(double.parse(snap.data.result.allProducts.lat),
                      double.parse(snap.data.result.allProducts.lag));

                  _kGooglePlexfromweb = CameraPosition(
                    target: mlocation,
                    zoom: 10,
                  );
                  // if (!snap.data.result.allProducts.lat.trim().isEmpty) {
                  //   showcurntpos = true;
                  //
                  // }
                  // description.text=snap.data.result.allProducts.;
                  // description_en,
                  //  phone_second,
                  ///  phone_third,
                  //  city_id.text=snap.data.result.allProducts.c;
                  addersinmap.text =
                      snap.data.result.allProducts.location ?? " ";
                  print('pppppppppppppppppppppppppppppppppppppppppppp');
                  print(mlocation);
                  print('pppppppppppppppppppppppppppppppppppppppppppp');
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 50, left: 50, right: 50, bottom: 8),
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
                                  var image = await ImagePicker.platform
                                      .pickImage(
                                      source: ImageSource.gallery,
                                      maxHeight: 200,
                                      maxWidth: 200,
                                      imageQuality: 100);
                                  setState(() {
                                    if (image != null) {
                                      _image = File(image.path);
                                    }
                                  });
                                },
                                child:   Text('اضافة صورة المكان',
                                    style: TextStyle(
                                        fontFamily: 'Arbf',
                                        color: hexToColor('#ed1c6f'),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)) ,
                              ),

                              InkWell(
                                onTap: () async {
                                  var image = await ImagePicker.platform
                                      .pickImage(
                                      source: ImageSource.gallery,
                                      maxHeight: 200,
                                      maxWidth: 200,
                                      imageQuality: 100);
                                  setState(() {
                                    if (image != null) {
                                      _image = File(image.path);
                                    }
                                  });
                                },
                                child: Container(
                                  height: high * .1,
                                  width: high * .1,
                                  child: _image != null
                                      ? Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  )
                                      : Image.network(
                                    snap.data.result.allProducts.productImage,
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
                                color: hexToColor('#00abeb'),
                                gradient: new LinearGradient(
                                    colors: [
                                      hexToColor('#2358a6'),
                                      hexToColor('#00abeb')
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: high * .01,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            maxLines: null,
                            controller: title,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'الاسم بالكامل',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'الاسم بالكامل',
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
                            controller: titlen_en,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Name',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'Name',
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
                            controller: phone,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'رقم التلفون',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'رقم التلفون',
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
                            controller: phone2,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'رقم التلفون',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'رقم التلفون',
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
                            controller: phone3,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'رقم التلفون',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'رقم التلفون',
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
                            controller: whatsapp,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'رقم الوتس اب',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'رقم الوتس اب',
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
                            controller: address,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'العنوان',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
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
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
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
                            controller: description,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'تفاصيل',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'تفاصيل',
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
                            controller: description_en,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'description',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
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
                          TextFormField(
                            textAlign: TextAlign.center,
                            maxLines: null,
                            controller: addersinmap,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'عنوان علي الخريطه',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'عنوان علي الخريطه',
                              hintStyle: TextStyle(
                                fontFamily: 'Arbf',
                                color: hexToColor('#ed1c6f'),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: high * .01,
                          // ),
                          // CheckboxListTile(
                          //   title: Text("تغير الموقع الحالي الي موقع جديد"),
                          //   value: setcaruntloction,
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       setcaruntloction = newValue;
                          //     });
                          //   },
                          //   controlAffinity: ListTileControlAffinity
                          //       .leading, //  <-- leading Checkbox
                          // ),
                          SizedBox(
                            height: high * .01,
                          ),
                          Container(
                            height: high * .3,
                            child: Center(
                              child: GoogleMap(
                                mapType: MapType.normal,zoomGesturesEnabled: true,
                                initialCameraPosition:   _kGooglePlexfromweb
                                ,onTap: (LatLng mylocation){

                                mlocation=mylocation;
                                print(mlocation);
                              },
                                onMapCreated:
                                    (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: high * .01,
                          ),
                          svaedata?CircularProgressIndicator() :    GestureDetector(
                            onTap: () {
                              svaedata=true;
                              setState(() {

                              });
                              print('pppppppppppppppppppppppppppppppppppppppppppp');
                              print(mlocation);
                              print('pppppppppppppppppppppppppppppppppppppppppppp');
                              _allNetworking
                                  .edit_branch(
                                  token_id: token,
                                  id_branch: widget.bid,
                                  location: addersinmap.text,
                                  title: title.text,
                                  titlen_en: titlen_en.text,
                                  phone: phone.text,
                                  whatsapp: whatsapp.text,
                                  address: address.text,
                                  address_en: address_en.text,
                                  description: description.text,
                                  description_en: description_en.text,
                                  phone_second: phone2.text,
                                  phone_third: phone3.text,
                                  lag:
                                  mlocation.longitude
                                  ,
                                  lat:
                                  mlocation.latitude,

                                  file: _image)
                                  .then((value) {
                                Get.dialog(
                                  AlertDialog(
                                    title: Text( ''),
                                    content: Text("تم التعديل"),
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
                                svaedata=false;
                                setState(() {

                                });
                                print(value.data);
                                print(value.data["message"]);
                              });
                              // print("_locationData.longitude");
                              // print(_locationData.longitude);
                              // print(_locationData.latitude);
                              // print(_locationData.accuracy);
                              // print(_locationData.time);
                            },
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
                                    borderRadius: BorderRadius.circular(5.0))),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )));
  }
}
