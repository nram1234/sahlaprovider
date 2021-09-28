import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/hexToColor%D9%90Convert.dart';
import 'package:sahlaprovider/utilitie/jsondata/tags_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TagsScreen extends StatefulWidget {
  @override
  _TagsScreenState createState() => _TagsScreenState();
}

final box = GetStorage();
int limit = 1000;
int sizelist = 0;

ScrollController _scrollController;

class _TagsScreenState extends State<TagsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (sizelist > 8) {
        limit = limit + 20;
        setState(() {});
        // getallp(
        //     limit: limit.toString().toString(),
        //     page_number: 0.toString(),
        //     token_id: token,
        //     phone: phone);
      }
    }
  }

  var tagNameController = TextEditingController();
  var editTagNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('الكلمات البحثية'),
        ),
        body: StreamBuilder<TagsModel>(
          stream: AllNetworking()
              .getAllTags(
                  token_id: box.read('token'),
                  pageNumber: 0.toString(),
                  limit: limit.toString())
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              sizelist = snapshot.data.result.allListLocation.length;
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "اضف كلمة بحثية",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextField(
                                    controller: tagNameController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    AllNetworking()
                                        .addTags(
                                            token_id: box.read('token'),
                                            tagName: tagNameController.text)
                                        .then((value) {
                                      Navigator.pop(context);
                                      tagNameController.text = "";
                                      Fluttertoast.showToast(
                                          msg: "تمت الاضافة");
                                    });
                                    setState(() {});
                                  },
                                  child: Container(
                                      height: hight * .05,
                                      width: width * 0.4,
                                      child: Center(
                                        child: Text('اضافة',
                                            style: TextStyle(
                                                fontFamily: 'Arbf',
                                                color: Colors.white,
                                                fontSize: 18)),
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
                                          borderRadius:
                                              BorderRadius.circular(40.0))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                        height: hight * .05,
                        width: width * 0.4,
                        child: Center(
                          child: Text('اضافه كلمة بحثية',
                              style: TextStyle(
                                  fontFamily: 'Arbf',
                                  color: Colors.white,
                                  fontSize: 18)),
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
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            buildTagItem(snapshot, index, hight, width),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: snapshot.data.result.allListLocation.length),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget buildTagItem(AsyncSnapshot<TagsModel> snapshot, index, hight, width) =>
      ListTile(
        title: Text(snapshot.data.result.allListLocation[index].tagName),
        trailing: IntrinsicWidth(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    var editTagNameController = TextEditingController(
                        text: snapshot
                            .data.result.allListLocation[index].tagName);
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "عدل كلمة بحثية",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  controller: editTagNameController,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  AllNetworking()
                                      .editTags(
                                          token_id: box.read('token'),
                                          tagId: snapshot.data.result
                                              .allListLocation[index].tagId,
                                          tagName: editTagNameController.text)
                                      .then((value) {
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(msg: "تمت التعديل");
                                  });
                                  setState(() {});
                                },
                                child: Container(
                                    height: hight * .05,
                                    width: width * 0.4,
                                    child: Center(
                                      child: Text('تعديل',
                                          style: TextStyle(
                                              fontFamily: 'Arbf',
                                              color: Colors.white,
                                              fontSize: 18)),
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
                                        borderRadius:
                                            BorderRadius.circular(40.0))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    AllNetworking()
                        .deleteTags(
                            token_id: box.read('token'),
                            tagId: snapshot
                                .data.result.allListLocation[index].tagId)
                        .then((value) {
                      Fluttertoast.showToast(msg: "تمت الحذف");
                    });
                    setState(() {});
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
        ),
      );
}
