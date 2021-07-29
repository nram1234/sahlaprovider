
import 'package:sahlaprovider/utilitie/jsondata/get_offers_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget offertListItem({high, AllOffers data,fun ,funedit }) {

  return Directionality(
    textDirection: TextDirection.rtl,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: high * .28,
          child: Stack(
            children: [
              Positioned(
                  top: 2,
                  right: 2,
                  child: Column(
                    children: [
                      Container(child: Image.network(data.offersImage,fit: BoxFit.fill,),
                        width: high * .12,
                        height: high * .12,
                        color: Colors.red,
                      ),
                      Text(
                        data.expireDate=="1"?"تم انتهاء العرض":"العرض جاري",
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.red,
                            fontSize: 16),
                      ),  ],
                  )),
              Positioned(
                  top: 2,
                  left: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.offersName,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      Text(
                        data.offerNameEn,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.black,
                            fontSize: 16),
                      ),  Text(
                        " السعر القديم " + data.oldPrice ,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.black,
                            fontSize: 16),
                      ), data.newPrice.trim().isEmpty?SizedBox() : Text(
                        ' السعر الجديد ' +data.newPrice,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.black,
                            fontSize: 16),
                      ),    Text(
                        'بداية العرض ' +data.startDate,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      Text(
                        'نهاية العرض  ' +data.endDate,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.black,
                            fontSize: 16),
                      ),

                      Row(
                        children: [
                          InkWell( child: Icon(Icons.delete),onTap: fun,),SizedBox(width: 8,)
                         , InkWell(child: Icon(Icons.article_outlined),onTap: funedit,),
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

//
// Positioned(left: 2, top: high*, child: Text('اسم المنتج',
// style: TextStyle(
// fontFamily: 'Arbf', color: Colors.black, fontSize: 18),)),
// Positioned(left: 2, top: 2, child: Text('product name',
// style: TextStyle(
// fontFamily: 'Arbf', color: Colors.black, fontSize: 18),)),
// Positioned(bottom: 0, left: 0, child: Text('تاكيد',
// style: TextStyle(
// fontFamily: 'Arbf', color: hexToColor('#00abeb'), fontSize: 17),))
