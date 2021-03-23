
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_points_json.dart';

class PointScr extends StatefulWidget {
  @override
  _PointScrState createState() => _PointScrState();
}

class _PointScrState extends State<PointScr> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
TextEditingController _textEditingController=TextEditingController();
bool save=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [GestureDetector(
        onTap: () {
          Navigator.pop(context, false);
        }, child: Icon(Icons.arrow_forward_outlined),)
      ],
        title: Text('نقاطي'),
        centerTitle: true,
      ),
      body: StreamBuilder <Preparation_points_json>(
        stream: _allNetworking.preparation_points(token_id: box.read('token')).asStream(),
        builder: (context, snapshot) {
          if(snapshot.hasData){

 _textEditingController.text=snapshot.data.result.totalPoints;
            return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [SizedBox(height: 20,),TextFormField(controller: _textEditingController,


              textAlign: TextAlign.center,
              style:   TextStyle(
                fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
              decoration: InputDecoration(
                labelText: "عدد النقاط لكل طلب",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'عدد النقاط لكل طلب',

                hintStyle:
                TextStyle(
                  fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
              ),
            ),SizedBox(height: 20,),save?CircularProgressIndicator( ): GestureDetector(
              onTap: () {
                setState(() {
                  save=true;
                });
_allNetworking.edit_points(token_id: box.read('token'), total_points: _textEditingController.text).then((value) {  setState(() {
  save=false;
});});
              },
              child: Container(
                height: MediaQuery.of(context) .size.height* .07,
                width: MediaQuery.of(context) .size.width * 0.5,
                child: Center(
                  child: Text("حفظ",
                      style: TextStyle(
                          fontFamily: 'Arbf',
                          color: Colors.white,
                          fontSize: 25)),
                ),
                decoration: BoxDecoration(
                    color: hexToColor('#00abeb'),
                    gradient: new LinearGradient(
                        colors: [Colors.red[100],
                          Colors.red[900],],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),],
          );}else{return Center(child: CircularProgressIndicator(),);}

        }
      ),
    );
  }
}
