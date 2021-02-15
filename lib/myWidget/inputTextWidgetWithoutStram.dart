
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';

Widget inputTextwithoutstraim({hint,inputtype}) {

        return TextFormField(keyboardType: inputtype,


          textAlign: TextAlign.center,maxLines: null,
          style:   TextStyle(
            fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
          decoration: InputDecoration(
            labelText: hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: hexToColor('#00abeb'), width: 2),
              borderRadius: BorderRadius.circular(40.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: hexToColor('#00abeb'), width: 2),
              borderRadius: BorderRadius.circular(40.0),
            ),
            hintText: hint,

            hintStyle:
            TextStyle(
              fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
          ),
        );

}
