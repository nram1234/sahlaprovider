import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/myWidget/productListItemWidget.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_products_JSON.dart';

import 'addNewProdect.dart';
 
import 'editProduct.dart';
import 'mainSections.dart';

class ProductScr extends StatefulWidget {
   VoidCallback back;

   ProductScr(this.back);

  @override
  _ProductScrState createState() => _ProductScrState();
}

List<AllProducts> list = [];
int sizelist=0;
bool getprodect = true;
int limit = 10;
String token;
String phone;

class _ProductScrState extends State<ProductScr> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  ScrollController _scrollController;
  String service_type = '0';
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    phone = box.read('phone');
    token = box.read('token');
    service_type = box.read('service_type');
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
          appBar: AppBar(actions: [GestureDetector( onTap: widget.back,child: Icon(Icons.arrow_forward_outlined),)],
            centerTitle: true,
            title: Text('المنتجات',
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: Column(
            children: [SizedBox(height: 10,),
      service_type!=0?
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
        GestureDetector(
        onTap: ()async {




          final value = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddNewProdect(context)),

          );
          setState(() {

          });


          // Get.to(
          //   AddNewProdect(context),
          //   transition: Transition.cupertino,
          // );
        },
        child: Container(
            height: high * .05,
            width: width * 0.35,
            child: Center(
              child: Text('اضافه منتج جديد',
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
                borderRadius: BorderRadius.circular(5.0))),
      ),
        GestureDetector(
          onTap: () {

            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      MainSections( )),
            );

          },
          child: Container(
              height: high * .05,
              width: width * 0.35,
              child: Center(
                child: Text('الاقسام الرئيسية',
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
                  borderRadius: BorderRadius.circular(5.0))),
        ),],):
      GestureDetector(
                onTap: ()async {



                  final value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNewProdect(context)),

                  );
                  setState(() {

                  });

                  // Get.to(
                  //   AddNewProdect(),
                  //   transition: Transition.cupertino,
                  // );
                },
                child: Container(
                    height: high * .05,
                    width: width * 0.5,
                    child: Center(
                      child: Text('اضافه منتج جديد',
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
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              SizedBox(height: 10,),
              Expanded(
                  flex: 1,
                  child: StreamBuilder(
                      stream: _allNetworking.Get_all_products(
                              phone: phone,
                              token_id: token,
                              limit: limit.toString(),
                              page_number: 0.toString())
                          .asStream(),
                      builder: (context, snapdata) {

                        if (snapdata.hasData) {
                         
                          Get_all_products_JSON data =
                          Get_all_products_JSON.fromJson(
                              json.decode(snapdata.data.body));
                          sizelist=data.result.allProducts.length;
                          return ListView.builder(
                              itemCount: data.result.allProducts.length,controller: _scrollController,
                              itemBuilder: (context, pos) {
                                return productListItem(
                                    high: high,offer: false,
                                    data: data.result.allProducts[pos],
                                    fun: () async {
                                      getprodect = true;
                                      setState(() {});
                                      _allNetworking
                                          .delete_product(
                                              token_id: token,
                                              product_id:data.result.allProducts[pos].productId)
                                          .then((value) {
                                       // var v = json.decode(value.body);

                                          setState(() {});
                                        }
                                      );
                                    },
                                    funedit: () {
                                      print(data.result.allProducts[pos].productId);

                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => EditProduct(
                                                  proid: int.parse(
                                                      data.result.allProducts[pos].productId),
                                                  token: token,
                                                )),
                                      );
                                    });
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }))
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
        setState(() {

        });
        // getallp(
        //     limit: limit.toString().toString(),
        //     page_number: 0.toString(),
        //     token_id: token,
        //     phone: phone);
      }
    }
  }
}

//eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjYzIiwicGhvbmUiOiIwMjI0MjgyNDEiLCJlbWFpbCI6IjAiLCJBUElfVElNRSI6MTYwOTMzMjQ3MH0.mZ5SWAXL6g2Ob53T41i2jZwl3nhnKrPXC7J4j85Mek4

//
// Expanded(
// flex: 1,
// child:
// ),
