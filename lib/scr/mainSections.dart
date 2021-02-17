import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/scr/product_by_category.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_category_json.dart';

import 'add_category.dart';
import 'edit_category.dart';

class MainSections extends StatefulWidget {
  @override
  _MainSectionsState createState() => _MainSectionsState();
}

class _MainSectionsState extends State<MainSections> {
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
    return SafeArea(top: true,
      child: Scaffold(
        body: Column(
          children: [SizedBox(height: 10,),GestureDetector(
            onTap: () async{

              final result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => Add_Category()),);
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
                  child: Text('اضافه قسم جديد',
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
          ),SizedBox(height: 10,),
            Expanded(
              child: StreamBuilder<Get_all_category_json>(
                stream: _allNetworking
                    .get_all_category(
                        token_id: token, limit: limit, page_number: 0)
                    .asStream(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    print(snap.data);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          controller: _scrollController,
                          itemCount: snap.data.result.allProducts.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 9/ 9,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return listhomeitem(
                                context: context,
                                onclick: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            Product_By_Category(   snap.data.result.allProducts[index].productId)),
                                  );
                                },
                                name:
                                    snap.data.result.allProducts[index].productName,
                                pic: snap
                                    .data.result.allProducts[index].productImage,
                                ename: snap
                                    .data.result.allProducts[index].productNameEn

                            ,delet: (){_allNetworking.delete_category(token_id: token, cat_id: snap
                                .data.result.allProducts[index].productId,).then((value){setState(() {

                                });});}




                          ,edit: (){
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        Edit_Category(cat_id: snap
                                            .data.result.allProducts[index].productId , token: token,)),
                              );
                            }  );
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
      {context, String name, String pic, onclick, String ename, edit, delet}) {
    return GestureDetector(
      onTap: onclick,
      child: Container( decoration: BoxDecoration(

          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],   border: Border.all(color: Colors.grey[400]),
          borderRadius:
          BorderRadius.circular(10.0)) ,

        child: Column(
          children: [
           Expanded(
               child:
            Container(
            //  height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width * .48,
              child: ClipRRect(borderRadius:BorderRadius.circular(10.0) ,
                child: Image.network(
                  pic,
                  fit: BoxFit.fill,
                ),
              ),
            ),
             ),

            Text(name,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
            Text(ename,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(onTap: delet, child: Icon(Icons.delete,color: Colors.amber,),),
                GestureDetector(onTap: edit,child: Icon(Icons.edit,color: Colors.amber,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
