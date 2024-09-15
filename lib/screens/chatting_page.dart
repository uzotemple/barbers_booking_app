import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> barbers = [
    {'name': 'Barber 1', 'image': 'images/barber.jpg'},
    {'name': 'Barber 2', 'image': 'images/barber.jpg'},
    {'name': 'Barber 3', 'image': 'images/barber.jpg'},
    {'name': 'Barber 4', 'image': 'images/barber.jpg'},
    {'name': 'Barber 5', 'image': 'images/barber.jpg'},
    {'name': 'Barber 6', 'image': 'images/barber.jpg'},
    {'name': 'Barber 7', 'image': 'images/barber.jpg'},
    {'name': 'Barber 8', 'image': 'images/barber.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: barbers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(barbers[index]['image']!),
              ),
              title: Text(barbers[index]['name']!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BarberChatScreen(
                      barberName: barbers[index]['name']!,
                      barberImage: barbers[index]['image']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BarberChatScreen extends StatefulWidget {
  final String barberName;
  final String barberImage;

  const BarberChatScreen({
    super.key,
    required this.barberName,
    required this.barberImage,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BarberChatScreenState createState() => _BarberChatScreenState();
}

class _BarberChatScreenState extends State<BarberChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _messageController.text,
          'sender': 'customer', // or 'barber' based on the user role
          'timestamp': DateTime.now(),
          'sent': true, // Message sent status
          'isRead': false, // Message read status initially false
        });
        _messageController.clear();
      });
    }
  }
  Widget _buildMessage(Map<String, dynamic> message, int index) {
  bool isCustomer = message['sender'] == 'customer';
  return Align(
    alignment: isCustomer ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),  // Limit max width
      decoration: BoxDecoration(
        color: isCustomer ? Colors.blueAccent : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message['text'],
            style: TextStyle(
              color: isCustomer ? Colors.white : Colors.black87,
            ),
            overflow: TextOverflow.visible,  // Ensure text is not cut off
          ),
          if (isCustomer)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  message['isRead'] ? Icons.done_all : Icons.check, // Show checkmarks
                  size: 16.0,
                  color: message['isRead'] ? Colors.white : Colors.white54,
                ),
              ],
            ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.barberImage),
            ),
            const SizedBox(width: 8),
            Text(widget.barberName),
          ],
        ),
        backgroundColor: const Color(0xFF001F5F),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index], index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      filled: true,
                      // fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: const Color(0xFF001F5F),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}


// import 'dart:async';  // Import this for Timer

// import 'package:flutter/material.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final List<Map<String, String>> barbers = [
//     {'name': 'Barber 1', 'image': 'images/barber.jpg'},
//     {'name': 'Barber 2', 'image': 'images/barber.jpg'},
//     {'name': 'Barber 3', 'image': 'images/barber.jpg'},
//     {'name': 'Barber 4', 'image': 'images/barber.jpg'},
//     {'name': 'Barber 5', 'image': 'images/barber.jpg'},
//     {'name': 'Barber 6', 'image': 'images/barber.jpg'},
//     {'name': 'Barber 7', 'image': 'images/barber.jpg'},
//     {'name': 'Barber 8', 'image': 'images/barber.jpg'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: barbers.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: AssetImage(barbers[index]['image']!),
//               ),
//               title: Text(barbers[index]['name']!),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BarberChatScreen(
//                       barberName: barbers[index]['name']!,
//                       barberImage: barbers[index]['image']!,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class BarberChatScreen extends StatefulWidget {
//   final String barberName;
//   final String barberImage;

//   const BarberChatScreen({
//     super.key,
//     required this.barberName,
//     required this.barberImage,
//   });

//   @override
//   // ignore: library_private_types_in_public_api
//   _BarberChatScreenState createState() => _BarberChatScreenState();
// }

// class _BarberChatScreenState extends State<BarberChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final List<Map<String, dynamic>> _messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _simulateIncomingMessages(); // Start simulating incoming messages
//   }

//   void _sendMessage() {
//     if (_messageController.text.isNotEmpty) {
//       setState(() {
//         _messages.add({
//           'text': _messageController.text,
//           'sender': 'customer',
//           'timestamp': DateTime.now(),
//           'sent': true,
//           'isRead': false,
//         });
//         _messageController.clear();
//       });
//     }
//   }

//   void _simulateIncomingMessages() {
//     Timer.periodic(const Duration(seconds: 120), (Timer timer) {
//       setState(() {
//         _messages.add({
//           'text': 'This is a simulated response message.',
//           'sender': 'barber',
//           'timestamp': DateTime.now(),
//           'sent': false,
//           'isRead': false,
//         });
//       });
//     });
//   }

//   Widget _buildMessage(Map<String, dynamic> message, int index) {
//     bool isCustomer = message['sender'] == 'customer';
//     return Align(
//       alignment: isCustomer ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         padding: const EdgeInsets.all(10.0),
//         margin: const EdgeInsets.symmetric(vertical: 5.0),
//         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
//         decoration: BoxDecoration(
//           color: isCustomer ? Colors.blueAccent : Colors.grey.shade300,
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               message['text'],
//               style: TextStyle(
//                 color: isCustomer ? Colors.white : Colors.black87,
//               ),
//               overflow: TextOverflow.visible,
//             ),
//             if (isCustomer)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Icon(
//                     message['isRead'] ? Icons.done_all : Icons.check,
//                     size: 16.0,
//                     color: message['isRead'] ? Colors.white : Colors.white54,
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Colors.white,
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: AssetImage(widget.barberImage),
//             ),
//             const SizedBox(width: 8),
//             Text(widget.barberName),
//           ],
//         ),
//         backgroundColor: const Color(0xFF001F5F),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(10.0),
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return _buildMessage(_messages[index], index);
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     minLines: 1,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message',
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8.0),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   color: const Color(0xFF001F5F),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }
// }
