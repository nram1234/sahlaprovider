import 'package:flutter/material.dart';

Widget logo(high){
  return Container(height: high*.1,
    child: Center(
      child: Image.asset(
        'assets/images/log.png',
        fit: BoxFit.fill,
      ),
    ),
  );
}