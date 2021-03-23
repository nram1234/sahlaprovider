import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/jsondata/buy_prescription_request_json.dart';

class Buy_prescription_request extends StatefulWidget {
  @override
  _Buy_prescription_requestState createState() =>
      _Buy_prescription_requestState();
}

class _Buy_prescription_requestState extends State<Buy_prescription_request> {
  final box = GetStorage();
  AllNetworking _allNetworking = AllNetworking();
  String token;
  String price = '';
  String message = '';

  @override
  void initState() {
    token = box.read('token');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(appBar: AppBar( centerTitle: true,title: Text('طلبات شراء روشتة'),actions: [GestureDetector(
      onTap: () {
        Navigator.pop(context, false);
      }, child: Icon(Icons.arrow_forward_outlined),)
    ],),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<Buy_prescription_request_json>(
                stream: _allNetworking
                    .buy_prescription_request(token_id: token)
                    .asStream(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    print("snapshot.data.result.allRequested");
                    print(snapshot.data.result.allRequested);
                    print("snapshot.data.result.allRequested");
                    return ListView.builder(
                        itemCount: snapshot.data.result.allRequested.length,
                        itemBuilder: (context, pos) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: snapshot.data.result
                                                .allRequested[pos].view ==
                                            "0"
                                        ? Colors.red
                                        : Colors.grey),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        5.0) //         <--- border radius here
                                    ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'تاريخ ارسال :${snapshot.data.result.allRequested[pos].creationDate}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 2),
                                          height: size.height * .3,
                                          width: size.width * .4,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    5.0) //         <--- border radius here
                                                ),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${snapshot.data.result.allRequested[pos].userName}'),
                                                  Text(
                                                      '${snapshot.data.result.allRequested[pos].userPhone}'),
                                                  Text(snapshot
                                                          .data
                                                          .result
                                                          .allRequested[pos]
                                                          .currentPrice
                                                          .trim()
                                                          .isEmpty
                                                      ? ""
                                                      : 'السعر :${snapshot.data.result.allRequested[pos].currentPrice}'),
                                                  Text(
                                                      '${snapshot.data.result.allRequested[pos].description}'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  new CupertinoAlertDialog(
                                                    // title: new Text(""),
                                                    content: Container(
                                                      // height: size.height * .8,
                                                      // width: size.width * .9,
                                                      color: Colors.white,
                                                      child: PhotoView(
                                                        imageProvider:
                                                            NetworkImage(snapshot
                                                                .data
                                                                .result
                                                                .allRequested[
                                                                    pos]
                                                                .pharmacyImage),
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('غلق'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    5.0) //         <--- border radius here
                                                ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              snapshot
                                                  .data
                                                  .result
                                                  .allRequested[pos]
                                                  .pharmacyImage,
                                              height: size.height * .3,
                                              width: size.width * .4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [

                                        snapshot.data.result.allRequested[pos]
                                                .descriptionDec
                                                .trim()
                                                .isEmpty
                                            ? SizedBox()
                                            : GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          new CupertinoAlertDialog(
                                                            // title: new Text(""),
                                                            content: Container(
                                                              color:
                                                                  Colors.white,
                                                              child: Text(snapshot
                                                                  .data
                                                                  .result
                                                                  .allRequested[
                                                                      pos]
                                                                  .descriptionDec),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                  'غلق',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              )
                                                            ],
                                                          ));
                                                },
                                                child: Text(
                                                  'مشاهدة رد الصيدلي',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                        GestureDetector(
                                            onTap: () {
                                              _allNetworking
                                                  .delete_pharamices_image(
                                                      token_id: token,
                                                      id_request: snapshot
                                                          .data
                                                          .result
                                                          .allRequested[pos]
                                                          .id)
                                                  .then((value) {
                                                setState(() {});
                                                Get.snackbar('', value.message);
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 30,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}
