import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

Widget serchWidget({high, width,fun}) {
  return Container(padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: Colors.black12, borderRadius: BorderRadius.circular(40.0)),

    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        GestureDetector(onTap: fun,
        child: Icon(
          Icons.menu,
          color: hexToColor('#00abeb'),
        ),
      ),

      //
        Text('usercode'.tr), SizedBox(
        width: width * .3,
      ), Icon(
        Icons.search,
        color: hexToColor('#00abeb'),
      ),
        Container(
          height: high * 0.04,
          width: high * 0.1,
          child: Image.asset(
            'assets/images/log.png',
            fit: BoxFit.fill,
          ),
        ),


      ],
    ),
  );
}
