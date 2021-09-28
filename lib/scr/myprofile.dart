import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sahlaprovider/myWidget/gallery.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/scr/statistics.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';

class Profilee extends StatefulWidget {
  BuildContext mycontext;

  @override
  _ProfileeState createState() => _ProfileeState();

  Profilee(this.mycontext);
}

class _ProfileeState extends State<Profilee> {
  TextEditingController bilednumber = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController titlen_en = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  TextEditingController phone3 = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController state_id = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController description_en = TextEditingController();

  TextEditingController addersinmap = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController twiter = TextEditingController();
  TextEditingController website = TextEditingController();

  TextEditingController insta = TextEditingController();
  TextEditingController dlivery = TextEditingController();

  TextEditingController address = TextEditingController();

  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();

  // Location location = new Location();
  Completer<GoogleMapController> _controller = Completer();

  //PermissionStatus _permissionGranted;
  LatLng _locationData;
  bool _serviceEnabled;
  CameraPosition _kGooglePlex;
  bool setcaruntloction = false;
  File _image;
  File _profileImage;
  bool senddata = false;
  bool getdata = true;
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

  @override
  void initState() {
    super.initState();
    getdatafromwep();
  }

  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _picked;
  String starttime = ' الساعة';
  String endtime = ' الساعة';

  Future<String> selecttime({BuildContext context}) async {
    _picked = await showTimePicker(context: context, initialTime: _time);

    return _picked.format(context);
  }

  //ServiceDetails dat;
  String mainImg;
  String profileImg;
  getdatafromwep() {
    _allNetworking
        .preparation_doc_profile(token_id: box.read('token'))
        .then((value) {
      //dat = value.result.serviceDetails[0] as ServiceDetails;//value.d.result.serviceDetails[0];
      //     starttime= snapshot.data.result.serviceDetails[0].;
      starttime = value.result.serviceDetails[0].fromHrs;
      endtime = value.result.serviceDetails[0].toHrs;
      address.text = value.result.serviceDetails[0].address;
      mainImg = value.result.serviceDetails[0].mainImg;
      profileImg = value.result.serviceDetails[0].profileImage;
      title.text = value.result.serviceDetails[0].nameAr;

      password.text = value.result.serviceDetails[0].password;

      titlen_en.text = value.result.serviceDetails[0].nameEn;
      phone.text = value.result.serviceDetails[0].phone;
      phone2.text = value.result.serviceDetails[0].phoneSecond;
      phone3.text = value.result.serviceDetails[0].phoneThird;
      whatsapp.text = value.result.serviceDetails[0].whatsapp;
      email.text = value.result.serviceDetails[0].email;

      description.text = value.result.serviceDetails[0].description;
      description_en.text = value.result.serviceDetails[0].descriptionEn;

      addersinmap.text = value.result.serviceDetails[0].location;
      facebook.text = value.result.serviceDetails[0].facebook;
      twiter.text = value.result.serviceDetails[0].twitter;
      insta.text = value.result.serviceDetails[0].instagram;
      if (value.result.serviceDetails[0].lag.trim().isEmpty) {
        _kGooglePlex = CameraPosition(
          target: LatLng(30.518043908795214, 31.575481854379177),
          zoom: 15,
        );
      } else {
        _kGooglePlex = CameraPosition(
          target: LatLng(double.parse(value.result.serviceDetails[0].lat),
              double.parse(value.result.serviceDetails[0].lag)),
          zoom: 15,
        );
      }
      if (value.result.serviceDetails[0].deliveryOn == '1') {
        dlivery.text = 'يوجد دليفيري';
      } else {
        dlivery.text = 'لايوجد دليفيري ';
      }

      getdata = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: Mydrawer(), // mydrawer(context),
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: Icon(Icons.arrow_forward_outlined),
              )
            ],
            centerTitle: true,
            title: Text('ﺍﻟﺒﺮﻭﻓﺎﻳﻞ',
                style: TextStyle(
                  fontFamily: 'Arbf',
                  color: Colors.black,
                )),
          ),
          body: getdata
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
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
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    _pickMainImage();
                                  },
                                  child: _image == null &&
                                          mainImg.trim().isEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          //  crossAxisAlignment: CrossAxisAlignment.baseline,
                                          children: [
                                            Text('اضافة صورة المكان',
                                                style: TextStyle(
                                                    fontFamily: 'Arbf',
                                                    color:
                                                        hexToColor('#ed1c6f'),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )
                                      : _image == null
                                          ? Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .3,
                                              child: Image.network(
                                                mainImg,
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .3,
                                              child: Image.file(
                                                _image,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                ),
                                Text('صورة المكان',
                                    style: TextStyle(
                                        fontFamily: 'Arbf',
                                        color: hexToColor('#ed1c6f'),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    _pickProfileImage();
                                  },
                                  child: _profileImage == null &&
                                          profileImg.trim().isEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          //  crossAxisAlignment: CrossAxisAlignment.baseline,
                                          children: [
                                            Text('اضافة صورة بروفايل',
                                                style: TextStyle(
                                                    fontFamily: 'Arbf',
                                                    color:
                                                        hexToColor('#ed1c6f'),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            // Icon(Icons.camera_alt)
                                          ],
                                        )
                                      : _profileImage == null
                                          ? Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .3,
                                              child: Image.network(
                                                profileImg,
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .3,
                                              child: Image.file(
                                                _profileImage,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                ),
                                Text('صورة بروفايل',
                                    style: TextStyle(
                                        fontFamily: 'Arbf',
                                        color: hexToColor('#ed1c6f'),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Gallery()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('ﻣﻌﺮﺽ ﺍﻟﺼﻮﺭ',
                                  style: TextStyle(
                                      fontFamily: 'Arbf',
                                      color: hexToColor('#ed1c6f'),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 50,
                              ),
                              Icon(Icons.camera_alt)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                          textEditingController: title,
                          hint: 'الاسم بالكامل',
                          inputtype: TextInputType.text,
                        ),
                        SizedBox(
                          height: high * .01,
                        ),

                        mywidget(
                          textEditingController: description,
                          hint: 'الوصف',
                          inputtype: TextInputType.multiline,
                        ),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                          textEditingController: description_en,
                          hint: 'Details',
                          inputtype: TextInputType.multiline,
                        ),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                          textEditingController: password,
                          hint: 'كلمه المرور',
                          inputtype: TextInputType.text,
                        ),
                        SizedBox(
                          height: high * .01,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(' مواعيد العمل '),
                              GestureDetector(
                                onTap: () {
                                  selecttime(context: context).then((value) {
                                    if (value != null) {
                                      starttime = value;
                                    }
                                    setState(() {});
                                  });
                                  setState(() {});
                                },
                                child: Container(
                                    width: width * .25,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: hexToColor('#00abeb'),
                                        gradient: new LinearGradient(
                                            colors: [
                                              Colors.red[900],
                                              Colors.red[100],
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            tileMode: TileMode.clamp),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Center(
                                        child: Text("  من  " + starttime))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  selecttime(context: context).then((value) {
                                    if (value != null) {
                                      endtime = value;
                                    }
                                    setState(() {});
                                  });
                                  setState(() {});
                                },
                                child: Container(
                                    width: width * .25,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: hexToColor('#00abeb'),
                                        gradient: new LinearGradient(
                                            colors: [
                                              Colors.red[900],
                                              Colors.red[100],
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            tileMode: TileMode.clamp),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Center(
                                        child: Text("  الي  " + endtime))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: high * .01,
                        ),

                        mywidget(
                          textEditingController: whatsapp,
                          hint: 'رقم الوتس اب',
                          inputtype: TextInputType.phone,
                        ),
                        SizedBox(
                          height: high * .01,
                        ),

                        mywidget(
                          textEditingController: address,
                          hint: 'العنوان',
                          inputtype: TextInputType.text,
                        ),

                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                          textEditingController: titlen_en,
                          hint: 'Full Name',
                          inputtype: TextInputType.text,
                        ),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                            textEditingController: facebook,
                            inputtype: TextInputType.text,
                            hint: 'ﺭﺍﺑﻂ ﺍﻟﻔﻴﺲ بوك'),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                            textEditingController: twiter,
                            inputtype: TextInputType.text,
                            hint: 'ﺭﺍﺑﻂ ﺍﻟﺘﻮﻳﺘﺮ'),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                            textEditingController: insta,
                            inputtype: TextInputType.text,
                            hint: 'ﺭﺍﺑﻂ ﺍﻻﻧﺴﺠﺮﺍﻡ'),
                        SizedBox(
                          height: high * .01,
                        ),

                        mywidget(
                            textEditingController: email,
                            inputtype: TextInputType.text,
                            hint: 'البريد الالكتروني'),
                        SizedBox(
                          height: high * .01,
                        ),

                        mywidget(
                            textEditingController: dlivery,
                            inputtype: TextInputType.text,
                            hint: 'ﺧﺪﻣﺔ ﺍﻟﺪﻟﻴﻔﺮﻱ'),
                        SizedBox(
                          height: high * .01,
                        ),
                        TextFormField(
                          textAlign: TextAlign.right,
                          controller: addersinmap,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'عنوان علي الخريطه',
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
                            hintText: 'عنوان علي الخريطه',
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: high * .01,
                        ),
                        senddata
                            ? CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () async {
                                  print(
                                      '0000000000000000000000000000000000000000000000000000000000');
                                  print(starttime);
                                  print(box.read('token'));
                                  print(
                                      '0000000000000000000000000000000000000000000000000000000000');
                                  senddata = true;
                                  setState(() {});
                                  await box.write('name', title.text);
                                  _allNetworking
                                      .edit_profile(
                                    token_id: box.read('token'),
                                    name_ar: title.text,
                                    name_en: titlen_en.text,
                                    phone: phone.text,
                                    whatsapp: whatsapp.text,
                                    address: address.text,
                                    floar_num: bilednumber.text,
                                    description: description.text,
                                    description_en: description_en.text,
                                    phone_second: phone2.text,
                                    phone_third: phone3.text,
                                    main_img: _image,
                                    password: password.text,
                                    location: addersinmap.text,
                                    instagram: insta.text,
                                    profileImage: _profileImage,
                                    lag: 220.22,
                                    lat: 6515.222,
                                    addressEn: '',
                                    twitter: twiter.text,
                                    facebook: facebook.text,
                                    website: website.text,
                                    from_hrs: starttime,
                                    to_hrs: endtime,
                                    email: email.text,
                                  )
                                      .then((value) {
                                    Get.snackbar('', value.data['message']);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Statisticss()),
                                        (Route<dynamic> route) => false);

                                    senddata = false;
                                    setState(() {});
                                  });
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
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
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
                            child: _kGooglePlex == null
                                ? CircularProgressIndicator()
                                : GoogleMap(
                                    mapType: MapType.normal,
                                    onTap: (LatLng mylocation) {
                                      _locationData = mylocation;
                                      print(_locationData);
                                    },
                                    initialCameraPosition: _kGooglePlex,
                                    zoomGesturesEnabled: true,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }

  Widget mywidget(
      {hint, inputtype, TextEditingController textEditingController}) {
    return TextFormField(
      keyboardType: inputtype,
      controller: textEditingController,
      textAlign: TextAlign.right,
      maxLines: null,
      style: TextStyle(
        fontFamily: 'Arbf',
        color: hexToColor('#ed1c6f'),
      ),
      decoration: InputDecoration(
        labelText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'Arbf',
          color: hexToColor('#ed1c6f'),
        ),
      ),
    );
  }

  Future<Null> _pickMainImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 800,
        imageQuality: 100);
    _cropMainImage(image);
    //  setState(() {
    //    if (image != null) {
    //      _image = File(image.path);
    //    }
    // });
  }

  Future<Null> _pickProfileImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 800,
        imageQuality: 100);
    _cropProfileImage(image);
    //  setState(() {
    //    if (image != null) {
    //      _image = File(image.path);
    //    }
    // });
  }

  Future<Null> _cropMainImage(image) async {
    print('pppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp');
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  Future<Null> _cropProfileImage(image) async {
    print('pppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp');
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _profileImage = croppedFile;
      setState(() {});
    }
  }
}
