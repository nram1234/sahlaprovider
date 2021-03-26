import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahlaprovider/bloc/datavalidatorAddOffer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_edit_offer_JSON.dart';

class EditOffer extends StatefulWidget {
  String token;
  int offid;

  EditOffer({this.offid, this.token});

  @override
  _EditOfferState createState() => _EditOfferState();
}

class _EditOfferState extends State<EditOffer> {
  datavalidatorAddOffer v = datavalidatorAddOffer();
  AllNetworking _allNetworking = AllNetworking();
  DateTime startpickDate;
  DateTime startpick;
  DateTime endpick;
  DateTime endpickDate;
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

  @override
  void initState() {
    super.initState();
    startpickDate = DateTime.now();
    endpickDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(actions: [GestureDetector(
            onTap: () {
              Navigator.pop(context, false);
            }, child: Icon(Icons.arrow_forward_outlined),)
          ],
            centerTitle: true,
            title: Text('تعديل العرض ',
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: StreamBuilder<Preparation_edit_offer_JSON>(
              stream: _allNetworking
                  .preparation_edit_details(
                      token_id: widget.token, offer_id: widget.offid)
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  pronamear.text =
                      snapshot.data.result.offerDetails[0].offersName;
                  pronameen.text =
                      snapshot.data.result.offerDetails[0].offerNameEn;
                  detailsar.text =
                      snapshot.data.result.offerDetails[0].offersDescription;
                  detailsen.text =
                      snapshot.data.result.offerDetails[0].descriptionEn;
                  theoldprice.text =
                      snapshot.data.result.offerDetails[0].oldPrice;
                  thenewprice.text =
                      snapshot.data.result.offerDetails[0].newPrice ?? ' ';

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
                                        snapshot.data.result.offerDetails[0]
                                            .offersImage,
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
                            labelText: 'اسم المنتج',
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
                            labelText: 'Product name',
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
                          controller: detailsar,
                          onChanged: (s) {},
                          textAlign: TextAlign.right,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'ﻭﺻﻒ العرض',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:Colors.grey, width: 2),
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
                          textAlign: TextAlign.right,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Details',
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
                          controller: theoldprice,
                          keyboardType: TextInputType.number,
                          onChanged: (s) {},
                          textAlign: TextAlign.right,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'ﺍﻟﺴﻌﺮالقديم',
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
                          controller: thenewprice,
                          keyboardType: TextInputType.number,
                          onChanged: (s) {},
                          textAlign: TextAlign.right,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'ﺍﻟﺴﻌﺮ الجديد',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:Colors.grey, width: 2),
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
                        GestureDetector(
                            onTap: () async {
                              startpick = await showDatePicker(
                                  context: context,
                                  initialDate: startpickDate,
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(DateTime.now().year + 1));
                              if (startpick != null) {
                                startpickDate = startpick;
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * .08,
                              width: MediaQuery.of(context).size.width * .9,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Text(startpick == null
                                    ?"تاريخ البدء ${ snapshot
                                    .data.result.offerDetails[0].startDate}"
                                    : "تاريخ البدء: ${startpickDate.year},${startpickDate.month},${startpickDate.day}"),
                              ),
                            )),
                        SizedBox(
                          height: high * .02,
                        ),
                        GestureDetector(
                            onTap: () async {
                              endpick = await showDatePicker(
                                  context: context,
                                  initialDate: endpickDate,
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(DateTime.now().year + 1));
                              if (endpick != null) {
                                endpickDate = endpick;
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * .08,
                              width: MediaQuery.of(context).size.width * .9,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Text(endpick == null
                                    ? "تاريخ انتهاء ${snapshot
                                    .data.result.offerDetails[0].endDate}"
                                    : "تاريخ الانتهاء: ${endpickDate.year},${endpickDate.month},${endpickDate.day}"),
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
                            : GestureDetector(
                                onTap: () {
                                  print('0000000000000000000000000000000');
                                  savedata = true;
                                  setState(() {});
                                  String token = box.read('token');

                                  String end_date;
                                  if (endpick != null) {
                                    end_date = endpickDate.year.toString() +
                                        "-" +
                                        endpickDate.month.toString() +
                                        "-" +
                                        endpickDate.day.toString();
                                  }

                                  String start_date;
                                  if (startpick != null) {
                                    start_date = startpickDate.year.toString() +
                                        "-" +
                                        startpickDate.month.toString() +
                                        "-" +
                                        startpickDate.day.toString();
                                  }
print(start_date);
                                  print(end_date);
                                  print('6666666666666666666666666666666666666666666666');
                                  _allNetworking
                                      .edit_offer(
                                          start_date: start_date == null
                                              ? snapshot.data.result
                                                  .offerDetails[0].startDate
                                              : start_date,
                                          end_date: end_date == null
                                              ? snapshot.data.result
                                                  .offerDetails[0].endDate
                                              : end_date,
                                          token_id: token,
                                          title: pronamear.text,
                                          id_product: widget.offid,
                                          title_en: pronameen.text,
                                          current_price: thenewprice.text,
                                          old_price: theoldprice.text,
                                          description_ar: detailsar.text,
                                          description_en: detailsen.text,
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
                                        content: Text("تم تعديل العرض"),
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
                                    );   });
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
