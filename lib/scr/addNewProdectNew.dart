 
import 'dart:io';


import 'package:flutter/material.dart';
 
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahlaprovider/bloc/datavalidatorAddOffer.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';

class AddNewProdectNEW extends StatefulWidget {
  @override
  _AddNewProdectNEWState createState() => _AddNewProdectNEWState();
}

class _AddNewProdectNEWState extends State<AddNewProdectNEW> {
  datavalidatorAddOffer v = datavalidatorAddOffer();
  File _image;
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String base64Image;

  @override
  void dispose() {
    v.despoos();
    super.dispose();
  }
  String thename, theenname, theoldprice, theardes, theendes,thenewprice;
  @override
  Widget build(BuildContext context) {
    var high = MediaQuery
        .of(context)
        .size
        .height;
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: mydrawer(context),
          appBar: AppBar(actions: [GestureDetector(
            onTap: () {
              Navigator.pop(context, false);
            }, child: Icon(Icons.arrow_forward_outlined),)
          ]
            ,
            centerTitle: true,
            title: Text('اضافة منتج جديد',
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
            child: ListView(children: [
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
                          maxHeight: 200,
                          maxWidth: 200,
                          imageQuality: 100);
                      setState(() {
                        _image = File(image.path);
                      });
                    },
                    child: _image == null
                        ? CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blueAccent,
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
              TextFormField(keyboardType: TextInputType.text,

                onChanged: (s) {

                },
                textAlign: TextAlign.center,maxLines: null,
                style:   TextStyle(
                  fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                decoration: InputDecoration(
                  labelText: 'اسم المنتج',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'اسم المنتج',

                  hintStyle:
                  TextStyle(
                    fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                ),
              ),
              SizedBox(
                height: high * .02,
              ),
              TextFormField(keyboardType: TextInputType.text,

                onChanged: (s) {

                },
                textAlign: TextAlign.center,maxLines: null,
                style:   TextStyle(
                  fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                decoration: InputDecoration(
                  labelText: 'Product name',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Product name',

                  hintStyle:
                  TextStyle(
                    fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                ),
              )
                ,
              SizedBox(
                height: high * .02,
              ),
              TextFormField(keyboardType: TextInputType.text,

                onChanged: (s) {

                },
                textAlign: TextAlign.center,maxLines: null,
                style:   TextStyle(
                  fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                decoration: InputDecoration(
                  labelText:'ﻭﺻﻒ ﺍﻟﻤﻨﺘﺞ',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText:'ﻭﺻﻒ ﺍﻟﻤﻨﺘﺞ',

                  hintStyle:
                  TextStyle(
                    fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                ),
              )
                  ,
              SizedBox(
                height: high * .02,
              ),
              TextFormField(keyboardType: TextInputType.text,

                onChanged: (s) {

                },
                textAlign: TextAlign.center,maxLines: null,
                style:   TextStyle(
                  fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                decoration: InputDecoration(
                  labelText:'Details',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText:'Details',

                  hintStyle:
                  TextStyle(
                    fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                ),
              )
                 ,
              SizedBox(
                height: high * .02,
              ),
              TextFormField(keyboardType: TextInputType.text,

                onChanged: (s) {

                },
                textAlign: TextAlign.center,maxLines: null,
                style:   TextStyle(
                  fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                decoration: InputDecoration(
                  labelText:'ﺍﻟﺴﻌﺮالقديم',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText:'ﺍﻟﺴﻌﺮالقديم',

                  hintStyle:
                  TextStyle(
                    fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                ),
              )
                 , SizedBox(
                height: high * .02,
              ),
              TextFormField(keyboardType: TextInputType.text,

                onChanged: (s) {

                },
                textAlign: TextAlign.center,maxLines: null,
                style:   TextStyle(
                  fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                decoration: InputDecoration(
                  labelText:'ﺍﻟﺴﻌﺮ الجديد',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText:'ﺍﻟﺴﻌﺮالجديد',

                  hintStyle:
                  TextStyle(
                    fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                ),
              )
            ,  SizedBox(
                height: high * .02,
              ),
              GestureDetector(
                onTap:   () async {


                  print ( thename+ theenname+ theoldprice+ theardes+ theendes);
                  String phone = box.read('phone');
                  String token = box.read('token');
                  // final bytes =
                  // await File(_image.path).readAsBytesSync();
                  // //  base64Image = base64Encode(bytes.readAsBytesSync());
                  // base64Image = await base64.encode(bytes);
                  // print(base64Image);

                  _allNetworking.add_product(phone: phone,
                      token_id: token,
                      title:  thename ,
                      title_en:   theenname  ,
                      current_price:       thenewprice,
                      old_price:theoldprice,
                      description_ar:   theardes  ,
                      description_en: theendes    ,
                      file: _image ).then((value){

                  });
                }

              )
            ]),
          )),
    );
  }
}
