// import 'dart:async';
// import 'package:flutter/material.dart';
//
// class TimerControl extends StatefulWidget {
//   final String deviceName;
//   final Function(bool) onToggle; // Callback để bật/tắt thiết bị
//
//   TimerControl({required this.deviceName, required this.onToggle});
//
//   @override
//   _TimerControlState createState() => _TimerControlState();
// }
//
// class _TimerControlState extends State<TimerControl> {
//   int hours = 0;
//   int minutes = 0;
//   int seconds = 0;
//   Timer? _timer;
//   bool isTimerRunning = false;
//
//   void startTimer() {
//     // Tính tổng thời gian hẹn giờ (giây)
//     int totalSeconds = hours * 3600 + minutes * 60 + seconds;
//
//     if (totalSeconds > 0) {
//       setState(() {
//         isTimerRunning = true;
//       });
//
//       _timer = Timer(Duration(seconds: totalSeconds), () {
//         widget.onToggle(true); // Bật thiết bị khi hết thời gian
//         setState(() {
//           isTimerRunning = false;
//         });
//       });
//     }
//   }
//
//   void cancelTimer() {
//     _timer?.cancel();
//     widget.onToggle(false); // Tắt thiết bị nếu hủy hẹn giờ
//     setState(() {
//       isTimerRunning = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.deviceName,
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 16),
//         Row(
//           children: [
//             // Chọn giờ
//             Expanded(
//               child: TextField(
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Giờ'),
//                 onChanged: (value) {
//                   setState(() {
//                     hours = int.tryParse(value) ?? 0;
//                   });
//                 },
//               ),
//             ),
//             // Chọn phút
//             Expanded(
//               child: TextField(
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Phút'),
//                 onChanged: (value) {
//                   setState(() {
//                     minutes = int.tryParse(value) ?? 0;
//                   });
//                 },
//               ),
//             ),
//             // Chọn giây
//             Expanded(
//               child: TextField(
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Giây'),
//                 onChanged: (value) {
//                   setState(() {
//                     seconds = int.tryParse(value) ?? 0;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         isTimerRunning
//             ? ElevatedButton(
//           onPressed: cancelTimer,
//           child: Text('Hủy Hẹn Giờ'),
//         )
//             : ElevatedButton(
//           onPressed: startTimer,
//           child: Text('Bắt Đầu Hẹn Giờ'),
//         ),
//       ],
//     );
//   }
// }
