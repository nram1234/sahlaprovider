import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/jsondata/galler_jason.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final box = GetStorage();
  AllNetworking _allNetworking = AllNetworking();
  File _image;
  bool uplodpic = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('معرض الصور'),
        centerTitle: true,
      ),
      body: StreamBuilder<Get_list_gallery_json>(
          stream: _allNetworking
              .get_list_gallery(token_id: box.read('token'))
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.result.allImages.length,
                          itemBuilder: (context, pos) {
                            return Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .33,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .27,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                        snapshot.data.result.allImages[pos].img,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _allNetworking
                                            .delete_image(
                                                token_id: box.read('token'),
                                                img_id: snapshot.data.result
                                                    .allImages[pos].id)
                                            .then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Icon(Icons.delete),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                  uplodpic
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          child: Text('اضافه صوره'),
                          onPressed: () async {
                            print(snapshot.data.result.totalImg);
                            print(snapshot.data.result.allImages.length);
                            if (snapshot.data.result.totalImg >=
                                snapshot.data.result.allImages.length) {
                              var image = await ImagePicker.pickImage(
                                  source: ImageSource.gallery,
                                  maxHeight: 1000,
                                  maxWidth: 1000,
                                  imageQuality: 100);
                              _cropImage(image);
                              // setState(() {
                              //   if (image != null) {
                              //     _image = File(image.path);
                              //     uplodpic=true;
                              //   }
                              //
                              // });

                            }
                          })
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
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
      uplodpic = true;
      _allNetworking
          .add_img(token_id: box.read('token'), file: _image)
          .then((value) {
        print(value);
        setState(() {
          uplodpic = false;
        });
      });
    }
  }
}
