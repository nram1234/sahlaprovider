import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_user_coupons_json.dart';
import 'package:flutter/material.dart';

Widget listQRclient({high, AllVisitoe data, fun}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Card(elevation: 8,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(padding: const EdgeInsets.all(8.0),

        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Text('اسم العميل : ${data.userName}',
            style: TextStyle(
                fontFamily: 'Arbf', color: Colors.black, fontSize: 18),),
            Text('رقم التلفون : ${data.userPhone}',
              style: TextStyle(
                  fontFamily: 'Arbf', color: Colors.black, fontSize: 18),),
            Text('كود الخصم : ${data.serviceCoupon}',
              style: TextStyle(
                  fontFamily: 'Arbf', color: Colors.black, fontSize: 18),),Text('تاريخ الاستخدام : ${data.date}',
        style: TextStyle(
            fontFamily: 'Arbf', color: Colors.black, fontSize: 18),),
           Align( alignment: Alignment.bottomLeft,
                child: GestureDetector(onTap: fun, child: Icon(Icons.delete)))
          ],
        ),
      ),
    ),
  );
}

// Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
// children: [
// Column(
// children: [
// Text('اسم العميل',
// style: TextStyle(
// fontFamily: 'Arbf', color: Colors.black, fontSize: 20)),
// Text('رقم التلفون',
// style: TextStyle(
// fontFamily: 'Arbf', color: Colors.black, fontSize: 20))
// ],
// ),
// Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Container(height: 10,width: 10,color: Colors.blue,), InkWell(
// child: Text(
// 'تاكيد',
// style: TextStyle(
// fontFamily: 'Arbf', color: hexToColor('#00abeb'), fontSize: 18),
// ),
// )],)
// ],
// )
