import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/tickets_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'contactwithmanager.dart';
import 'ticketdetails.dart';

class Remembering extends StatefulWidget {
  @override
  _RememberingState createState() => _RememberingState();
}

class _RememberingState extends State<Remembering> {
  int sizelist = 0;
  bool getprodect = true;
  int limit = 10;
  String token;
  String phone;
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    phone = box.read('phone');
    token = box.read('token');
    print('oooooooooooooooooooooooooooooooo');
    print(token);
    print('oooooooooooooooooooooooooooooooo');
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Mydrawer(),// mydrawer(context),
      appBar: AppBar(
        actions: [GestureDetector(
          onTap: () {
            Navigator.pop(context, false);
          }, child: Icon(Icons.arrow_forward_outlined),)
        ],
        elevation: 8,
        centerTitle: true,
        title: Text("ﺍﻟﺘﺬﺍﻛﺮ"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        width: width,
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            GestureDetector(
              onTap: () async {
                final value = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactWithManager(context)),
                );
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 4, right: 20, left: 20),
                child: Container(
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Text('ﺍﻧـﺸﺎﺀ ﺭﺳﺎﻟﺔ',
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
                        borderRadius: BorderRadius.circular(40.0))),
              ),
            ),
            Expanded(
              flex: 1,
              child: StreamBuilder<Tickets_json>(
                  stream: _allNetworking
                      .tickets(token_id: token, limit: limit, page_number: 0)
                      .asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.result.myTickets.length,
                          controller: _scrollController,
                          itemBuilder: (context, pos) {
                            return Itemli(
                                high: height,
                                data: snapshot.data.result.myTickets[pos]);
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget Itemli({high, MyTickets data}) {
    return Card(
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          Get.to(TicketDetails(data.id));
        },
        child: Container(
          padding: EdgeInsets.all(8),color: data.senderReplay=='0'?Colors.white:Colors.grey,
          height: high * .15,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.createdAt),
                  GestureDetector(onTap: ( ) {





_allNetworking.delete_ticket(token_id: token, id_ticket: data.id).then((value) {

  setState(() {

  });
  Get.snackbar('', value.data["message"]);


});




                  }, child: Icon(Icons.delete)),
                ],
              ),
              Expanded(child: Text(data.title))
            ],
          ),
        ),
      ),
    );
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (sizelist > 8) {
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
