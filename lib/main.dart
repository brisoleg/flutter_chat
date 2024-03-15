import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _nickname = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _requestNickname(context));
  }

  void _requestNickname(BuildContext context) {
    TextEditingController nicknameController = TextEditingController();
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Enter your nickname'),
            content: CupertinoTextField(controller: nicknameController),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    _nickname = nicknameController.text;
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      var message = {
        "text": _messageController.text,
        "sender": _nickname,
        "time": FieldValue.serverTimestamp(), // Use server timestamp
      };

      // Send message to Firestore
      await FirebaseFirestore.instance.collection('messages').add(message);

      _messageController.clear();
      _focusNode
          .requestFocus(); // Keep the focus on the input field after sending a message
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  var messages = snapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message =
                          messages[index].data() as Map<String, dynamic>;
                      bool isMe = message['sender'] == _nickname;

                      String formattedTime = '';
                      if (message['time'] != null) {
                        Timestamp timestamp = message['time'] as Timestamp;
                        formattedTime = DateFormat('MM/dd/yyyy HH:mm:ss')
                            .format(timestamp.toDate());
                      }

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: isMe
                                    ? CupertinoColors.activeBlue
                                    : CupertinoColors.systemGrey,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Text(
                                message['text'] ?? '',
                                style: const TextStyle(
                                    color: CupertinoColors.white),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                formattedTime,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: CupertinoColors.systemGrey),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      placeholder: 'Type a message',
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      style: const TextStyle(color: CupertinoColors.black),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton(
                    padding: const EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(18),
                    child: const Icon(CupertinoIcons.arrow_up_circle_fill,
                        color: CupertinoColors.activeGreen),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
