import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';

Widget inputText({hint,changedata,stram,inputtype, TextEditingController textedet}) {

return  StreamBuilder(
      stream: stram,
      builder: (context, snapshot) {
        return TextFormField(keyboardType: inputtype,controller: textedet,

          onChanged: (s) {
            changedata(s);
          },
          textAlign: TextAlign.right,maxLines: null,
          style:   TextStyle(
            fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
          decoration: InputDecoration(
            labelText: hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(5.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: hint,
            errorText: snapshot.error,
            hintStyle:
             TextStyle(
                fontFamily: 'Arbf', color:hexToColor('#ed1c6f'), ),
          ),
        );
      });
}
