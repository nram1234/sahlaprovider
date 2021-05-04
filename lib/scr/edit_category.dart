import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_edit_category_json.dart';

class Edit_Category extends StatefulWidget {
  String token;

  String cat_id;

  Edit_Category({this.token, this.cat_id});


  @override
  _Edit_CategoryState createState() => _Edit_CategoryState();
}

class _Edit_CategoryState extends State<Edit_Category> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  TextEditingController pronamear = TextEditingController();
  TextEditingController pronameen = TextEditingController();

  File _image;
  bool savedata = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
          appBar: AppBar(
            actions: [GestureDetector(
              onTap: () {
                Navigator.pop(context, false);
              }, child: Icon(Icons.arrow_forward_outlined),)
            ],
            centerTitle: true,
            title: Text('تعديل منتج ',
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: StreamBuilder<Preparation_edit_category_json>(
              stream: _allNetworking
                  .preparation_edit_category(
                  token_id: widget.token, cat_id: widget.cat_id)
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  pronamear.text =
                      snapshot.data.result.categoryDetails[0].productName;
                  pronameen.text =
                      snapshot.data.result.categoryDetails[0].productNameEn;

                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: high * .1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('اضافه صوره للقسم',
                                style: TextStyle(
                                    fontFamily: 'Arbf',
                                    color: hexToColor('#00abeb'),
                                    fontSize: 20)),
                            InkWell(
                              onTap: () async {
                                var image = await ImagePicker
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
                                  snapshot.data.result.categoryDetails[0]
                                      .productImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: high * .02,
                        ),
                        TextFormField(
                          controller: pronamear,
                          onChanged: (s) {},
                          textAlign: TextAlign.right,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'اسم القسم',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
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
                          controller: pronameen,
                          onChanged: (s) {},
                          textAlign: TextAlign.right,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Category name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
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
                            : GestureDetector(
                          onTap: () {
                            print('0000000000000000000000000000000');
                            savedata = true;
                            setState(() {

                            });
                            String token = box.read('token');
                            _allNetworking
                                .edit_category(
                                token_id: token,
                                title: pronamear.text,
                                cat_id: widget.cat_id,
                                title_en: pronamear.text,
                                file: _image)
                                .then((value) {
                              print(value.data);
                              print(
                                  'ppppppppppppppppppppppppppppppppppppppppppp');
                              savedata = false;
                              setState(() {});
                              Get.dialog(
                                AlertDialog(
                                  title: Text(''),
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
                        )
                      ]),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
