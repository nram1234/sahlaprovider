import 'dart:io';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahlaprovider/bloc/datavalidatorAddOffer.dart';
import 'package:sahlaprovider/myWidget/inputTextWidget.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';

class AddOffer extends StatefulWidget {
  BuildContext mycontext;

  AddOffer(this.mycontext);
  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  datavalidatorAddOffer v = datavalidatorAddOffer();
  TextEditingController _textEditingControllerthename=TextEditingController();
  TextEditingController _textEditingControllertheenname=TextEditingController();
  TextEditingController _textEditingControllertheoldprice=TextEditingController();
  TextEditingController _textEditingControllertheardes=TextEditingController();
  TextEditingController _textEditingControllertheendes=TextEditingController();
  TextEditingController _textEditingControllerthenewprice=TextEditingController();
  File _image;
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String thename, theenname, theoldprice, theardes, theendes, thenewprice;
  bool savedata = false;
  DateTime startpickDate;
  DateTime endpickDate;

  @override
  void dispose() {
    v.despoos();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startpickDate = DateTime.now();
    endpickDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: Mydrawer(),// mydrawer(context),
          appBar: AppBar(   actions: [GestureDetector(
            onTap: () {
              Navigator.pop(context, false);
            }, child: Icon(Icons.arrow_forward_outlined),)
          ],
            centerTitle: true,
            title: Text('addoffer'.tr,
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: high * .1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('اضافه صوره للعرض',
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#00abeb'),
                            fontSize: 20)),
                    GestureDetector(
                      onTap: () async {
                        var image = await ImagePicker.platform.pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 1000,
                            maxWidth: 1000,
                            imageQuality: 100);
                        setState(() {
                          _image = File(image.path);
                        });
                      },
                      child: _image == null
                          ? CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.red,
                      )
                          : CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(_image),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: high * .02,
                ),
                inputText(
                    inputtype: TextInputType.text,textedet: _textEditingControllerthename,
                    changedata: (st) {
                      v.changeName(st);
                      thename = st;
                    },
                    stram: v.nameoffer,
                    hint: 'اسم العرض'),
                SizedBox(
                  height: high * .02,
                ),
                inputText(
                    inputtype: TextInputType.text,textedet: _textEditingControllertheenname,
                    changedata: (st) {
                      v.changeenname(st);
                      theenname = st;
                    },
                    stram: v.ennameoffer,
                    hint: 'offer name'),
                SizedBox(
                  height: high * .02,
                ),
                inputText(
                    inputtype: TextInputType.multiline,textedet: _textEditingControllertheardes,
                    changedata: (st) {
                      v.changeardes(st);
                      theardes = st;
                    },
                    stram: v.ardesoffer,
                    hint: 'ﻭﺻﻒ العرض'),
                SizedBox(
                  height: high * .02,
                ),
                inputText(
                    inputtype: TextInputType.multiline,textedet: _textEditingControllertheendes,
                    changedata: (st) {
                      v.changeendes(st);
                      theendes = st;
                    },
                    stram: v.endesoffer,
                    hint: 'Details'),
                SizedBox(
                  height: high * .02,
                ),     TextFormField(keyboardType: TextInputType.number,controller: _textEditingControllertheoldprice,

                  onChanged: (s) {
                    theoldprice = s;
                  },
                  textAlign: TextAlign.right,maxLines: null,
                  style:   TextStyle(
                    fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                  decoration: InputDecoration(
                    labelText:'السعر قبل الخصم',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText:'السعر قبل الخصم',

                    hintStyle:
                    TextStyle(
                      fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                  ),
                )
            ,
                SizedBox(
                  height: high * .02,
                ),
                TextFormField(keyboardType: TextInputType.number,controller: _textEditingControllerthenewprice,

                  onChanged: (s) {
                    thenewprice = s;
                  },
                  textAlign: TextAlign.right,maxLines: null,
                  style:   TextStyle(
                    fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                  decoration: InputDecoration(
                    labelText:'السعر بعد الخصم',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText:'السعر بعد الخصم',

                    hintStyle:
                    TextStyle(
                      fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                  ),
                )   ,
                SizedBox(
                  height: high * .02,
                ),
                GestureDetector(
                    onTap: () async {
                      DateTime date = await showDatePicker(
                          context: context,
                          initialDate: startpickDate,

                          firstDate: DateTime(DateTime
                              .now()
                              .year),
                          lastDate: DateTime(DateTime
                              .now()
                              .year + 1));
                      if (date != null) {
                        startpickDate = date;
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .08, width: MediaQuery
                        .of(context)
                        .size
                        .width * .9, decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                      child: Center(
                        child: Text(
                            "تاريخ البدء: ${startpickDate.year},${startpickDate
                                .month},${startpickDate.day}"),
                      ),

                    )),
                SizedBox(
                  height: high * .02,
                ), GestureDetector(
                    onTap: () async {
                      DateTime date = await showDatePicker(
                          context: context,
                          initialDate: endpickDate,
                          firstDate: DateTime(DateTime
                              .now()
                              .year),
                          lastDate: DateTime(DateTime
                              .now()
                              .year + 1));
                      if (date != null) {
                        endpickDate = date;
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .08, width: MediaQuery
                        .of(context)
                        .size
                        .width * .9, decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                      child: Center(
                        child: Text(
                            "تاريخ الانتهاء: ${endpickDate.year},${endpickDate
                                .month},${endpickDate.day}"),
                      ),

                    )),
                SizedBox(
                  height: high * .02,
                ),
                savedata
                    ? Container(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                )
                    : StreamBuilder(
                  stream: v.validationUserDataoffer,
                  builder: (context, data) {
                    return GestureDetector(
                      onTap: data.data != null
                          ? () async {
                        savedata = true;
                        setState(() {});

                        String phone = box.read('phone');
                        String token = box.read('token');
                        // final bytes =
                        // await File(_image.path).readAsBytesSync();
                        // //  base64Image = base64Encode(bytes.readAsBytesSync());
                        // base64Image = await base64.encode(bytes);
                        // print(base64Image);
                        String end_date = endpickDate.year.toString() +"-"+
                            endpickDate.month.toString() +"-"+
                            endpickDate.day.toString();
                        String start_date = startpickDate.year.toString() +"-"+
                            startpickDate.month.toString() +"-"+
                            startpickDate.day.toString();
print(end_date);
                        print(start_date);
                        _allNetworking
                            .add_offer(
                            phone: phone,
                            token_id: token,
                            title: thename,
                            title_en: theenname,
                            current_price: thenewprice,
                            old_price: theoldprice,
                            description_ar: theardes,
                            description_en: theendes,
                            end_date
                            :end_date,
                            start_date
                            :start_date,
                            file: _image)
                            .then((value) {

                          Navigator.pop(widget.mycontext);
                     //      _image=null;
                     //      _textEditingControllerthename.clear();
                     //
                     //      _textEditingControllertheenname .clear();
                     //     _textEditingControllertheoldprice.clear();
                     //       _textEditingControllertheardes.clear();
                     //     _textEditingControllertheendes.clear();
                     // _textEditingControllerthenewprice.clear();
                     //
                     //
                     //
                     //
                     //
                     //      thename=''; theenname='';  theoldprice=''; theardes='';  theendes='';  thenewprice='';
                     //      print(value.data);
                     //      print(
                     //          'ppppppppppppppppppppppppppppppppppppppppppp');
                     //      savedata = false;
                     //
                     //
                     //      setState(() {});
                     //      Get.dialog(
                     //        AlertDialog(
                     //          title: Text( ''),
                     //          content: Text("تم اضافة العرض"),
                     //          actions: <Widget>[
                     //            FlatButton(
                     //              child: Text("CLOSE"),
                     //              onPressed: () {
                     //                Get.back();
                     //              },
                     //            )
                     //       ,FlatButton(
                     //              child: Text("تنفيذ"),
                     //              onPressed: () {
                     //
                     //              },
                     //            )   ],
                     //        ),
                     //        barrierDismissible: false,
                     //      );
        });
                      }
                          : null,
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
                        decoration: data.data != null
                            ? BoxDecoration(
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
                            : BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                            BorderRadius.circular(5.0)),
                      ),
                    );
                  },
                )
              ]),
            ),
          )),
    );
  }
}
