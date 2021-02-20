import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:photo_view/photo_view.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/jsondata/pharmacies_image_json.dart';

class Pharmacy extends StatefulWidget {
  @override
  _PharmacyState createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
  final box = GetStorage();
  AllNetworking _allNetworking = AllNetworking();
  String token;

  @override
  void initState() {
    token = box.read('token');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<Pharmacies_image_json>(
                stream:
                    _allNetworking.pharmacies_image(token_id: token).asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.result.allRequested.length,
                        itemBuilder: (context, pos) {
                          return Card(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            new CupertinoAlertDialog(
                                              // title: new Text(""),
                                              content: Container(
                                                height: size.height * .8,
                                                width: size.width * .9,
                                                color: Colors.white,
                                                child: PhotoView(
                                                  imageProvider: NetworkImage(
                                                      snapshot
                                                          .data
                                                          .result
                                                          .allRequested[pos]
                                                          .pharmacyImage),
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('غلق'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            ));
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data.result.allRequested[pos]
                                            .pharmacyImage,
                                        height: 100,
                                        width: 100,
                                      )),
                                ),
                                Expanded(child: SizedBox()),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data.result
                                          .allRequested[pos].userName),
                                      Text(
                                          'التلفون :${snapshot.data.result.allRequested[pos].userPhone}'),
                                      Text(
                                          'الوصف :${snapshot.data.result.allRequested[pos].description}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
