import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truck_pro/utilities/app_colors.dart';
import 'package:truck_pro/utilities/screen_sizes.dart';
import 'package:uuid/uuid.dart';

import '../../models/chats_model.dart';
import '../../models/user_model.dart';

class ChatRoom extends StatefulWidget {
  final UserModel targetUser;
  final ChatroomModel chatRoom;
  final UserModel userModel;

  const ChatRoom({
    super.key,
    required this.targetUser,
    required this.chatRoom,
    required this.userModel,
  });

  @override
  ChatRoomState createState() => ChatRoomState();
}

class ChatRoomState extends State<ChatRoom> {
  TextEditingController messageController = TextEditingController();
  Uuid uuid = Uuid();

  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();

    if (msg != "") {
      MessageModel newMessage = MessageModel(
        messageId: uuid.v1(),
        sender: widget.userModel.id,
        createdon: DateTime.now().toString(),
        text: msg,
        seen: false,
      );

      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatRoom.chatroomId)
          .collection("messages")
          .doc(newMessage.messageId)
          .set(newMessage.toMap());

      widget.chatRoom.lastMessage = msg;
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatRoom.chatroomId)
          .set(widget.chatRoom.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.backGroundColor,
        foregroundColor: AppColors.whiteColor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              foregroundImage: NetworkImage(widget.targetUser.image.toString()),
              child: const CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.targetUser.name.toString(),
              style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatrooms")
                    .doc(widget.chatRoom.chatroomId)
                    .collection("messages")
                    .orderBy("createdOn", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;

                      return ListView.builder(
                        reverse: true,
                        itemBuilder: (context, index) {
                          MessageModel currentMessage = MessageModel.fromMap(
                              dataSnapshot.docs[index].data()
                                  as Map<String, dynamic>);

                          return (currentMessage.sender == widget.userModel.id)
                              //  FOR LOGGED IN USER
                              ? ListTile(
                                  trailing: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    foregroundImage: NetworkImage(
                                        widget.userModel.image.toString()),
                                    child: const CircularProgressIndicator(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          minWidth: 10,
                                          maxWidth: screenWidth(context) * 0.6,
                                          maxHeight: 1000000,
                                          minHeight: 10,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.blueColor,
                                        ),
                                        child: Text(
                                          currentMessage.text.toString(),
                                          maxLines: 20,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                  ),
                                )
                              //  FOR TARGET USER
                              : ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    foregroundImage: NetworkImage(
                                        widget.targetUser.image.toString()),
                                    child: const CircularProgressIndicator(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          constraints: BoxConstraints(
                                            minWidth: 10,
                                            maxWidth:
                                                screenWidth(context) * 0.6,
                                            maxHeight: 1000000,
                                            minHeight: 10,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.greyColor,
                                          ),
                                          child: Text(
                                              currentMessage.text.toString(),
                                              maxLines: 20,
                                              style: const TextStyle(
                                                color: AppColors.whiteColor,
                                              ))),
                                    ],
                                  ),
                                  // subtitle: (),
                                  trailing: const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                  ),
                                );
                        },
                        itemCount: dataSnapshot.docs.length,
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            "An error occoured! Please check your internet connection "),
                      );
                    } else {
                      return Center(
                        child: Text("Say Hi to ${widget.targetUser.name}"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            (widget.targetUser.role != "Admin")
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: messageController,
                            maxLines: null,
                            style: const TextStyle(color: AppColors.whiteColor),
                            decoration: InputDecoration(
                              hintText: "Enter Message...",
                              hintStyle: TextStyle(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.7)),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              sendMessage();
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.blueGrey,
                            ))
                      ],
                    ),
                  )
                : Container(height: 50)
          ],
        ),
      ),
    );
  }
}
