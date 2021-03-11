import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_list_weddings_services_json.dart';

import 'add__wedding_service.dart';
import 'edit_wedding_service.dart';

class List_weddings_services extends StatefulWidget {
  @override
  _List_weddings_servicesState createState() => _List_weddings_servicesState();
}

class _List_weddings_servicesState extends State<List_weddings_services> {
  AllNetworking _allNetworking = AllNetworking();
  int sizelist = 0;
  int limit = 50;

  ScrollController _scrollController;
  final box = GetStorage();
  String token;

  @override
  void initState() {
    token = box.read('token');
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Add__wedding_service(context)),);
                //refresh the state of your Widget
                setState(() {

                });
                // Get.to(
                //   Add_Category(),
                //   transition: Transition.cupertino,
                // );
              },
              child: Container(
                  height: high * .05,
                  width: width * 0.7,
                  child: Center(
                    child: Text('اضافه خدمة جديدة',
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
                      borderRadius: BorderRadius.circular(40.0))),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<Get_list_weddings_services_json>(
                stream: _allNetworking
                    .get_list_weddings_services(token_id: token)
                    .asStream(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    print(
                        '00000000000000000000000000000000000000000000000000000');

                    print(
                        '00000000000000000000000000000000000000000000000000000');
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          controller: _scrollController,
                          itemCount:
                              snap.data.result.listWeddingsServices.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            //childAspectRatio: 9/ 9,
                            mainAxisSpacing: 10, mainAxisExtent: 130,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return listhomeitem(
                              context: context,
                              onclick: () {
                                // Navigator.push(
                                //   context,
                                //   new MaterialPageRoute(
                                //       builder: (context) =>
                                //           Product_By_Category(   snap.data.result.allProducts[index].productId)),
                                // );
                              },
                              name: snap.data.result.listWeddingsServices[index]
                                  .servicesName,
                              ename: snap.data.result
                                  .listWeddingsServices[index].servicesNameEn,
                              price: snap.data.result
                                  .listWeddingsServices[index].price,
                              cur: snap.data.result.listWeddingsServices[index]
                                  .currencyName,
                              delet: () {
                                _allNetworking
                                    .delete_wedding_service(
                                  token_id: token,
                                  id_list: snap
                                      .data.result.listWeddingsServices[index].idWeddingService,
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              edit: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          Edit_Wedding_Service(mycontext: context,weddingsServices:  snap
                                              .data.result.listWeddingsServices[index],)),
                                );
                              },
                            );
                          }),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
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

  Widget listhomeitem(
      {context,
      String name,
      onclick,
      String ename,
      edit,
      delet,
      String price,
      String cur}) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(color: Colors.grey[400]),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              ename,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              price + ' ' + cur,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: delet,
                  child: Icon(
                    Icons.delete,
                    color: Colors.amber,
                  ),
                ),
                GestureDetector(
                    onTap: edit,
                    child: Icon(
                      Icons.edit,
                      color: Colors.amber,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
