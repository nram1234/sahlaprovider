import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/jsondata/list_wedding_reservation_json.dart';

class Get_list_wedding_reservation extends StatefulWidget {
  @override
  _Get_list_wedding_reservationState createState() =>
      _Get_list_wedding_reservationState();
}

class _Get_list_wedding_reservationState
    extends State<Get_list_wedding_reservation> {
  final box = GetStorage();
  String token;
  AllNetworking _allNetworking = AllNetworking();
  String lang;

  @override
  void initState() {
    super.initState();
    token = box.read('token');
  }

  List<List<Widget>> list = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الحجوزات'),
        ),
        body: StreamBuilder<Get_List_wedding_reservation_json>(
            stream: _allNetworking
                .get_List_wedding_reservation(token_id: token)
                .asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.result.allReservation.length > 0) {
                  return ListView.builder(
                      itemCount: snapshot.data.result.allReservation.length,
                      itemBuilder: (context, pos) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: snapshot.data.result.allReservation[pos]
                                          .reservationType ==
                                      "1"
                                  ? Colors.grey[200]
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: snapshot.data.result
                                              .allReservation[pos].view ==
                                          "0"
                                      ? Colors.blueAccent.withOpacity(0.5)
                                      : Colors.red.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 3,
                                  color: snapshot.data.result
                                              .allReservation[pos].view ==
                                          "0"
                                      ? Colors.blue
                                      : Colors.red,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [],
                                  ),
                                ),
                                Text(snapshot.data.result.allReservation[pos]
                                            .reservationType ==
                                        "1"
                                    ? "حجز من داخل التطبيق"
                                    : "حجز من خارج التطبيق"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        'من الساعه : ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(snapshot.data.result
                                          .allReservation[pos].fromHrs),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        'الي الساعة',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(snapshot.data.result
                                          .allReservation[pos].toHrs),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        'اليوم',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(snapshot.data.result
                                          .allReservation[pos].reservationDay),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        'تاريخ انشاء الحجز',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(snapshot.data.result
                                          .allReservation[pos].creationDate),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        'تاريخ تنفيذ الحجز',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(snapshot.data.result
                                          .allReservation[pos].reservationDate),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        'الاسم',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(snapshot.data.result
                                          .allReservation[pos].fullname),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        'العنوان : ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(snapshot.data.result
                                            .allReservation[pos].address)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'الشخص المسؤال عن الحجز : ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(snapshot
                                          .data
                                          .result
                                          .allReservation[pos]
                                          .userMakeReservationName),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        'التلفون : ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(snapshot.data.result
                                          .allReservation[pos].phone),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    snapshot.data.result.allReservation[pos]
                                                .view ==
                                            '1'
                                        ? SizedBox(
                                            width: 1,
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              _allNetworking
                                                  .accepted_list_reservation(
                                                      token_id: token,
                                                      id_list: snapshot
                                                          .data
                                                          .result
                                                          .allReservation[pos]
                                                          .idOrder)
                                                  .then((value) {
                                                print(value.data);
                                                setState(() {});
                                              }).catchError((e) {
                                                print(e);
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Icon(Icons.check),
                                            ),
                                          ),
                                    GestureDetector(
                                      onTap: () {
                                        _allNetworking
                                            .delete_list_reservation(
                                                token_id: token,
                                                id_list: snapshot
                                                    .data
                                                    .result
                                                    .allReservation[pos]
                                                    .idOrder)
                                            .then((value) {
                                          print(value.data);
                                          setState(() {});
                                        }).catchError((e) {
                                          print(e);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Icon(Icons.clear),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: Text('لا يوجد حجوزات'),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget Productsiteem({AllReservation offers, size}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: size.height * .2,
        width: size.width * .9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 2),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: size.height * .1,
                      width: size.width * .3,
                      child: Text('ff'),
                    ),
                  ),
                  Text('  ssa')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ppp',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
