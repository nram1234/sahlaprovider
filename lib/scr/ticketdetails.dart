
import 'package:sahlaprovider/myWidget/myDrawer.dart';
import 'package:sahlaprovider/netWORK/allnetworking.dart';
import 'package:sahlaprovider/utilitie/jsondata/ticket_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:get_storage/get_storage.dart';

class TicketDetails extends StatefulWidget {
  int ticket_id;

  TicketDetails(this.ticket_id);

  @override
  _TicketDetailsState createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  TextEditingController masg=TextEditingController();
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String token;

  @override
  void initState() {
    super.initState();

    token = box.read('token');
    print('oooooooooooooooooooooooooooooooo');
    print(token);
    print('oooooooooooooooooooooooooooooooo');
  }
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: mydrawer(context),
      appBar: AppBar(elevation: 8,actions: [GestureDetector(
        onTap: () {
          Navigator.pop(context, false);
        }, child: Icon(Icons.arrow_forward_outlined),)
      ],
        centerTitle: true,
        title: Text('ﺗﻔﺎﺻﻴﻞ ﺍﻟﺘﺬﻛﺮﺓ'),
      ),
      body: Column(children: [StreamBuilder<Ticket_json>(
        stream:_allNetworking.ticket(token_id: token, ticket_id: widget.ticket_id).asStream(),
        builder: (context, snapshot) {
         if(snapshot.hasData){ return Expanded(
           child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: ListView.builder(  controller: _scrollController,itemCount: snapshot.data.result.ticketInfo.ticketReplies.length, itemBuilder: (context, pos) {
               return Padding(
                 padding: const EdgeInsets.only(bottom: 8),
                 child: MessageBubble(str:snapshot.data.result.ticketInfo.ticketReplies[pos].content,sender:   snapshot.data.result.ticketInfo.ticketReplies[pos].senderType   ),
               );
             }),
           ),
         );}else{return CircularProgressIndicator();}
        }
      ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(
                    5.0) //                 <--- border radius here
                ),
              ),
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextFormField(controller: masg,
                        decoration: InputDecoration(
                            hintText: '  اكتب رسالتك هنا  ',
                            hintStyle:
                            TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async{if(masg.text!=null){
                        String mm=masg.text;



_allNetworking.new_reply(token_id: token, ticket_id: widget.ticket_id, content: masg.text).then((value) {
  _scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    curve: Curves.easeOut,
    duration: const Duration(milliseconds: 10),
  );
  masg.clear();
  setState(() {

  });
  print (value.data);
});




                      }

                      }, child: Icon(Icons.send))
                ],
              )),
        )],)
    );
  }

  Widget MessageBubble({str, int sender}) {
    if (sender == 0) {
      return ChatBubble(
        clipper: ChatBubbleClipper2(
            type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.blue,
        child: Container(
          constraints: BoxConstraints(
            maxWidth:
            MediaQuery
                .of(context)
                .size
                .width * 0.7,
          ),
          child: Text(
            str,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return ChatBubble(
        clipper: ChatBubbleClipper2(
            type: BubbleType.receiverBubble),
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth:
            MediaQuery
                .of(context)
                .size
                .width * 0.7,
          ),
          child: Text(
            str,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }}
