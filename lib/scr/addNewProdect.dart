import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahlaprovider/bloc/datavalidatorAddOffer.dart';
import 'package:sahlaprovider/myWidget/inputTextWidget.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_addproduct_json.dart';

class AddNewProdect extends StatefulWidget {
  BuildContext mycontext;

  AddNewProdect(this.mycontext);

  @override
  _AddNewProdectState createState() => _AddNewProdectState();
}

class _AddNewProdectState extends State<AddNewProdect> {
  datavalidatorAddOffer v = datavalidatorAddOffer();

  TextEditingController _textEditingControllerthename = TextEditingController();
  TextEditingController _textEditingControllertheenname =
      TextEditingController();
  TextEditingController _featureName1Controller = TextEditingController();
  TextEditingController _featurePrice1Controller = TextEditingController();
  TextEditingController _featureName2Controller = TextEditingController();
  TextEditingController _featurePrice2Controller = TextEditingController();
  TextEditingController _featureName3Controller = TextEditingController();
  TextEditingController _featurePrice3Controller = TextEditingController();
  TextEditingController _textEditingControllertheoldprice =
      TextEditingController();
  TextEditingController _textEditingControllertheardes =
      TextEditingController();
  TextEditingController _textEditingControllertheendes =
      TextEditingController();
  TextEditingController _textEditingControllerthenewprice =
      TextEditingController();
  TextEditingController _textEditingControllerthesearil_number =
      TextEditingController();
  TextEditingController _textEditingControllerthestock =
      TextEditingController();

  File _image;
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String base64Image;
  bool savedata = false;
  String service_type = '0';
  String token;
  CategoryList _categoryList;
  List<CategoryList> categoryList = [];
  bool getcategoryList = true;
  @override
  void initState() {
    token = box.read('token');
    service_type = box.read('service_type');
    _allNetworking.preparation_addproduct(token_id: token).then((value) {
      for (int i = 0; i < value.result.categoryList.length; i++) {
        categoryList.add(value.result.categoryList[i]);
      }

      getcategoryList = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    v.despoos();
    super.dispose();
  }

  String thename,
      theenname,
      theoldprice,
      theardes,
      theendes,
      thenewprice,
      stock,
      searil_number;

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
                            color: hexToColor('#ed1c6f'),
                            fontSize: 20)),
                    GestureDetector(
                      onTap: () async {
                        var image = await ImagePicker.pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 1000,
                            maxWidth: 1000,
                            imageQuality: 100);
                        _cropImage(image);
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
                    textedet: _textEditingControllerthename,
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
                inputText(
                    textedet: _textEditingControllertheenname,
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
                inputText(
                    textedet: _textEditingControllertheardes,
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
                inputText(
                    textedet: _textEditingControllertheendes,
                    inputtype: TextInputType.multiline,
                    changedata: (st) {
                      v.changeendes(st);
                      theendes = st;
                    },
                    stram: v.endesoffer,
                    hint: 'التفاصيل'),
                SizedBox(
                  height: high * .02,
                ),
                TextButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("اضافة مميزات"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _featureName1Controller,
                                decoration: InputDecoration(hintText: "الميزة"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _featurePrice1Controller,
                                decoration: InputDecoration(hintText: "السعر"),
                              ),
                              Divider(
                                height: 2,
                                thickness: 2,
                                color: Colors.red,
                              ),
                              TextField(
                                controller: _featureName2Controller,
                                decoration: InputDecoration(hintText: "الميزة"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _featurePrice2Controller,
                                decoration: InputDecoration(hintText: "السعر"),
                              ),
                              Divider(
                                height: 2,
                                thickness: 2,
                                color: Colors.red,
                              ),
                              TextField(
                                controller: _featureName3Controller,
                                decoration: InputDecoration(hintText: "الميزة"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _featurePrice3Controller,
                                decoration: InputDecoration(hintText: "السعر"),
                              ),
                            ],
                          ),
                        ));
                      },
                    );
                  },
                ),
                TextFormField(
                  controller: _textEditingControllerthenewprice,
                  keyboardType: TextInputType.number,
                  onChanged: (s) {
                    thenewprice = s;
                  },
                  textAlign: TextAlign.right,
                  maxLines: null,
                  style: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                  decoration: InputDecoration(
                    labelText: 'ﺍﻟﺴﻌﺮ',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5.0),
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
                TextFormField(
                  controller: _textEditingControllerthesearil_number,
                  keyboardType: TextInputType.text,
                  onChanged: (s) {
                    searil_number = s;
                  },
                  textAlign: TextAlign.right,
                  maxLines: null,
                  style: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                  decoration: InputDecoration(
                    labelText: 'الرقم التسلسلي',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'الرقم التسلسلي',
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
                  controller: _textEditingControllerthestock,
                  keyboardType: TextInputType.number,
                  onChanged: (s) {
                    stock = s;
                  },
                  textAlign: TextAlign.right,
                  maxLines: null,
                  style: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                  decoration: InputDecoration(
                    labelText: 'المخزن',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'المخزن',
                    hintStyle: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                  ),
                ),
                SizedBox(
                  height: high * .02,
                ),
                service_type == '0'
                    ? SizedBox()
                    : getcategoryList
                        ? CircularProgressIndicator()
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      5.0) //         <--- border radius here
                                  ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('القسم'),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                DropdownButton<CategoryList>(
                                  value: _categoryList,
                                  //  hint: Text(hintcety),
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (CategoryList newValue) {
                                    setState(() {
                                      _categoryList = newValue;
                                    });
                                  },
                                  items: categoryList
                                      .map<DropdownMenuItem<CategoryList>>(
                                          (CategoryList value) {
                                    return DropdownMenuItem<CategoryList>(
                                      value: value,
                                      child: Text(value.categoryName),
                                    );
                                  }).toList(),
                                ),
                              ],
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
                                            cat_id: _categoryList == null
                                                ? ""
                                                : _categoryList.categoryId,
                                            token_id: token,
                                            title: thename,
                                            title_en: theenname,
                                            current_price: thenewprice,
                                            serial_number: searil_number,
                                            stock: stock,
                                            productNameFeature:
                                                "${_featureName1Controller.text},${_featureName2Controller.text},${_featureName3Controller.text}",
                                            productPriceFeature:
                                                "${_featurePrice1Controller.text},${_featurePrice2Controller.text},${_featurePrice3Controller.text}",
                                            old_price: "",
                                            //theoldprice,
                                            description_ar: theardes,
                                            description_en: theendes,
                                            file: _image)
                                        .then((value) {
                                      print(value.data);
                                      Navigator.pop(widget.mycontext);

                                      //   Get.dialog(
                                      //     AlertDialog(
                                      //       title: Text(''),
                                      //       content: Text("تم اضافة المنتج"),
                                      //       actions: <Widget>[
                                      //         FlatButton(
                                      //           child: Text("CLOSE"),
                                      //           onPressed: () {
                                      //             Get.back();
                                      //           },
                                      //         )
                                      //       ],
                                      //     ),
                                      //     barrierDismissible: false,
                                      //   );
                                      //
                                      //   _image = null;
                                      //   _textEditingControllerthename.clear();
                                      //
                                      //   _textEditingControllertheenname.clear();
                                      //   _textEditingControllertheoldprice.clear();
                                      //   _textEditingControllertheardes.clear();
                                      //   _textEditingControllertheendes.clear();
                                      //   _textEditingControllerthenewprice.clear();
                                      //
                                      //   print(
                                      //       'ppppppppppppppppppppppppppppppppppppppppppp');
                                      //   savedata = false;
                                      //
                                      //   setState(() {});
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
                                      borderRadius: BorderRadius.circular(5.0)),
                            ),
                          );
                        },
                      )
              ]),
            ),
          )),
    );
  }

  Future<Null> _cropImage(image) async {
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
}
