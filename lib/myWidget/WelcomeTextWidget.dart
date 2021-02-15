import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget WelcomeTextWidget() {

  return Text(
    'hello'.tr,
    style: TextStyle(
        fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), fontSize: 25),
  );
}
