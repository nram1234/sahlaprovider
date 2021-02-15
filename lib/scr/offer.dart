import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/myWidget/offertListItem.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_offers_json.dart';

import 'addOfeer.dart';
import 'editoffer.dart';

class OfferScr extends StatefulWidget {
  @override
  _OfferScrState createState() => _OfferScrState();
}

int sizelist = 0;
bool getprodect = true;
int limit = 1000;
String token;
String phone;
DateTime endpick;
DateTime endpickDate;
List<AllOffers>_list=[];
class _OfferScrState extends State<OfferScr> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    endpickDate=   DateTime.now();
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
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: mydrawer(context),
          appBar: AppBar(actions: [],
            centerTitle: true,
            title: Text('offer'.tr,
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: Column(
            children: [

              Expanded(
                flex: 1,
                child: StreamBuilder(
                    stream: _allNetworking
                        .get_offers(
                            token_id: token,
                            limit: limit.toString(),
                            page_number: 0.toString())
                        .asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Get_offers_json data =
                        Get_offers_json.fromJson(
                            json.decode(snapshot.data.body));
                        sizelist=data.result.allOffers.length;
                        return Column(
                          children: [   Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [ GestureDetector(
                                onTap: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AddOffer() ),
                                  );


                                  // Get.to(
                                  //   AddOffer(),
                                  //   transition: Transition.cupertino,
                                  // );
                                },
                                child: Container(
                                    height: high * .05,
                                    width: width * 0.4,
                                    child: Center(
                                      child: Text('اضافه عرض جديد',
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
                                GestureDetector(
                                    onTap: () async {
                                      String end_date;
                                      endpick = await showDatePicker(
                                          context: context,
                                          initialDate: endpickDate,
                                          firstDate: DateTime(DateTime.now().year),
                                          lastDate: DateTime(DateTime.now().year + 1));
                                      if (endpick != null) {
                                        endpickDate = endpick;
                                        end_date = endpickDate.year.toString() +
                                            "-" +
                                            endpickDate.month.toString() +
                                            "-" +
                                            endpickDate.day.toString();
                                        _list.clear();
                                        data.result.allOffers.forEach((element) {

                                          if(element.endDate==end_date||element.startDate==end_date){
                                            _list.add(element);
                                          }
                                        });
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      height: high * .05,
                                      width: width * 0.45,
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
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Center(
                                            child: Text(endpick == null
                                                ? "البحث"
                                                : "تاريخ : ${endpickDate.year}-${endpickDate.month}-${endpickDate.day}",style:  TextStyle(
                                                fontFamily: 'Arbf',
                                                color: Colors.white,
                                                fontSize: 18),),
                                          ),
                                       GestureDetector(onTap: (){
                                         endpick=null;
                                         _list.clear();
                                         setState(() {
                                           
                                         });
                                       },child:endpick==null?SizedBox(): Icon(Icons.clear,color: Colors.white70,),) ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount:endpick==null? data.result.allOffers.length:_list.length,
                                  controller: _scrollController,
                                  itemBuilder: (context, pos) {
                                    return offertListItem(
                                        high: high,
                                        data: endpick==null?data.result.allOffers[pos]:_list[pos],
                                        fun: () async {
                                          getprodect = true;

                                          print(data.result
                                              .allOffers[pos].offersId);

                                          setState(() {});
                                          _allNetworking
                                              .delete_offers(
                                                  token_id: token,
                                                  product_id:endpick==null? data.result
                                                      .allOffers[pos].offersId:_list[pos].offersId)
                                              .then((value) {
                                             // var v = json.decode(value.body);
print(value);
                                            setState(() {});
                                          });
                                        },
                                        funedit: () {
                                          print(
                                              data.result.allOffers[pos].offersId);

                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => EditOffer(
                                                      offid:   endpick==null?  data.result.allOffers[pos].offersId:_list[pos].offersId,
                                                      token: token,
                                                    )),
                                          );
                                        });
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
            ],
          )),
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
