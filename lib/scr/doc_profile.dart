import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_doc_profile_json.dart';

class Doc_Profile extends StatefulWidget {
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

  //================================================
  TextEditingController nameen = TextEditingController();
  TextEditingController kinden = TextEditingController();
  TextEditingController desen = TextEditingController();
  TextEditingController watingtimeen = TextEditingController();
  TextEditingController adderssenz = TextEditingController();
  TextEditingController priceen = TextEditingController();
  AllNetworking _allNetworking = AllNetworking();
  bool senddata = false;

  Completer<GoogleMapController> _controller = Completer();
  PermissionStatus _permissionGranted;
  LatLng _locationData;
  bool _serviceEnabled;
  CameraPosition _kGooglePlex;
  bool setcaruntloction = false;


  final box = GetStorage();
  String token;

  @override
  void initState() {
    super.initState();
    token = box.read('token');
    _kGooglePlex = CameraPosition(
      target: LatLng(30.518043908795214, 31.575481854379177),
      zoom: 15,
    );
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
        body: StreamBuilder<Preparation_doc_profile_json>(
            stream: _allNetworking
                .preparation_doc_profile(token_id: token)
                .asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                name.text = snapshot.data.result.serviceDetails[0].nameAr;

                kind.text =
                    snapshot.data.result.serviceDetails[0].specialization;
                des.text = snapshot.data.result.serviceDetails[0].description;
                watingtime.text =
                    snapshot.data.result.serviceDetails[0].waitingTime;
                adderss.text = snapshot.data.result.serviceDetails[0].address;
                price.text =
                    snapshot.data.result.serviceDetails[0].detectionPrice;

                phone.text = snapshot.data.result.serviceDetails[0].phone;
                //================================================
                nameen.text = snapshot.data.result.serviceDetails[0].nameEn;
                kinden.text =
                    snapshot.data.result.serviceDetails[0].specializationEn;
                desen.text =
                    snapshot.data.result.serviceDetails[0].descriptionEn;
                watingtimeen.text =
                    snapshot.data.result.serviceDetails[0].waitingTimeEn;
                adderssenz.text =
                    snapshot.data.result.serviceDetails[0].specialization;
                priceen.text =
                    snapshot.data.result.serviceDetails[0].detectionPriceEn;
print( snapshot.data.result.serviceDetails[0].detectionPriceEn);
                print(" snapshot.data.result.serviceDetails[0].detectionPriceEn");
                print( snapshot.data.result.serviceDetails[0].waitingTimeEn);
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
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
                            hint: 'التخصص',
                            inputtype: TextInputType.text,
                            textEditingController: kind),
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
                                onTap: () {
                                  print(price.text);
                                  print(price.text);
                                  senddata = true;
                                  setState(() {});
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
                                          lat: _locationData.latitude,
                                          lag: _locationData.longitude)
                                      .then((value) {
                                    print(value.data);
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
                                    initialCameraPosition: _kGooglePlex,onTap: (LatLng mylocation){

                              _locationData=mylocation;
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
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Widget mywidget(
      {hint, inputtype, TextEditingController textEditingController}) {
    return TextFormField(
      keyboardType: inputtype,
      controller: textEditingController,
      //   textAlign: TextAlign.center,
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
      // textAlign: TextAlign.center,
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
}
