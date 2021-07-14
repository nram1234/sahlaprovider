
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
class Add_Category extends StatefulWidget {
  BuildContext mycontext;
  @override
  _Add_CategoryState createState() => _Add_CategoryState();

  Add_Category(this.mycontext);
}

class _Add_CategoryState extends State<Add_Category> {
  File _image;
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String base64Image;
bool adddata=false;
  String thename, theenname;
  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer:Mydrawer(),// mydrawer(context),
          appBar: AppBar(actions: [GestureDetector(
            onTap: () {
              Navigator.pop(context, false);
            }, child: Icon(Icons.arrow_forward_outlined),)
          ],
            centerTitle: true,
            title: Text('اضافة قسم جديد',
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
                  Text('اضافه صوره للقسم',
                      style: TextStyle(
                          fontFamily: 'Arbf',
                          color: hexToColor('#00abeb'),
                          fontSize: 20)),
                  GestureDetector(
                    onTap: () async {
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.gallery,
                          maxHeight: 200,
                          maxWidth: 200,
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
              TextFormField(keyboardType: TextInputType.text,

                onChanged: (s) {
                  thename=s;             },
                textAlign: TextAlign.right,maxLines: null,
                style:   TextStyle(
                  fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                decoration: InputDecoration(
                  labelText: 'اسم القسم',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'اسم القسم',

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
                 theenname=s;
                },
                textAlign: TextAlign.right,maxLines: null,
                style:   TextStyle(
                  fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                decoration: InputDecoration(
                  labelText: 'Category name',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Category name',

                  hintStyle:
                  TextStyle(
                    fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                ),
              )
              ,
              SizedBox(
                height: high * .02,
              ),

              adddata?CircularProgressIndicator() :  GestureDetector(
                  onTap:   () async {
                    adddata=true;
                    setState(() {

                    });
                    String token = box.read('token');
                    // final bytes =
                    // await File(_image.path).readAsBytesSync();
                    // //  base64Image = base64Encode(bytes.readAsBytesSync());
                    // base64Image = await base64.encode(bytes);
                    // print(base64Image);

                    _allNetworking.add_category(
                        token_id: token,
                        title:  thename ,
                        title_en:   theenname  ,

                        file: _image ).then((value){

                      Navigator.pop(widget.mycontext);

print(value.data);
adddata=false;
setState(() {

});       });
                  }
,
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
                      borderRadius: BorderRadius.circular(5.0)))     )
            ]),
          )),
    );
  }
  Future<Null> _cropImage(image) async {
    print('pppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp');
    File croppedFile =
    await ImageCropper.cropImage(
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
        )
    );
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {

      });
    }
  }
}
