import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truck_pro/utilities/app_colors.dart';
import 'package:truck_pro/utilities/constants.dart';
import 'package:truck_pro/view/Chats/chatroom.dart';

import '../../models/chats_model.dart';
import '../../models/user_model.dart';
import '../../res/helpers/firebase_helper.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        title: Text(
          "Chats",
          style: headingSM,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .where("participants.${UserModel.loggedinUser!.id}",
                      isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    QuerySnapshot chatRoomSnapshot =
                        snapshot.data as QuerySnapshot;
                    return (chatRoomSnapshot.docs.length == 0)
                        ? Center(
                            child: Text(
                              "No Chats",
                              style: headingSM,
                            ),
                          )
                        : ListView.builder(
                            itemCount: chatRoomSnapshot.docs.length,
                            itemBuilder: (context, index) {
                              ChatroomModel chatRoomModel =
                                  ChatroomModel.fromMap(
                                      chatRoomSnapshot.docs[index].data()
                                          as Map<String, dynamic>);
                              Map<String, dynamic> participants =
                                  chatRoomModel.participants!;
                              List<String> participantKeys =
                                  participants.keys.toList();
                              participantKeys
                                  .remove(UserModel.loggedinUser!.id);
                              return FutureBuilder(
                                future: FirebaseHelper.getUserModelById(
                                    participantKeys[0]),
                                builder: (context, userData) {
                                  if (userData.connectionState ==
                                      ConnectionState.done) {
                                    if (userData.data != null) {
                                      UserModel targetUser =
                                          userData.data as UserModel;
                                      return ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return ChatRoom(
                                                chatRoom: chatRoomModel,
                                                userModel:
                                                    UserModel.loggedinUser!,
                                                targetUser: targetUser,
                                              );
                                            }),
                                          );
                                        },
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          foregroundImage: NetworkImage(
                                              targetUser.image.toString()),
                                          child:
                                              const CircularProgressIndicator(),
                                        ),
                                        title: Row(
                                          children: [
                                            Text(
                                              targetUser.name.toString(),
                                              style: const TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            (targetUser.id ==
                                                    'tBuAzA90NffCXIyfMiKR0Nw3RHc2')
                                                ? SizedBox(
                                                    height: 20,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Image.asset(
                                                          'assets/verify.png'),
                                                    ))
                                                : const Text('')
                                          ],
                                        ),
                                        subtitle: (chatRoomModel.lastMessage
                                                    .toString() !=
                                                "")
                                            ? Text(chatRoomModel.lastMessage
                                                .toString())
                                            : const Text(
                                                "Start a conversation",
                                                style: TextStyle(
                                                    color: AppColors.greyColor),
                                              ),
                                        trailing: IconButton(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          onPressed: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) {
                                            //       return ViewProfile(
                                            //         userModel: widget.userModel,
                                            //         firebaseUser: widget.firebaseUser,
                                            //         targetUserModel: targetUser,
                                            //       );
                                            //     },
                                            //   ),
                                            // );
                                          },
                                          icon: const Icon(
                                            Icons.person,
                                            size: 40.0,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            },
                          );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Chats",
                        style: headingSM,
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
