import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/jsondata/Get_notification_details_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_list_notifications_JSON.dart';

class NotifictionDetSCR extends StatefulWidget {
  AllNotifications _allNotifications;

  NotifictionDetSCR(this._allNotifications);

  @override
  _NotifictionSCRState createState() => _NotifictionSCRState();
}

class _NotifictionSCRState extends State<NotifictionDetSCR> {
  final box = GetStorage();
  AllNetworking _allNetworking = AllNetworking();
  String token;

  @override
  void initState() {
    token = box.read('token');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget._allNotifications.title),

        ),
        body: StreamBuilder<Get_notification_details_json>(
            stream: _allNetworking
                .get_notification_details(
                    token_id: token, id_notify: widget._allNotifications.id)
                .asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(snapshot
                                .data.result.notificationDetails.createdAt))),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          snapshot.data.result.notificationDetails.body,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),


              FadeInImage.assetNetwork(
              placeholder: 'assets/images//load.gif',
              image: snapshot
                  .data.result.notificationDetails.img,
              )


              ]
              );
              } else                                                                     {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
