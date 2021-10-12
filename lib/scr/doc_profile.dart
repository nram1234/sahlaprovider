import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/scr/statistics.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_doc_profile_json.dart';

class Doc_Profile extends StatefulWidget {
  BuildContext mycontext;

  Doc_Profile(this.mycontext);

  @override
  _Doc_ProfileState createState() => _Doc_ProfileState();
}

class _Doc_ProfileState extends State<Doc_Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController kind = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController watingtime = TextEditingController();
  TextEditingController adderss = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController phone = TextEditingController();

  //============================================================
  TextEditingController whatsapp = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController twiter = TextEditingController();
  TextEditingController insta = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  //================================================
  TextEditingController nameen = TextEditingController();
  TextEditingController kinden = TextEditingController();
  TextEditingController desen = TextEditingController();
  TextEditingController watingtimeen = TextEditingController();
  TextEditingController adderssenz = TextEditingController();
  TextEditingController priceen = TextEditingController();
  AllNetworking _allNetworking = AllNetworking();
  bool senddata = false;
  bool getdata = true;
  Completer<GoogleMapController> _controller = Completer();
  PermissionStatus _permissionGranted;
  LatLng _locationData;
  bool _serviceEnabled;
  CameraPosition _kGooglePlex;
  bool setcaruntloction = false;
  File croppedFile;
  File _image;
  File _profileImage;
  final box = GetStorage();
  String token;
  String imgelinke;
  String profileLink;

  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _picked;
  String starttime = ' الساعة';
  String endtime = ' الساعة';
  @override
  void initState() {
    super.initState();
    token = box.read('token');
    getdatafromwep();
    _kGooglePlex = CameraPosition(
      target: LatLng(30.518043908795214, 31.575481854379177),
      zoom: 15,
    );
  }

  getdatafromwep() {
    _allNetworking.preparation_doc_profile(token_id: token).then((value) {
      name.text = value.result.serviceDetails[0].nameAr;
      nameen.text = value.result.serviceDetails[0].nameEn;
      kind.text = value.result.serviceDetails[0].specialization;
      des.text = value.result.serviceDetails[0].description;
      watingtime.text = value.result.serviceDetails[0].waitingTime;
      adderss.text = value.result.serviceDetails[0].address;
      price.text = value.result.serviceDetails[0].detectionPrice;

      phone.text = value.result.serviceDetails[0].phone;
      //================================================
      whatsapp.text = value.result.serviceDetails[0].whatsapp;
      facebook.text = value.result.serviceDetails[0].facebook;
      twiter.text = value.result.serviceDetails[0].twitter;
      insta.text = value.result.serviceDetails[0].instagram;
      password.text = value.result.serviceDetails[0].password;
      email.text = value.result.serviceDetails[0].email;
//===========================================================
      kinden.text = value.result.serviceDetails[0].specializationEn;
      desen.text = value.result.serviceDetails[0].descriptionEn;
      watingtimeen.text = value.result.serviceDetails[0].waitingTimeEn;
      adderssenz.text = value.result.serviceDetails[0].specialization;
      priceen.text = value.result.serviceDetails[0].detectionPriceEn;
      print(value.result.serviceDetails[0].detectionPriceEn);

      print(value.result.serviceDetails[0].waitingTimeEn);
      starttime = value.result.serviceDetails[0].fromHrs;
      endtime = value.result.serviceDetails[0].toHrs;
      imgelinke = value.result.serviceDetails[0].mainImg;
      profileLink = value.result.serviceDetails[0].profileImage;
      print('000000000000000000000000000000000000');
      print(imgelinke);
      print('000000000000000000000000000000000000');
      //  bool senddata = false;
      getdata = false;
      setState(() {});
    });
  }

  Future<String> selecttime({BuildContext context}) async {
    _picked = await showTimePicker(context: context, initialTime: _time);

    return _picked.format(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      top: true,
      child: Scaffold(
          appBar: AppBar(
            title: Text('البروفيل'),
            centerTitle: true,
          ),
          body: getdata
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                _pickMainImage();
                              },
                              child: _image == null && imgelinke.trim().isEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      //  crossAxisAlignment: CrossAxisAlignment.baseline,
                                      children: [
                                        Text('صورة مكان',
                                            style: TextStyle(
                                                fontFamily: 'Arbf',
                                                color: hexToColor('#ed1c6f'),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
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
                                            imgelinke,
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
                            GestureDetector(
                              onTap: () async {
                                _pickProfileImage();
                              },
                              child: _profileImage == null &&
                                      profileLink.trim().isEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      //  crossAxisAlignment: CrossAxisAlignment.baseline,
                                      children: [
                                        Text(' صورة بروفايل',
                                            style: TextStyle(
                                                fontFamily: 'Arbf',
                                                color: hexToColor('#ed1c6f'),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
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
                                            profileLink,
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        mywidget(
                            hint: 'الاسم',
                            inputtype: TextInputType.text,
                            textEditingController: name),
                        SizedBox(
                          height: 10,
                        ),
                        mywidget(
                            hint: 'Name',
                            inputtype: TextInputType.text,
                            textEditingController: nameen),
                        SizedBox(
                          height: 10,
                        ),
                        mywidget(
                            hint: 'رقم الهاتف',
                            inputtype: TextInputType.phone,
                            textEditingController: phone),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                            hint: 'كلمة السر',
                            inputtype: TextInputType.phone,
                            textEditingController: password),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                            hint: 'التخصص',
                            inputtype: TextInputType.text,
                            textEditingController: kind),
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
                              Text('  المواعيد  '),
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
                            hint: 'category',
                            inputtype: TextInputType.text,
                            textEditingController: kinden),
                        SizedBox(
                          height: high * .01,
                        ),
                        mydeswidget(
                            hint: 'الوصف',
                            inputtype: TextInputType.text,
                            textEditingController: des),
                        SizedBox(
                          height: high * .01,
                        ),
                        mydeswidget(
                            hint: 'description',
                            inputtype: TextInputType.text,
                            textEditingController: desen),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                            hint: 'مده الانتظار',
                            inputtype: TextInputType.text,
                            textEditingController: watingtime),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                            hint: 'Wait time',
                            inputtype: TextInputType.text,
                            textEditingController: watingtimeen),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                            hint: 'العنوان',
                            inputtype: TextInputType.text,
                            textEditingController: adderss),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                            hint: 'Address',
                            inputtype: TextInputType.text,
                            textEditingController: adderssenz),
                        SizedBox(
                          height: high * .01,
                        ),
                        mywidget(
                            hint: 'سعر الكشف',
                            inputtype: TextInputType.text,
                            textEditingController: price),
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
                          textEditingController: whatsapp,
                          hint: 'رقم الوتس اب',
                          inputtype: TextInputType.phone,
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
                            hint: 'price',
                            inputtype: TextInputType.text,
                            textEditingController: priceen),
                        SizedBox(
                          height: high * .01,
                        ),
                        SizedBox(
                          height: high * .01,
                        ),
                        senddata
                            ? CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () async {
                                  print(price.text);
                                  print(price.text);
                                  senddata = true;
                                  setState(() {});
                                  await box.write('name', name.text);
                                  _allNetworking
                                      .edit_doc_profile(
                                    token_id: token,
                                    name_ar: name.text,
                                    name_en: nameen.text,
                                    phone: phone.text,
                                    waiting_time: watingtime.text,
                                    detection_price: price.text,
                                    description: des.text,
                                    detection_price_en: priceen.text,
                                    specialization: kind.text,
                                    description_en: desen.text,
                                    specialization_en: kinden.text,
                                    waiting_time_en: watingtimeen.text,
                                    address: adderss.text,
                                    addressEn: adderssenz.text,
                                    instagram: insta.text,
                                    lag: 220.22,
                                    lat: 6515.222,
                                    whatsapp: whatsapp.text,
                                    twitter: twiter.text,
                                    facebook: facebook.text,
                                    email: email.text,
                                    from_hrs: starttime,
                                    main_img: _image,
                                    password: password.text,
                                    to_hrs: endtime,
                                  )
                                      .then((value) {
                                    print(value.data);
                                    senddata = false;
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Statisticss()),
                                        (Route<dynamic> route) => false);
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
                                              Colors.red[900],
                                              Colors.red[100],
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            tileMode: TileMode.clamp),
                                        borderRadius:
                                            BorderRadius.circular(40.0))),
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
                                    initialCameraPosition: _kGooglePlex,
                                    onTap: (LatLng mylocation) {
                                      _locationData = mylocation;
                                      print(_locationData);
                                    },
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
                )),
    );
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
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
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

  Widget mydeswidget(
      {hint, inputtype, TextEditingController textEditingController}) {
    return TextFormField(
      keyboardType: inputtype,
      controller: textEditingController,
      textAlign: TextAlign.right,
      maxLines: 5,
      style: TextStyle(
        fontFamily: 'Arbf',
        color: hexToColor('#ed1c6f'),
      ),
      decoration: InputDecoration(
        labelText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
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
