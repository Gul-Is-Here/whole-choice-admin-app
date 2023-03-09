import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whole_choice_admin_pannel/controller/chat_controller.dart';
import 'package:whole_choice_admin_pannel/services/store_services.dart';
import 'package:whole_choice_admin_pannel/views/messages/components/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:whole_choice_admin_pannel/views/widgets/loading_indcator.dart';

import '../../const/const.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkGrey),
          onPressed: () {
            Get.back();
          },
        ),
        title: "${controller.friendName}".text.color(purpleColor).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: StoreService.getChatMessages(
                    controller.chatDocId.toString()),
                // initialData: initialData,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: loadingIndicator());
                  } else {
                    return ListView(
                      children:
                          snapshot.data!.docs.mapIndexed((currentValue, index) {
                        var data = snapshot.data!.docs[index];
                        return Align(
                            alignment: data['uid'] == currentUser!.uid
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: senderBubble(data));
                      }).toList(),
                    );
                  }
                },
              ),
              // child: ListView.builder(
              //     itemCount: 20,
              //     itemBuilder: (context, index) {
              //       return chatBubble(data);
              //     }),
            ),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: controller.msgController,
                    cursorColor: purpleColor,
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        controller.sendMsg(controller.msgController.text);
                        controller.msgController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: purpleColor,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
