import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_wedding_service_json.dart';

class Add__wedding_service extends StatefulWidget {
  BuildContext mycontext;

  Add__wedding_service(this.mycontext);

  @override
  _Add__wedding_serviceState createState() => _Add__wedding_serviceState();
}

class _Add__wedding_serviceState extends State<Add__wedding_service> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String token;

  bool getdata = true;
  AllCurrency dropdownValue;

  List<AllCurrency> dataaa = [];

  @override
  void initState() {
    super.initState();
    token = box.read('token');
    _allNetworking.Preparation_wedding_service(token_id: token).then((value) {
      print(value);

      dataaa = value.result.allCurrency;
      print(dataaa);
     getdata = false;
     setState(() {});
    });
  }

  bool adddata = false;
  String thename, theenname, price;

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer:Mydrawer(),// mydrawer(context),
          appBar: AppBar(
            automaticallyImplyLeading: true,
              actions: [GestureDetector(
                onTap: () {
                  Navigator.pop(context, false);
                }, child: Icon(Icons.arrow_forward_outlined),)
              ],
            centerTitle: true,
            title: Text('اضافة خدمات',
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
            child: ListView(children: [
              SizedBox(
                height: high * .1,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Text('اضافه صوره للخدمه',
              //         style: TextStyle(
              //             fontFamily: 'Arbf',
              //             color: hexToColor('#00abeb'),
              //             fontSize: 20)),
              //     GestureDetector(
              //       onTap: () async {
              //         var image = await ImagePicker.platform.pickImage(
              //             source: ImageSource.gallery,
              //             maxHeight: 200,
              //             maxWidth: 200,
              //             imageQuality: 100);
              //         setState(() {
              //           _image = File(image.path);
              //         });
              //       },
              //       child: _image == null
              //           ? CircleAvatar(
              //         radius: 50,
              //         backgroundColor: Colors.red,
              //       )
              //           : CircleAvatar(
              //         radius: 50,
              //         backgroundImage: FileImage(_image),
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(
                height: high * .02,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (s) {
                  thename = s;
                },
                textAlign: TextAlign.center,
                maxLines: null,
                style: TextStyle(
                  fontFamily: 'Arbf',
                  color: hexToColor('#ed1c6f'),
                ),
                decoration: InputDecoration(
                  labelText: 'اسم الخدمة',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'اسم الخدمة',
                  hintStyle: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                ),
              ),
              SizedBox(
                height: high * .02,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (s) {
                  theenname = s;
                },
                textAlign: TextAlign.center,
                maxLines: null,
                style: TextStyle(
                  fontFamily: 'Arbf',
                  color: hexToColor('#ed1c6f'),
                ),
                decoration: InputDecoration(
                  labelText: 'Name of the service',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Name of the service',
                  hintStyle: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                ),
              ),
              SizedBox(
                height: high * .02,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (s) {
                  price = s;
                },
                textAlign: TextAlign.center,
                maxLines: null,
                style: TextStyle(
                  fontFamily: 'Arbf',
                  color: hexToColor('#ed1c6f'),
                ),
                decoration: InputDecoration(
                  labelText: 'سعر الخدمة',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'سعر الخدمة',
                  hintStyle: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                ),
              ),
              SizedBox(
                height: high * .02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                child: getdata
                    ? CircularProgressIndicator()
                    : DropdownButton<AllCurrency>(
                        value: dropdownValue,
                        hint: Text('نوع العملة'),
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (AllCurrency newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: dataaa.map<DropdownMenuItem<AllCurrency>>(
                            (AllCurrency value) {
                          return DropdownMenuItem<AllCurrency>(
                            value: value,
                            child: Text(value.currencyName),
                          );
                        }).toList(),
                      ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: high * .02,
              ),
              adddata
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () async {
                        adddata = true;
                        setState(() {});

                        if (dropdownValue != null) {
                          _allNetworking
                              .add__wedding_service(
                                  token_id: token,
                                  name: thename,
                                  name_en: theenname,
                                  price: price,
                                  currency_id: dropdownValue.currencyId)
                              .then((value) {
                            Navigator.pop(widget.mycontext);

                            print(value.data);
                            adddata = false;
                            setState(() {});
                          });
                        } else {
                          adddata=false;
                          setState(() {

                          });
                        }
                      },
                      child: Container(
                          height: high * .05,
                          width: width * 0.7,
                          child: Center(
                            child: Text('اضافه ',
                                style: TextStyle(
                                    fontFamily: 'Arbf',
                                    color: Colors.white,
                                    fontSize: 18)),
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
                              borderRadius: BorderRadius.circular(5.0))))
            ]),
          )),
    );
  }
}
