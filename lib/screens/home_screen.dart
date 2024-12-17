// import 'package:flutter/material.dart';
// import 'light_page.dart';
// import 'fan_page.dart';
// import 'history_page.dart';
// import 'door_page.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//
//   // Danh sách các trang, thêm trang cửa vào đây
//   final List<Widget> _pages = [
//     LightPage(),
//     FanPage(),
//     HistoryPage(),
//     DoorPage(),  // Thêm trang cửa
//   ];
//
//   // Hàm cập nhật chỉ mục khi nhấn vào thanh công cụ
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Automation'),
//       ),
//       body: _pages[_selectedIndex],  // Hiển thị trang dựa trên chỉ mục đã chọn
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.lightbulb),
//             label: 'Đèn',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.toys),
//             label: 'Quạt',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'Lịch sử',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.door_front_door),  // Biểu tượng cho trang cửa
//             label: 'Cửa',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue, // Màu sắc của icon khi được chọn
//         unselectedItemColor: Colors.grey, // Màu sắc của icon khi không được chọn
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
