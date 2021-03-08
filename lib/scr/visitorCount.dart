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
            appBar: AppBar(
              centerTitle: true,
              title:Text('اجمالي عدد زوار البروفايل'),
            ),
            body: StreamBuilder<Get_all_visitor_json>(
                stream: _allNetworking
                    .get_all_visitor(
                        token_id: widget.token_id, limit: limit, page_number: 0)
                    .asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
    List<AllVisitoe>dat=snapshot.data.result.allVisitoe;
    List<AllVisitoe>data=[];
    dat.forEach((element) {
    if(element.userPhone.contains(f)){
    data.add(element);
    }}
    );


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
                                      child: TextFormField(onChanged: (v){
                                        f=v;
                                        setState(() {

                                        });
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
                        Expanded(
                          child: ListView.builder(
                              itemCount:f.trim().isEmpty? snapshot.data.result.allVisitoe.length:data.length,controller: _scrollController,
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
                                              f.trim().isEmpty?    'اسم العميل : ${snapshot.data.result.allVisitoe[pos].userName}': 'اسم العميل : ${data[pos].userName}'),
                                          Text(
                                              f.trim().isEmpty?     'رقم التليفون : ${snapshot.data.result.allVisitoe[pos].userPhone}': 'رقم التلفون : ${data[pos].userPhone}'),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [

                                              Text(f.trim().isEmpty?   'عدد الزيارات : ${snapshot
                                                  .data
                                                  .result
                                                  .allVisitoe[pos]
                                                  .totalCountVisit}':  'عدد الزيارات : ${data[pos]
                                                  .totalCountVisit}')
                                            ,   GestureDetector(
                                                  onTap: () {
                                                    _allNetworking
                                                        .delete_visitor(
                                                        token_id:
                                                        widget.token_id,
                                                        visitor_id: f.trim().isEmpty
                                                            ?snapshot
                                                            .data
                                                            .result
                                                            .allVisitoe[pos]
                                                            .visitorId:data[pos]
                                                            .visitorId)
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
