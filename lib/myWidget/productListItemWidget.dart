import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_products_JSON.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget productListItem({high, AllProducts data,fun ,funedit,bool offer}) {

  return Directionality(
    textDirection: TextDirection.rtl,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
           height: high * .2,
          child: Stack(
            children: [
              Positioned(
                  top: 2,
                  left: 2,
                  child: Container(child: Image.network(data.productImage,fit: BoxFit.fill,),
                    width: high * .12,
                    height: high * .12,
                  //  color: Colors.deepPurpleAccent,
                  )),
              Positioned(
                  top: 2,
                  right:  2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الاسم عربي  : "+     data.productName,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                             color: Colors.red,fontWeight: FontWeight.bold ),
                      ),
                      Text(
                        "الاسم انجليزي  : "+  data.productNameEn,
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
                        'السعر  : ' +data.newPrice,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.red,
                            fontSize: 16),
                      ),
                      Text(
                        "الرقم الكودي  : "+   data.serialNumber,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.red,fontWeight: FontWeight.bold),
                      ), Text(
                        "المخزن : "+  data.stock,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.red,fontWeight: FontWeight.bold),
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
