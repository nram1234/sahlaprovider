import 'package:flutter/material.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_list_notifications_JSON.dart';

class NotifictionDetSCR extends StatefulWidget {
  AllNotifications _allNotifications;

  NotifictionDetSCR(this._allNotifications);

  @override
  _NotifictionSCRState createState() => _NotifictionSCRState();
}

class _NotifictionSCRState extends State<NotifictionDetSCR> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          title: Text(widget._allNotifications.title),
        ),
        body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(widget._allNotifications.createdAt),
                  Text(
                    widget._allNotifications.body,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ));
          }
        ),
      ),
    );
  }
}
