import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahlaprovider/bloc/datavalidatorAddOffer.dart';
import 'package:sahlaprovider/myWidget/inputTextWidget.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';

class AddNewProdect extends StatefulWidget {
  @override
  _AddNewProdectState createState() => _AddNewProdectState();
}

class _AddNewProdectState extends State<AddNewProdect> {
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
  String base64Image;
  bool savedata = false;

  @override
  void dispose() {
    v.despoos();
    super.dispose();
  }

  String thename, theenname, theoldprice, theardes, theendes, thenewprice;

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: mydrawer(context),
          appBar: AppBar(
            centerTitle: true,
            title: Text('اضافة منتج جديد',
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
                    Text('اضافه صوره للمنتج',
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
                          if (image != null) {
                            _image = File(image.path);
                          }
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
                inputText(textedet: _textEditingControllerthename,
                    inputtype: TextInputType.text,
                    changedata: (st) {
                      v.changeName(st);
                      thename = st;
                    },
                    stram: v.nameoffer,
                    hint: 'اسم المنتج'),
                SizedBox(
                  height: high * .02,
                ),
                inputText(textedet: _textEditingControllertheenname,
                    inputtype: TextInputType.text,
                    changedata: (st) {
                      v.changeenname(st);
                      theenname = st;
                    },
                    stram: v.ennameoffer,
                    hint: 'Product name'),
                SizedBox(
                  height: high * .02,
                ),
                inputText(textedet: _textEditingControllertheardes,
                    inputtype: TextInputType.multiline,
                    changedata: (st) {
                      v.changeardes(st);
                      theardes = st;
                    },
                    stram: v.ardesoffer,
                    hint: 'ﻭﺻﻒ ﺍﻟﻤﻨﺘﺞ'),
                SizedBox(
                  height: high * .02,
                ),
                inputText(textedet: _textEditingControllertheendes,
                    inputtype: TextInputType.multiline,
                    changedata: (st) {
                      v.changeendes(st);
                      theendes = st;
                    },
                    stram: v.endesoffer,
                    hint: 'Details'),
                SizedBox(
                  height: high * .02,
                ),
                // TextFormField(controller: _textEditingControllertheoldprice,
                //   keyboardType: TextInputType.number,
                //   onChanged: (s) {
                //     theoldprice = s;
                //   },
                //   textAlign: TextAlign.center,
                //   maxLines: null,
                //   style: TextStyle(
                //     fontFamily: 'Arbf',
                //     color: hexToColor('#ed1c6f'),
                //   ),
                //   decoration: InputDecoration(
                //     labelText: 'ﺍﻟﺴﻌﺮ القديم',
                //     enabledBorder: OutlineInputBorder(
                //       borderSide:
                //           BorderSide(color: hexToColor('#00abeb'), width: 2),
                //       borderRadius: BorderRadius.circular(40.0),
                //     ),
                //     border: OutlineInputBorder(
                //       borderSide:
                //           BorderSide(color: hexToColor('#00abeb'), width: 2),
                //       borderRadius: BorderRadius.circular(40.0),
                //     ),
                //     hintText: 'ﺍﻟﺴﻌﺮاالقديم',
                //     hintStyle: TextStyle(
                //       fontFamily: 'Arbf',
                //       color: hexToColor('#ed1c6f'),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: high * .02,
                ),
                TextFormField(controller: _textEditingControllerthenewprice,
                  keyboardType: TextInputType.number,
                  onChanged: (s) {
                    thenewprice = s;
                  },
                  textAlign: TextAlign.center,
                  maxLines: null,
                  style: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                  decoration: InputDecoration(
                    labelText: 'ﺍﻟﺴﻌﺮ',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color:Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'ﺍﻟﺴﻌﺮ',
                    hintStyle: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                  ),
                ),
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
                        stream: v.validationaddnewprodectoffer,
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

                                    _allNetworking
                                        .add_product(
                                            phone: phone,
                                            token_id: token,
                                            title: thename,
                                            title_en: theenname,
                                            current_price: thenewprice,
                                            old_price: "",//theoldprice,
                                            description_ar: theardes,
                                            description_en: theendes,
                                            file: _image)
                                        .then((value) {
                                      print(value.data);
                                      Get.dialog(
                                        AlertDialog(
                                          title: Text(''),
                                          content: Text("تم اضافة المنتج"),
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

                                      _image=null;
                                      _textEditingControllerthename.clear();

                                      _textEditingControllertheenname .clear();
                                      _textEditingControllertheoldprice.clear();
                                      _textEditingControllertheardes.clear();
                                      _textEditingControllertheendes.clear();
                                      _textEditingControllerthenewprice.clear();

                                      print(
                                          'ppppppppppppppppppppppppppppppppppppppppppp');
                                      savedata = false;

                                      setState(() {});
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
                                      borderRadius: BorderRadius.circular(40.0))
                                  : BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.circular(40.0)),
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
