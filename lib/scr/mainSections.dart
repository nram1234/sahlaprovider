import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_category_json.dart';
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
    return Scaffold(body: Column(children: [

      Expanded(
      child: StreamBuilder<Get_all_category_json>(
        stream: _allNetworking.get_all_category(token_id: token, limit: limit, page_number: 0).asStream(),
        builder: (context, snap) {
          if (snap.hasData) {
            print(snap.data);


            return GridView.builder(controller: _scrollController,
                itemCount:
                snap.data.result.allProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:16/9,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return listhomeitem(
                      context: context,
                      fun: () {
                        // Navigator.push(
                        //   context,
                        //   new MaterialPageRoute(
                        //       builder: (context) =>
                        //           Get_all_advertising_guides(get_all_cat_guides_json
                        //               .result.allCatGuides[index].id)),
                        // );
                      },
                      name: snap.data.result.allProducts[index].productName,
                      pic:snap.data.result.allProducts[index].productImage);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    )



    ],),);
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

  Widget listhomeitem({context, String name, String pic,fun}) {
    return GestureDetector(onTap: fun,
      child: Container(
        decoration:  BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          children: [
            // Expanded(
            //   child:
            Container(height: MediaQuery.of(context).size.height*.1,width:  MediaQuery.of(context).size.width*.33,
              child: Image.network(
                pic,
                fit: BoxFit.fitWidth,
              ),
            ),
            // ),

            Text(name)
          ],
        ),
      ),
    );
  }

}
