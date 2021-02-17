import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';

class Myorder extends StatefulWidget {
  int id_order;

  Myorder(this.id_order);

  @override
  _MyorderState createState() => _MyorderState();
}

class _MyorderState extends State<Myorder> {
  AllNetworking _allNetworking = AllNetworking();
  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController address2 = TextEditingController();
  final box = GetStorage();
  String token;
  List<CityDetails> cityDetails = [

  ];
  CityDetails city;
  bool senddata = false;
  bool gtdata=true;
  OrderDetails _orderDetails;
  String lang  ;
  @override
  void initState() {
    token = box.read('token');
    phone.text = box.read('phone');
    lang = box.read('lang');
    phone.text = box.read(
      'name',
    );
    _allNetworking
        .preperation_order_details(
        lang:lang, token_id: token, order_id: widget.id_order)
        .then((value) {
      cityDetails=value.result.cityDetails;
      _orderDetails=value.result.orderDetails[0];

      setState(() {
        gtdata=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id_order);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        top: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text('طلبي'),
          ),
          body: gtdata?Center(child: CircularProgressIndicator(),): SingleChildScrollView(
            child: Container(padding: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * .87,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.height * .2,
                      child: Image.asset(
                        'assets/images/log.png',
                        color: Colors.blueAccent,
                      )),
                  Row(
                    children: [
                      Text('الاسم : ',
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.red,
                              fontSize: 25)),
                      Expanded(
                          child: TextField(
                            controller: name,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Text('التلفون : ',
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.red,
                              fontSize: 25)),
                      Expanded(
                          child: TextField(
                            controller: phone,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Text('العنوان : ',
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.red,
                              fontSize: 25)),
                      Expanded(
                          child: TextField(
                            controller: address,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Text('العنوان البديل: ',
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.red,
                              fontSize: 25)),
                      Expanded(
                          flex: 1,
                          child: TextField(
                            controller: address2,
                          )),
                    ],
                  ),
                  Container(width: MediaQuery.of(context).size.width*.98,
                    child: DropdownButton<CityDetails>(
                      value: city,
                      hint: Text(
                        'اختار المحافظة',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 22,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      onChanged: (v) {
                        city = v;
                        print(city.shippingCharges);
                        print("city.shippingCharges");
                        setState(() {});
                      },
                      itemHeight: 70,
                      items: cityDetails
                          .map<DropdownMenuItem<CityDetails>>((value) {
                        return DropdownMenuItem<CityDetails>(
                            value: value,
                            child: Text("محافظة " + value.cityName + "  ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)));
                      }).toList(),
                    ),
                  ), Row(
                    children: [
                      Text('تكلفة المنتجات: ',
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.red,
                              fontSize: 25)),
                      Expanded(
                          flex: 1,
                          child: Text(
                            _orderDetails.totalPrice,
                          )),
                    ],
                  ),Row(
                    children: [
                      Text('تكلفة الشحن: ',
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.red,
                              fontSize: 25)),
                      Expanded(
                          flex: 1,
                          child: Text(
                            city==null? "0":city.shippingCharges,
                          )),
                    ],
                  ),Row(
                    children: [
                      Text('التكلفة الكلية : ',
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.red,
                              fontSize: 25)),
                      Expanded(
                          flex: 1,
                          child: Text(
                            city==null?  _orderDetails.totalPrice:    (double.parse(city.shippingCharges)+double.parse(  _orderDetails.totalPrice)).toString() ,
                          )),
                    ],
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  senddata
                      ? CircularProgressIndicator()
                      : GestureDetector(
                    onTap: () {
                      print(token);
                      senddata = true;
                      setState(() {});
                      _allNetworking
                          .set_user_data(
                          phone: phone.text,
                          token_id: token,
                          lang: 'ar',anther_address: address2.text,
                          share_value: 0,
                          city_id: city.cityId,
                          address: address.text,
                          id_order: widget.id_order,
                          fullname: name.text)
                          .then((value) {
                        Get.snackbar('', value.message);
                        senddata = false;
                        setState(() {});
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      child: Center(
                        child: Text('اكمل الطلب',
                            style: TextStyle(
                                fontFamily: 'Arbf',
                                color: Colors.white,
                                fontSize: 25)),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(40.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
