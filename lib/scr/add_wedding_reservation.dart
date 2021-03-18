import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
class Add_Wedding_Reservation extends StatefulWidget {
  @override
  _Add_Wedding_ReservationState createState() => _Add_Wedding_ReservationState();
}

class _Add_Wedding_ReservationState extends State<Add_Wedding_Reservation> {
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
      appBar: AppBar(title: Text('حجز  '),centerTitle: true,),
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
                height: 8,
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
                height: 8,
              ),  Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phone,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'التلفون'),
                ),
              ),
              SizedBox(
                height: 8,
              ),

              Container(
                width: width,
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'التاريخ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () async {
                  await showDatePicker(
                      context: context,
                      initialDate: _dateTime,
                      firstDate: _dateTime,
                      lastDate: DateTime(2035))
                      .then((value) {
                    _dateTime = value;
                    setState(() {});
                  });
                },
                child: Container(
                    width: width,
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
              SizedBox(
                height: 8,
              ),
              sewnddata? Container(height: 100,width: 100,child: CircularProgressIndicator()):  GestureDetector(
                onTap: () async {
                  sewnddata=true;
                  setState(() {

                  });
                  print(_dateTime);
                  print(_dateTime);
                  _allNetworking. add_wedding_reservation(
                      token_id: token,
                      name: name.text,
                      phone: phone.text,
                      address: addres.text,

                      reservation_date:_dateTime).then((value) {
                    print(value);
                    sewnddata=false;
                    setState(() {

                    });
                  });
                },
                child: Container(
                    width: width,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
