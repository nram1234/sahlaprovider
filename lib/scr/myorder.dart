import 'package:flutter/material.dart';

import 'get_current_orders.dart';
import 'get_previous_orders.dart';
import 'get_waiting_orders.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int _curr = 0;
  List<Widget> _list = <Widget>[new Get_Waiting_Orders(),
    new Get_current_orders(),

    new Get_previous_orders(),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(actions: [GestureDetector(
              onTap: () {
                Navigator.pop(context, false);
              }, child: Icon(Icons.arrow_back),)
            ]
              ,
              centerTitle: true,
              title: Text('طلباتي'),
            ),
            body: Column(
              children: [
                Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_pageController.hasClients) {
                            _pageController.jumpToPage(
                              0,
                            );
                          }
                        },
                        child: Container(
                          width: size.width * .25,
                          height: 30,
                          child: Center(child: Text('المنتظر')),
                          decoration: BoxDecoration(
                            color: _curr == 0 ? Colors.amber : Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_pageController.hasClients) {
                            _pageController.jumpToPage(
                              1,
                            );
                          }
                        },
                        child: Container(
                          width: size.width * .25,
                          height: 30,
                          child: Center(child: Text('الحالي')),
                          decoration: BoxDecoration(
                            color: _curr == 1 ? Colors.amber : Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_pageController.hasClients) {
                            _pageController.jumpToPage(
                              2,
                            );
                          }
                        },
                        child: Container(
                          width: size.width * .25,
                          height: 30,
                          child: Center(child: Text('المنتهي')),
                          decoration: BoxDecoration(
                            color: _curr == 2 ? Colors.amber : Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    children: _list,
                    scrollDirection: Axis.horizontal,

                    // reverse: true,
                    // physics: BouncingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (num) {
                      setState(() {
                        _curr = num;
                      });
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
