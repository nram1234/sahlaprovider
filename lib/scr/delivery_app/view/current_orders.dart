import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/scr/delivery_app/compnents/delivery_drawer.dart';
import 'package:sahlaprovider/scr/delivery_app/logic/all_delivery_networking.dart';
import 'package:sahlaprovider/scr/delivery_app/model/order_model.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_current_orders_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_order_details_json.dart';

class DeliveryOrders extends StatefulWidget {
  @override
  _DeliveryOrdersState createState() => _DeliveryOrdersState();
}

class _DeliveryOrdersState extends State<DeliveryOrders> {
  final box = GetStorage();
  String token;
  AllNetworking _allNetworking = AllNetworking();

  @override
  void initState() {
    super.initState();
    token = box.read('deliveryToken');
  }

  List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        top: true,
        child: Scaffold(
            appBar: AppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Icon(Icons.arrow_forward_outlined),
                )
              ],
              centerTitle: true,
              title: Text('طلبات',
                  style: TextStyle(
                    fontFamily: 'Arbf',
                    color: Colors.black,
                  )),
            ),
            drawer: DeliveryDrawer(),
            body: StreamBuilder<OrdersModel>(
                stream: AllDeliveryNetworking()
                    .getMyOrders(token: token)
                    .asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.data.orders.length > 0) {
                      return ListView.builder(
                          itemCount: snapshot.data.data.orders.length,
                          itemBuilder: (context, pos) {
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
                                      color: Colors.red.withOpacity(0.5),
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
                                      height: 50,
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                // _allNetworking
                                                //     .update_order(token_id: token, id_order: snapshot.data.result.allOrders[pos].idOrder.toString(), key_action: 2)
                                                //     .then((value) {
                                                //   setState(() {});
                                                //   // Get.snackbar('',
                                                //   //     value.);
                                                // });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text('جاري تجهيز الطلب',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                              )),
                                          GestureDetector(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: RaisedButton(
                                                color: Colors.red[900],
                                                onPressed: () {
                                                  // _allNetworking
                                                  //     .update_order(
                                                  //         token_id: token,
                                                  //         id_order: snapshot
                                                  //             .data
                                                  //             .result
                                                  //             .allOrders[pos]
                                                  //             .idOrder
                                                  //             .toString(),
                                                  //         key_action: 2)
                                                  //     .then((value) {
                                                  //   setState(() {});
                                                  //   // Get.snackbar('',
                                                  //   //     value.);
                                                  // });
                                                },
                                                child: Text('انهاء الطلب',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18))),
                                          ))
                                          // GestureDetector(
                                          //     onTap: () {
                                          //       _allNetworking
                                          //           .update_order(token_id: token, id_order: snapshot.data.result.allOrders[pos].idOrder.toString(), key_action: 3)
                                          //           .then((value) {
                                          //         setState(() {});
                                          //         // Get.snackbar('',
                                          //         //     value.);
                                          //       });
                                          //     },
                                          //     child: Text('جاري توصيل الطلب',
                                          //         style: TextStyle(
                                          //             color:
                                          //             Colors.white,
                                          //             fontWeight:
                                          //             FontWeight
                                          //                 .bold,fontSize:18 )))
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(
                                            'كود الطلب',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(snapshot.data.data
                                              .orders[pos].order.codeName),
                                        ),
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           left: 16, right: 16),
                                    //       child: Text(
                                    //         'تكلفة الشحن',
                                    //         style: TextStyle(color: Colors.red),
                                    //       ),
                                    //     ),
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           left: 16, right: 16),
                                    //       child: Text(snapshot.data.data.orders[pos].
                                    //               .trim()
                                    //               .isEmpty
                                    //           ? ''
                                    //           : snapshot
                                    //                   .data
                                    //                   .result
                                    //                   .allOrders[pos]
                                    //                   .shippingCharges +
                                    //               " " +
                                    //               snapshot
                                    //                   .data
                                    //                   .result
                                    //                   .allOrders[pos]
                                    //                   .currencyName),
                                    //     ),
                                    //   ],
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(
                                            'اجمالي المنتجات',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(snapshot.data.data
                                              .orders[pos].order.totalProduct
                                              .toString()),
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
                                            'تاريخ الطلب : ',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(snapshot.data.data
                                              .orders[pos].order.date),
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
                                            'التكلفة الكلية : ',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(snapshot
                                                  .data
                                                  .data
                                                  .orders[pos]
                                                  .order
                                                  .totalPrice +
                                              " " +
                                              snapshot.data.data.orders[pos]
                                                  .order.currency),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: size.width * .7,
                                      height: 1,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      height: size.height * .01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(
                                            'الاسم : ',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(snapshot.data.data
                                              .orders[pos].order.fullname),
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
                                            'التليفون : ',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(snapshot.data.data
                                              .orders[pos].order.phone),
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
                                            maxLines: 2,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(snapshot.data.data
                                              .orders[pos].order.address),
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Container(
                                            child: Text(snapshot
                                                .data
                                                .data
                                                .orders[pos]
                                                .order
                                                .antherAddress),
                                          ),
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
                                            'اسم المدينه : ',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(snapshot.data.data
                                              .orders[pos].order.city),
                                        ),
                                      ],
                                    ),
                                    ExpansionTile(
                                      title: Text('تفاصيل'),
                                      children: snapshot
                                          .data.data.orders[pos].order.details
                                          .map((e) => Productsiteem(
                                              offers: e, size: size))
                                          .toList(),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: Text('لا يوجد طلبات'),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
      ),
    );
  }

  Widget Productsiteem({Details offers, size}) {
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
              color: Colors.red.withOpacity(0.5),
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
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                offers.img,
                width: size.width * .3,
                height: size.height * .15,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 2),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: size.height * .1,
                      width: size.width * .3,
                      child: Text(offers.name),
                    ),
                  ),
                  Text(offers.price)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(offers.quantity.toString(),
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
