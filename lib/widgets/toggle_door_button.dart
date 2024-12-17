// import 'package:flutter/material.dart';
//
// class ToggleDoorButton extends StatelessWidget {
//   final bool isDoorOpen;
//   final VoidCallback onToggle;
//
//   ToggleDoorButton({required this.isDoorOpen, required this.onToggle});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onToggle,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: isDoorOpen ? Colors.red : Colors.green,
//         padding: EdgeInsets.symmetric(vertical: 16.0),
//       ),
//       child: Text(
//         isDoorOpen ? 'Close Door' : 'Open Door',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }
// }
