import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/list_appointments_json.dart';

class List_Appointments extends StatefulWidget {
  @override
  _List_AppointmentsState createState() => _List_AppointmentsState();
}

class _List_AppointmentsState extends State<List_Appointments> {
  List<String> _list = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday'
  ];
  String dropdownValueeng = 'sunday';
  final box = GetStorage();
  AllNetworking _allNetworking = AllNetworking();
  String token;
  String dropdownValue = 'الاحد';
  TextEditingController _from = TextEditingController();
  TextEditingController _to = TextEditingController();

  @override
  void initState() {
    token = box.read('token');
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('المواعيد'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: high * .2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * .25,
                  child: mywidget(
                      hint: 'من الساعه',
                      inputtype: TextInputType.number,
                      textEditingController: _from),
                ),
                Container(
                  width: width * .25,
                  child: mywidget(
                      hint: 'الي الساعه',
                      inputtype: TextInputType.number,
                      textEditingController: _to),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      if (newValue == 'الاحد') {
                        dropdownValueeng = 'sunday';
                      } else if (newValue == 'الاثنين') {
                        dropdownValueeng = 'monday';
                      } else if (newValue == 'الثلات') {
                        dropdownValueeng =
                        'tuesday';
                      } else if (newValue == 'الاربعاء') {
                        dropdownValueeng =
                        'wednesday';
                      } else if (newValue == 'الخميس') {
                        dropdownValueeng =
                        'thursday';
                      } else if (newValue == 'الجمعة') {
                        dropdownValueeng =
                        'friday';
                      } else if (newValue == 'السبت') {
                        dropdownValueeng =
                        'saturday';
                      }
                    });
                  },
                  items: <String>[
                    'الاحد',
                    'الاثنين',
                    'الثلات',
                    'الاربعاء',
                    'الخميس',
                    'الجمعة',
                    'السبت'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                GestureDetector(onTap: () {
                  _allNetworking.add_appointment(token_id: token,
                      name: dropdownValue,
                      name_en: dropdownValueeng,
                      from_hrs: _from.text,
                      from_hrs_en:_from.text
                      ,
                      to_hrs: _to.text,
                      to_hrs_en: _to.text).then((value) {
                        print(value.data);
                        Get.snackbar('', value.data['message']);
                        setState(() {

                        });
                  });
                },
                  child: Container(
                      height: high * .1,
                      width: width * 0.2,
                      child: Center(
                        child: Text('حفظ',
                            style: TextStyle(
                                fontFamily: 'Arbf',
                                color: Colors.white,
                                fontSize: 25)),
                      ),
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
                          borderRadius: BorderRadius.circular(5.0))),
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List_appointments_json>(
                stream: _allNetworking
                    .list_appointments(token_id: token)
                    .asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(itemCount: snapshot.data.result.listAppointments.length,itemBuilder: (context, pos) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'اليوم',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(snapshot.data.result
                                          .listAppointments[pos].dayName),
                                      Text(snapshot.data.result
                                          .listAppointments[pos].dayNameEn),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'من الساعه',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(snapshot.data.result
                                          .listAppointments[pos].fromHrs),
                                      Text(snapshot.data.result
                                          .listAppointments[pos].fromHrsEn),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'الي الساعه',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(snapshot.data.result
                                          .listAppointments[pos].toHrs),
                                      Text(snapshot.data.result
                                          .listAppointments[pos].toHrs),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  GestureDetector(onTap: (){
                                    _allNetworking.delete_appointment(token_id: token, id_list:snapshot.data.result
                                        .listAppointments[pos].listId).then((value){
                                          setState(() {

                                          });
                                    } );

                                  },child: Icon(Icons.delete)),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget mywidget(
      {hint, inputtype, TextEditingController textEditingController}) {
    return TextFormField(
      keyboardType: inputtype,
      controller: textEditingController,
      //   textAlign: TextAlign.center,
      maxLines: null,
      style: TextStyle(
        fontFamily: 'Arbf',
        color: hexToColor('#ed1c6f'),
      ),
      decoration: InputDecoration(
        labelText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'Arbf',
          color: hexToColor('#ed1c6f'),
        ),
      ),
    );
  }
}
