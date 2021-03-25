import 'package:sahlaprovider/myWidget/listQrClientWidget.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_user_coupons_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class QRClient extends StatefulWidget {
  @override
  _QRClientState createState() => _QRClientState();
}

class _QRClientState extends State<QRClient> {
  AllNetworking _allNetworking = AllNetworking();
  int sizelist = 0;
  int limit = 1000;
  final box = GetStorage();
  String f = "";
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: Mydrawer(),// mydrawer(context),
        appBar: AppBar(actions: [GestureDetector(
          onTap: () {
            Navigator.pop(context, false);
          }, child: Icon(Icons.arrow_forward_outlined),)
        ],
          centerTitle: true,
          title: Text('qrclient'.tr,
              style: TextStyle(
                  fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
        ),
        body: StreamBuilder<Get_all_user_coupons_json>(
            stream: _allNetworking
                .get_all_user_coupons(
                    token_id: box.read('token'), limit: limit, page_number: 0)
                .asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<AllVisitoe> dat = snapshot.data.result.allVisitoe;
                List<AllVisitoe> data = [];
                dat.forEach((element) {
                  if (element.userPhone.contains(f)) {
                    data.add(element);
                  }
                });

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                      onChanged: (v) {
                                        f = v;
                                        setState(() {});
                                      },
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: 'البحث برقم التلفون',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Arbf',
                                          color: hexToColor('#ed1c6f'),
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount:  f.trim().isEmpty
                              ?snapshot.data.result.allVisitoe.length:data.length,
                          controller: _scrollController,
                          itemBuilder: (context, pos) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: Card(
                                elevation: 8,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        f.trim().isEmpty
                                            ? 'اسم العميل : ${snapshot.data.result.allVisitoe[pos].userName}'
                                            : 'اسم العميل : ${data[pos].userName}',
                                        style: TextStyle(
                                            fontFamily: 'Arbf',
                                            color: Colors.black,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        f.trim().isEmpty
                                            ? 'رقم التلفون : ${snapshot.data.result.allVisitoe[pos].userPhone}'
                                            : 'رقم التلفون : ${data[pos].userPhone}',
                                        style: TextStyle(
                                            fontFamily: 'Arbf',
                                            color: Colors.black,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        f.trim().isEmpty
                                            ?  'كود الخصم : ${snapshot.data.result.allVisitoe[pos].serviceCoupon}': 'كود الخصم : ${data[pos].serviceCoupon}',
                                        style: TextStyle(
                                            fontFamily: 'Arbf',
                                            color: Colors.black,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        f.trim().isEmpty
                                            ?  'تاريخ الاستخدام : ${snapshot.data.result.allVisitoe[pos].date}':'تاريخ الاستخدام : ${data[pos].date}',
                                        style: TextStyle(
                                            fontFamily: 'Arbf',
                                            color: Colors.black,
                                            fontSize: 18),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomLeft,
                                          child: GestureDetector(
                                              onTap: () {
                                                _allNetworking
                                                    .delete_user_coupon(
                                                        token_id:
                                                            box.read('token'),
                                                        coupon_id:  f.trim().isEmpty
                                                            ? snapshot
                                                            .data
                                                            .result
                                                            .allVisitoe[pos]
                                                            .visitorId:data[pos]
                                                            .visitorId)
                                                    .then((value) {
                                                  setState(() {});
                                                });
                                              },
                                              child: Icon(Icons.delete)))
                                    ],
                                  ),
                                ),
                              ),
                            );

                            //
                            // listQRclient(
                            //   data: snapshot.data.result.allVisitoe[pos],
                            //   high: high,
                            //   fun: () {
                            //
                            //   });
                          }),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (sizelist > 50) {
        limit = limit + 20;
        setState(() {});
        // getallp(
        //     limit: limit.toString().toString(),
        //     page_number: 0.toString(),
        //     token_id: token,
        //     phone: phone);
      }
    }
  }
}
