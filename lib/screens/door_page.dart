// import 'package:flutter/material.dart';
//
// class DoorPage extends StatefulWidget {
//   @override
//   _DoorPageState createState() => _DoorPageState();
// }
//
// class _DoorPageState extends State<DoorPage> {
//   bool isDoorOpen = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Text(
//             'Cửa: ${isDoorOpen ? 'Mở' : 'Đóng'}',
//             style: TextStyle(fontSize: 24),
//           ),
//           Switch(
//             value: isDoorOpen,
//             onChanged: (value) {
//               setState(() {
//                 isDoorOpen = value;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DoorPage extends StatefulWidget {
  @override
  _DoorPageState createState() => _DoorPageState();
}

class _DoorPageState extends State<DoorPage> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Door");
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      setState(() {
        isOpen = data?["Switch"] ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Door Status")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isOpen ? Icons.door_back_door : Icons.door_front_door_outlined,
              size: 100,
              color: isOpen ? Colors.green : Colors.red,
            ),
            Text(isOpen ? "Door is Open" : "Door is Closed"),
          ],
        ),
      ),
    );
  }
}
