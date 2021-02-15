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
           height: high * .17,
          child: Stack(
            children: [
              Positioned(
                  top: 2,
                  right: 2,
                  child: Container(child: Image.network(data.productImage,fit: BoxFit.fill,),
                    width: high * .12,
                    height: high * .12,
                    color: Colors.deepPurpleAccent,
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
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      Text(
                        data.productNameEn,
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.black,
                            fontSize: 16),
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
                          InkWell( child: Icon(Icons.delete),onTap: fun,),SizedBox(width: 8,)
                         ,offer?SizedBox(): InkWell(child: Icon(Icons.article_outlined),onTap: funedit,),
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
