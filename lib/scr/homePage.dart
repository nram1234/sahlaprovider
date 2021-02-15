
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahlaprovider/bloc/datavalidator.dart';
import 'package:sahlaprovider/myWidget/WelcomeTextWidget.dart';
import 'package:sahlaprovider/myWidget/inputTextWidget.dart';
import 'package:sahlaprovider/myWidget/logoWidget.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataValidator v = DataValidator();


  @override
  void dispose() {
    v.despoos();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final high = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          top: true,
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              logo(high),
              SizedBox(
                height: high * .03,
              ),
              Center(child: WelcomeTextWidget()),
              SizedBox(
                height: high * .02,
              ),
              inputText(
                  hint: 'phone'.tr,
                  stram: v.phonemy,
                  changedata: v.changephone,
                  inputtype: TextInputType.phone),
              SizedBox(
                height: high * .03,
              ),
              inputText(
                  hint: 'password'.tr,
                  changedata: v.changeName,
                  stram: v.passwordmy,
                  inputtype: TextInputType.text),


              SizedBox(
                height: high * .02,
              ),


             StreamBuilder(stream: v.validationUserDatamy,builder: (context,data){
               return   GestureDetector(onTap: data.data!=null?(){

               }:null,
                 child: Container(
                   height: high * .1,
                   width: width * 0.5,
                   child: Center(
                     child: Text('login'.tr,
                         style: TextStyle(
                             fontFamily: 'Arbf',
                             color: Colors.white,
                             fontSize: 25)),
                   ),
                   decoration:data.data!=null? BoxDecoration(
                       color: hexToColor('#00abeb'), gradient: new LinearGradient(
                       colors: [Colors.red[100],
                         Colors.red[900],],
                       begin: Alignment.centerLeft,
                       end: Alignment.centerRight,
                       tileMode: TileMode.clamp
                   ),
                       borderRadius: BorderRadius.circular(40.0)):BoxDecoration(
                       color: Colors.grey,
                       borderRadius: BorderRadius.circular(40.0)),
                 ),
               );
             },)


            ],
          ),
        ),
      ),
    );
  }
}
