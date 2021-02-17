import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahlaprovider/bloc/datavalidatorAddOffer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_addproduct_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_edit_product_JSON.dart';

class EditProduct extends StatefulWidget {
  String token;
  int proid;

  EditProduct({this.proid, this.token});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  datavalidatorAddOffer v = datavalidatorAddOffer();
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  TextEditingController pronamear = TextEditingController();
  TextEditingController pronameen = TextEditingController();
  TextEditingController detailsar = TextEditingController();
  TextEditingController detailsen = TextEditingController();
  TextEditingController theoldprice = TextEditingController();
  TextEditingController thenewprice = TextEditingController();
  File _image;
  bool savedata = false;
  @override
  void dispose() {
    v.despoos();
    super.dispose();
  }
  String service_type = '0';
  String token;
  CategoryList _categoryList;
  List<CategoryList>categoryList = [];
  bool getcategoryList=true;
  @override
  void initState() {token = box.read('token');
  service_type = box.read('service_type');
  _allNetworking.preparation_addproduct(token_id: token).then((value){
    for(int i=0;i<value.result.categoryList.length;i++){

      categoryList.add( value.result.categoryList[i]);
    }

    getcategoryList=false;
    setState(() {

    });

  });
  }


  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('تعديل منتج ',
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: StreamBuilder<Preparation_edit_product_JSON>(
              stream: _allNetworking
                  .preparation_edit_product(
                      token_id: widget.token, product_id: widget.proid)
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  pronamear.text =
                      snapshot.data.result.allProducts[0].productName;
                  pronameen.text =
                      snapshot.data.result.allProducts[0].productNameEn;
                  detailsar.text =
                      snapshot.data.result.allProducts[0].productDescription;
                  detailsen.text =
                      snapshot.data.result.allProducts[0].productDescriptionEn;
                  theoldprice.text =
                      snapshot.data.result.allProducts[0].oldPrice;
                  thenewprice.text =
                      snapshot.data.result.allProducts[0].newPrice ?? ' ';

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
                            Text('اضافه صوره للمنتج',
                                style: TextStyle(
                                    fontFamily: 'Arbf',
                                    color: hexToColor('#00abeb'),
                                    fontSize: 20)),
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
                                        snapshot.data.result.allProducts[0]
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
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'اسم المنتج',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 2),
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
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Product name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 2),
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
                          controller: detailsar,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'ﻭﺻﻒ ﺍﻟﻤﻨﺘﺞ',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 2),
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
                          controller: detailsen,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Details',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 2),
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
                        // TextFormField(
                        //   controller: theoldprice,
                        //   onChanged: (s) {},
                        //   textAlign: TextAlign.center,
                        //   maxLines: null,
                        //   style: TextStyle(
                        //     fontFamily: 'Arbf',
                        //     color: hexToColor('#ed1c6f'),
                        //   ),
                        //   decoration: InputDecoration(
                        //     labelText: 'ﺍﻟﺴﻌﺮالقديم',
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: hexToColor('#00abeb'), width: 2),
                        //       borderRadius: BorderRadius.circular(5.0),
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: hexToColor('#00abeb'), width: 2),
                        //       borderRadius: BorderRadius.circular(5.0),
                        //     ),
                        //     hintStyle: TextStyle(
                        //       fontFamily: 'Arbf',
                        //       color: hexToColor('#ed1c6f'),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: high * .02,
                        ),
                        TextFormField(
                          controller: thenewprice,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'ﺍﻟﺴﻌﺮ',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 2),
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
                        service_type == '0'
                            ? SizedBox()
                            :getcategoryList?CircularProgressIndicator(): Container(
                          decoration: BoxDecoration(
                            border: Border.all( color: Colors.red ),
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
                            : GestureDetector(
                                onTap: () {
                                  print('0000000000000000000000000000000');
                                  savedata = true;
                                  setState(() {
                                    
                                  });
                                  String token = box.read('token');
                                  _allNetworking
                                      .edit_product(
                                          token_id: token,
                                          title: pronamear.text,
                                          id_product: widget.proid,
                                          title_en: pronameen.text,
                                          current_price: thenewprice.text,
                                          old_price:'',// theoldprice.text,
                                          description_ar: detailsar.text,
                                          description_en: detailsen.text,cat_id: _categoryList.categoryId ,
                                          file: _image)
                                      .then((value) {
                                    print(value.data);
                                    print(
                                        'ppppppppppppppppppppppppppppppppppppppppppp');
                                    savedata = false;
                                    setState(() {});
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
                                    );});
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
