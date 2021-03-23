import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';

class Add_Doctor_Out_Reservation extends StatefulWidget {
  @override
  _Add_Doctor_Out_ReservationState createState() =>
      _Add_Doctor_Out_ReservationState();
}

class _Add_Doctor_Out_ReservationState
    extends State<Add_Doctor_Out_Reservation> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _picked;
  DateTime _dateTime = DateTime.now();
  AllNetworking _allNetworking = AllNetworking();
  TextEditingController name = TextEditingController();
  TextEditingController addres = TextEditingController();
  TextEditingController phone = TextEditingController();
  Future<String> selecttime({BuildContext context}) async {
    _picked = await showTimePicker(context: context, initialTime: _time);

    return _picked.format(context);
  }

  String token;
  final box = GetStorage();

  @override
  void initState() {
    token = box.read('token');
  }

  String starttime = ' الساعة';
  String endtime = ' الساعة';
bool sewnddata=false;
  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title:Text('اضافة حجز خارجي  ') ,centerTitle: true,actions: [GestureDetector(
        onTap: () {
          Navigator.pop(context, false);
        }, child: Icon(Icons.arrow_forward_outlined),)
      ],),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'الاسم'),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: addres,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'العنوان'),
                ),
              ),
              SizedBox(
                height: 16,
              ),  Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phone,keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'التلفون'),
                ),
              ),
              SizedBox(
                height: 16,
              ),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الوقت',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      selecttime(context: context).then((value) {
                        if(value!=null){


                          starttime = value;}
                        setState(() {});
                      });
                      setState(() {});
                    },
                    child: Container(
                        width: width*.25,
                        height: 50,
                        decoration: BoxDecoration(
                            color: hexToColor('#00abeb'),
                            gradient: new LinearGradient(
                                colors: [
                                  Colors.red[900],
                                  Colors.red[100],
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(child: Text("  من  " + starttime))),
                  ),

                  GestureDetector(
                    onTap: () {
                      selecttime(context: context).then((value) {
                        if(value!=null){


                          endtime = value;}
                        setState(() {});
                      });
                      setState(() {});
                    },
                    child: Container(
                        width:width*.25,
                        height: 50,
                        decoration: BoxDecoration(
                            color: hexToColor('#00abeb'),
                            gradient: new LinearGradient(
                                colors: [
                                  Colors.red[900],
                                  Colors.red[100],
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(child: Text("  الي  " + endtime))),
                  ),  ],
              ),

              SizedBox(
                height: 16,
              ),

              Row(
                children: [
                  Text(
                    'التاريخ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),SizedBox(width: width*.18,),
                  Expanded(flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        await showDatePicker(
                            context: context,
                            initialDate: _dateTime,
                            firstDate: _dateTime,
                            lastDate: DateTime(2035))
                            .then((value) {
                          if(value!=null){
                            _dateTime = value;
                          }

                          setState(() {});
                        });
                      },
                      child: Container(
                    
                          height: 50,
                          decoration: BoxDecoration(
                              color: hexToColor('#00abeb'),
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.red[900],
                                    Colors.red[100],
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  tileMode: TileMode.clamp),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                              child: Text(" شهر " +
                                  _dateTime.month.toString() +
                                  " يوم " +
                                  _dateTime.day.toString()))),
                    ),
                  ),    ],
              ),


              SizedBox(
                height: 16,
              ),
            Row(children: [ SizedBox(width: width*.285,), sewnddata?
            Container(height: 100,width: 100,child: CircularProgressIndicator()):
            GestureDetector(
              onTap: () async {
                sewnddata=true;
                setState(() {

                });
                print(_dateTime);
                print(_dateTime);
                _allNetworking.add_doctor_out_reservation(
                    token_id: token,
                    name: name.text,
                    phone: phone.text,
                    address: addres.text,
                    from_hrs: starttime,to_hrs: endtime,
                    reservation_date:_dateTime).then((value) {
                  print(value);
                  Get.snackbar('', value.data["message"]);
                  sewnddata=false;
                  setState(() {

                  });
                });
              },
              child: Container(
                  width: width*.67,
                  height: 50,
                  decoration: BoxDecoration(
                      color: hexToColor('#00abeb'),
                      gradient: new LinearGradient(
                          colors: [
                            Colors.red[900],
                            Colors.red[100],
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(child: Text('حفظ'))),
            )],)
            ],
          ),
        ),
      ),
    );
  }
}
