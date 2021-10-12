import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/tickets_types_json.dart';

class ContactWithManager extends StatefulWidget {
  BuildContext mycontext;

  ContactWithManager({this.mycontext});

  @override
  _ContactWithManagerState createState() => _ContactWithManagerState();
}

class _ContactWithManagerState extends State<ContactWithManager> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String data = '';
  String title = '';
  bool senddata = false;
  String token;
  bool getdata = true;
  @override
  void initState() {
    super.initState();
    token = box.read('token');
    _allNetworking.tickets_types(token_id: token).then((value) {
      dataaa = value.result.ticketsTypes;
      getdata = false;
      setState(() {});
    });
  }

  TicketsTypes dropdownValue;
  List<TicketsTypes> dataaa = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Mydrawer(), // mydrawer(context),
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context, false);
            },
            child: Icon(Icons.arrow_forward_outlined),
          )
        ],
        centerTitle: true,
        title: Text('تواصل مع الادارة'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: Text(
                  "انشاء ﺗﺬﻛﺮﺓ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                child: getdata
                    ? CircularProgressIndicator()
                    : DropdownButton<TicketsTypes>(
                        value: dropdownValue,
                        hint: Text('نوع التذكرة'),
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (TicketsTypes newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: dataaa.map<DropdownMenuItem<TicketsTypes>>(
                            (TicketsTypes value) {
                          return DropdownMenuItem<TicketsTypes>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'عنوان',
                    ),
                    onChanged: (st) {
                      title = st;
                    },
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: 'الرسالة'),
                        onChanged: (st) {
                          data = st;
                        },
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.right,
                        maxLines: null,
                        style: TextStyle(
                          fontFamily: 'Arbf',
                          color: hexToColor('#ed1c6f'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              senddata
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () {
                        if (!data.trim().isEmpty && !title.trim().isEmpty) {
                          senddata = true;
                          setState(() {});
                          _allNetworking
                              .new_ticket(
                                  token_id: token,
                                  ticket_type_id: dropdownValue.id,
                                  title: title,
                                  content: data)
                              .then((value) {
                            Navigator.pop(widget.mycontext);
                            print(value.data);
                            senddata = false;
                            setState(() {});
                          });
                        }
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                            child: Text('ﺍﺭﺳﺎﻝ',
                                style: TextStyle(
                                    fontFamily: 'Arbf',
                                    color: Colors.white,
                                    fontSize: 25)),
                          ),
                          decoration: BoxDecoration(
                              color: hexToColor('#00abeb'),
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.red[100],
                                    Colors.red[900],
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  tileMode: TileMode.clamp),
                              borderRadius: BorderRadius.circular(40.0))),
                    )
            ],
          )),
    );
  }
}
