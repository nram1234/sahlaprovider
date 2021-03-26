
import 'package:flutter/material.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_order_json.dart';

class Get_all_order extends StatefulWidget {
  String token_id;

  Get_all_order(this.token_id);

  @override
  _Get_all_orderState createState() => _Get_all_orderState();
}

class _Get_all_orderState extends State<Get_all_order> {
  AllNetworking _allNetworking = AllNetworking();
  TextEditingController _textEditingController=TextEditingController();
  int sizelist = 0;
  int limit = 50;
String f="";
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
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
              title: Text('عدد الطلبات'),
            ),
            body: StreamBuilder<Get_all_users_visting_json>(
                stream: _allNetworking
                    .get_all_users_visting(
                    token_id: widget.token_id, limit: limit, page_number: 0)
                    .asStream() ,
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<AllOrders>dat=snapshot.data.result.allOrders;
                    List<AllOrders>data=[];
                    dat.forEach((element) {
if(element.userPhone.contains(f)){
  data.add(element);
}


                    });
print(data.length);
                    print("data.length");
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
                                          textAlign: TextAlign.right,controller: _textEditingController,onChanged: (v){
                                            f=v;
                                            setState(() {

                                            });
                                      },
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
                              itemCount:f.trim().isEmpty? snapshot.data.result.allOrders.length:data.length,controller: _scrollController,
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
                                          Text(
                                              f.trim().isEmpty?'اسم العميل : ${snapshot.data.result.allOrders[pos].userName}':'اسم العميل : ${data[pos].userName}'),
                                          Text(
                                              f.trim().isEmpty? 'رقم التلفون : ${snapshot.data.result.allOrders[pos].userPhone}':'رقم التلفون : ${data[pos].userPhone}'),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [

                                              Text( f.trim().isEmpty?'عدد الزيارات : ${snapshot
                                                  .data
                                                  .result
                                                  .allOrders[pos]
                                                  .totalCountVisit}':'عدد الزيارات : ${data[pos]
                                                  .totalCountVisit}')
                                              ,   GestureDetector(
                                                  onTap: () {
                                                    _allNetworking
                                                        .delete_visitor(
                                                        token_id:
                                                        widget.token_id,
                                                        visitor_id:  f.trim().isEmpty
                                                            ?snapshot
                                                            .data
                                                            .result
                                                            .allOrders[pos]
                                                            .orderId:data[pos]
                                                            .orderId)
                                                        .then((value) {
                                                      print(value.data);
                                                      setState(() {});
                                                    });
                                                  },
                                                  child: Icon(Icons.delete)),],
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
