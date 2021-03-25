import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
class QRRead extends StatefulWidget {
  @override
  _QRReadState createState() => _QRReadState();
}

class _QRReadState extends State<QRRead> {
  final box = GetStorage();
  String barcode = 'qrcode you scan will be displayed in this area';
  Uint8List bytes = Uint8List(0);
  String _qrStringgnra = '';

  @override
  void initState() {
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      right: true,
      top: true,
      bottom: true,
      left: true,
      child: Scaffold(
        drawer:  Mydrawer(),// mydrawer(context),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: high * 0.05,
              ),
              GestureDetector(
                onTap: () async {
                  int idOfQR = await box.read('id');
                  print(
                      '0000000000000000000000000000000000000000000000000000000000000');
                  print(idOfQR);
                  _generateBarCode(33.toString());

                  // if(!_qrStringgnra.isEmpty){
                  //
                  //
                  //
                  //
                  //
                  // }else{
                  //   Get.snackbar('خطاء', 'برجاء ادخال بيانات');
                  // }
                },
                child: Container(
                    height: high * .1,
                    width: width * 0.75,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" انشاء  QR ",
                              style: TextStyle(
                                  fontFamily: 'Arbf',
                                  color: Colors.white,
                                  fontSize: 25)),
                          Icon(
                            Icons.qr_code,
                            color: Colors.white,
                          ),
                        ],
                      ),
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
                        borderRadius: BorderRadius.circular(40.0))),
              ),
              // SizedBox(
              //   height: high * 0.05,
              // ),
              // TextFormField(
              //   validator: (st) {
              //     if (st.isEmpty) {
              //       return 'Please Enter Data';
              //     }
              //     return null;
              //   },
              //   onChanged: (st) => _qrStringgnra = st,
              // ),
              SizedBox(
                height: high * 0.05,
              ),
              SizedBox(
                height: 190,
                child: bytes.isEmpty
                    ? Center(
                        child: Text('Empty code ... ',
                            style: TextStyle(color: Colors.black38)),
                      )
                    : Image.memory(bytes),
              ),
              SizedBox(
                height: high * 0.05,
              ),

              GestureDetector(
                onTap: () async {


                  // if (!bytes.isEmpty) {
                  //     print('999999999999999999999999999999');
                  //        print(bytes);
                  //   final success =
                  //       await ImageGallerySaver.saveImage(this.bytes)
                  //           .then((value) {
                  //     print(value);
                  //   });
                  // }
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
                        borderRadius: BorderRadius.circular(40.0))),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      Get.snackbar('QR', barcode);
    }
  }
  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);

  }
  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }
}
