import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';

import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_products_cat_json.dart';

import 'addNewProdect.dart';
import 'editProduct.dart';
class Product_By_Category extends StatefulWidget {
  String cat_id;

  Product_By_Category(this.cat_id);

  @override
  _Product_By_CategoryState createState() => _Product_By_CategoryState();
}

class _Product_By_CategoryState extends State<Product_By_Category> {
  List<AllProducts> list = [];
  int sizelist=0;
  bool getprodect = true;
  int limit = 10;
  String token;
  String phone;
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
          appBar: AppBar(
            centerTitle: true,
            title: Text('المنتجات',
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: Column(
            children: [SizedBox(height: 10,),
          GestureDetector(
            onTap: () async{


              final value = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNewProdect(context)),

              );
              setState(() {

              });

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
                    borderRadius: BorderRadius.circular(40.0))),
          )
              ,
              SizedBox(height: 10,),    Expanded(
                  flex: 1,
                  child: StreamBuilder<Get_all_products_cat_json>(
                      stream: _allNetworking.get_all_products_cat(
                          cat_id:widget.cat_id ,
                          token_id: token,
                          limit: limit ,
                          page_number: 0 )
                          .asStream(),
                      builder: (context, snapdata) {

                        if (snapdata.hasData) {


                          sizelist=snapdata.data.result.allProducts.length;
                          return ListView.builder(
                              itemCount: snapdata.data.result.allProducts.length,controller: _scrollController,
                              itemBuilder: (context, pos) {
                                return productListItem(
                                    high: high,offer: false,
                                    data:snapdata.data.result.allProducts[pos],
                                    fun: () async {
                                      getprodect = true;
                                      setState(() {});
                                      _allNetworking
                                          .delete_product(
                                          token_id: token,
                                          product_id:snapdata.data.result.allProducts[pos].productId)
                                          .then((value) {
                                        // var v = json.decode(value.body);

                                        setState(() {});
                                      }
                                      );
                                    },
                                    funedit: () {
                                      print(snapdata.data.result.allProducts[pos].productId);

                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => EditProduct(
                                              proid: int.parse(
                                      snapdata.data.result.allProducts[pos].productId),
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





  Widget productListItem({high, AllProducts data,fun ,funedit,bool offer}) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: high * .17,
            child: Stack(
              children: [
                Positioned(
                    top: 2,
                    right: 2,
                    child: Container(child: Image.network(data.productImage,fit: BoxFit.fill,),
                      width: high * .12,
                      height: high * .12,
                    //  color: Colors.deepPurpleAccent,
                    )),
                Positioned(
                    top: 2,
                    left: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.productName,
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.red,fontWeight: FontWeight.bold ),
                        ),
                        Text(
                          data.productNameEn,
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.red,fontWeight: FontWeight.bold),
                        ),
                        // Text(
                        //   " السعر القديم " + data.oldPrice ,
                        //   style: TextStyle(
                        //       fontFamily: 'Arbf',
                        //       color: Colors.black,
                        //       fontSize: 16),
                        // ),
                        data.newPrice.trim().isEmpty?SizedBox() : Text(
                          ' السعر   ' +data.newPrice,
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.black,
                              fontSize: 16),
                        ),

                        Row(
                          children: [
                            InkWell( child: Icon(Icons.delete,color: Colors.amber,),onTap: fun,),SizedBox(width: 8,)
                            ,offer?SizedBox(): InkWell(child: Icon(Icons.article_outlined,color: Colors.amber,),onTap: funedit,),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

}
