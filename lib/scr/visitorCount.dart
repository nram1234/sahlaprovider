import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/myWidget/customDialog.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_visitor_json.dart';
import 'package:flutter/material.dart';

class VisitorCount extends StatefulWidget {
  String token_id;

  VisitorCount(this.token_id);

  @override
  _VisitorCountState createState() => _VisitorCountState();
}

class _VisitorCountState extends State<VisitorCount> {
  AllNetworking _allNetworking = AllNetworking();
  int sizelist = 0;
  int limit = 1000;
  String f = "";
  ScrollController _scrollController;
  TextEditingController addres = TextEditingController();
  TextEditingController contant = TextEditingController();
  final box = GetStorage();
  String token;
  @override
  void initState() {
    super.initState();
    token = box.read('token');
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
          top: true,
          child: Scaffold(
            appBar: AppBar(actions: [GestureDetector(
              onTap: () {
                Navigator.pop(context, false);
              }, child: Icon(Icons.arrow_forward_outlined),)
            ],
              centerTitle: true,
              title: Text('اجمالي عدد زوار البروفايل'),
            ),
            body: StreamBuilder<Get_all_visitor_json>(
                stream: _allNetworking
                    .get_all_visitor(
                    token_id: widget.token_id, limit: limit, page_number: 0)
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
                                            hintText: 'البحث برقم التليفون',
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
                        SizedBox(
                          height: size.height * .02,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext
                              context) =>
                                  AlertDialog(
                                    title: Text('ارسل تنبيه'),
                                    content: Container(
                                      width: size.width * .8,
                                      height: 300,
                                      padding:
                                      EdgeInsets.all(8),
                                      decoration:
                                      BoxDecoration(
                                        border: Border.all(
                                          color: Colors.red,
                                          width: 1,
                                        ),
                                        borderRadius:
                                        BorderRadius
                                            .circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration:
                                            BoxDecoration(
                                              border:
                                              Border.all(
                                                color: Colors
                                                    .red,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10),
                                            ),
                                            width:
                                            size.width *
                                                .8,
                                            child: TextField(controller: addres,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                  InputBorder
                                                      .none,
                                                  enabledBorder:
                                                  InputBorder
                                                      .none,
                                                  hintText:
                                                  'العنوان'),
                                            ),
                                          ),
                                          Expanded(
                                              child:
                                              Container()),
                                          Container(
                                            decoration:
                                            BoxDecoration(
                                              border:
                                              Border.all(
                                                color: Colors
                                                    .red,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10),
                                            ),
                                            child: TextField(
                                              controller: contant,
                                              maxLines: 5,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                  InputBorder
                                                      .none,
                                                  enabledBorder:
                                                  InputBorder
                                                      .none,
                                                  hintText:
                                                  'المحتوي'),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              TextButton(
                                                child: new Text(
                                                    "الغاء"),
                                                onPressed: () =>
                                                    Navigator.pop(
                                                        context,
                                                        true),
                                              ),
                                              TextButton(
                                                child: new Text(
                                                    "ارسال"),
                                                onPressed: () {
                                                  _allNetworking
                                                      .sending_notifaction(
                                                      token_id:token,
                                                      title: addres.text,
                                                      content: contant.text,
                                                      id_user:'',
                                                      key_type: 1).then((value) {
                                                    addres.clear();
                                                    contant.clear();
                                                    Navigator.pop(
                                                        context,
                                                        true);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            );
                          },
                          child: Container(
                            height: size.height * .07,
                            width: size.width * 0.8,
                            child: Center(
                                child: Text(" ارسال تنبيه للكل ",
                                    style: TextStyle(
                                      fontFamily: 'Arbf',
                                      color: Colors.white,
                                    ))
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
                                borderRadius: BorderRadius.circular(40.0)),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: f
                                  .trim()
                                  .isEmpty
                                  ? snapshot.data.result.allVisitoe.length
                                  : data.length,
                              controller: _scrollController,
                              itemBuilder: (context, pos) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 8,
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(f
                                                  .trim()
                                                  .isEmpty
                                                  ? 'اسم العميل : ${snapshot
                                                  .data.result.allVisitoe[pos]
                                                  .userName}'
                                                  : 'اسم العميل : ${data[pos]
                                                  .userName}'),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext
                                                    context) =>
                                                        AlertDialog(
                                                          title: Text(
                                                              'ارسل تنبيه'),
                                                          content: Container(
                                                            width: size.width *
                                                                .8,
                                                            height: 300,
                                                            padding:
                                                            EdgeInsets.all(8),
                                                            decoration:
                                                            BoxDecoration(
                                                              border: Border
                                                                  .all(
                                                                color: Colors
                                                                    .red,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    border:
                                                                    Border.all(
                                                                      color: Colors
                                                                          .red,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        10),
                                                                  ),
                                                                  width:
                                                                  size.width *
                                                                      .8,
                                                                  child: TextField(
                                                                    controller: addres,
                                                                    decoration: InputDecoration(
                                                                        focusedBorder:
                                                                        InputBorder
                                                                            .none,
                                                                        enabledBorder:
                                                                        InputBorder
                                                                            .none,
                                                                        hintText:
                                                                        'العنوان'),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    child:
                                                                    Container()),
                                                                Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    border:
                                                                    Border.all(
                                                                      color: Colors
                                                                          .red,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        10),
                                                                  ),
                                                                  child: TextField(
                                                                    controller: contant,
                                                                    maxLines: 5,
                                                                    decoration: InputDecoration(
                                                                        focusedBorder:
                                                                        InputBorder
                                                                            .none,
                                                                        enabledBorder:
                                                                        InputBorder
                                                                            .none,
                                                                        hintText:
                                                                        'المحتوي'),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    TextButton(
                                                                      child: new Text(
                                                                          "الغاء"),
                                                                      onPressed: () =>
                                                                          Navigator
                                                                              .pop(
                                                                              context,
                                                                              true),
                                                                    ),
                                                                    TextButton(
                                                                      child: new Text(
                                                                          "ارسال"),
                                                                      onPressed: () {
                                                                        _allNetworking
                                                                            .sending_notifaction(
                                                                            token_id:token,
                                                                            title: addres.text,
                                                                            content: contant.text,
                                                                            id_user:snapshot
                                                                                .data.result.allVisitoe[pos].visitorId,
                                                                            key_type: 0).then((value) {
                                                                              addres.clear();
                                                                              contant.clear();
                                                                          Navigator.pop(
                                                                              context,
                                                                              true);
                                                                        });

                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                  );
                                                },
                                                child: Icon(
                                                    Icons.notifications_active),
                                              )
                                            ],
                                          ),
                                          Text(f
                                              .trim()
                                              .isEmpty
                                              ? 'رقم التليفون : ${snapshot.data
                                              .result.allVisitoe[pos]
                                              .userPhone}'
                                              : 'رقم التلفون : ${data[pos]
                                              .userPhone}'),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(f
                                                  .trim()
                                                  .isEmpty
                                                  ? 'عدد الزيارات : ${snapshot
                                                  .data.result.allVisitoe[pos]
                                                  .totalCountVisit}'
                                                  : 'عدد الزيارات : ${data[pos]
                                                  .totalCountVisit}'),
                                              GestureDetector(
                                                  onTap: () {
                                                    _allNetworking
                                                        .delete_visitor(
                                                        token_id:
                                                        widget.token_id,
                                                        visitor_id: f
                                                            .trim()
                                                            .isEmpty
                                                            ? snapshot
                                                            .data
                                                            .result
                                                            .allVisitoe[
                                                        pos]
                                                            .visitorId
                                                            : data[pos]
                                                            .visitorId)
                                                        .then((value) {
                                                      print(value.data);
                                                      setState(() {});
                                                    });
                                                  },
                                                  child: Icon(Icons.delete)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
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
          )),
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
