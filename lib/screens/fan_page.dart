import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FanPage extends StatefulWidget {
  @override
  _FanPageState createState() => _FanPageState();
}

class _FanPageState extends State<FanPage> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Fan");
  bool fanOn = false;
  late Timer _timerOn, _timerOff;
  late DateTime _turnOnTime, _turnOffTime;

  @override
  void initState() {
    super.initState();
    _syncFanState();
  }

  // Lắng nghe trạng thái từ Firebase
  void _syncFanState() {
    dbRef.child("Switch").onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != null) {
        setState(() {
          fanOn = value as bool;
        });
      }
    });
  }

  // Cập nhật trạng thái quạt lên Firebase
  void updateFanState(bool state) {
    dbRef.set({"Switch": state});
  }

  // Hẹn giờ bật quạt
  void setFanOnTime(DateTime time) {
    _turnOnTime = time;
    _timerOn = Timer(_turnOnTime.difference(DateTime.now()), () {
      setState(() {
        fanOn = true;
        updateFanState(fanOn);
      });
    });
  }

  // Hẹn giờ tắt quạt
  void setFanOffTime(DateTime time) {
    _turnOffTime = time;
    _timerOff = Timer(_turnOffTime.difference(DateTime.now()), () {
      setState(() {
        fanOn = false;
        updateFanState(fanOn);
      });
    });
  }

  // Chọn thời gian bật quạt
  Future<void> selectTurnOnTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      // Lấy thời gian đã chọn và thiết lập giây là 0
      DateTime selectedTime = DateTime.now().copyWith(
        hour: time.hour,
        minute: time.minute,
        second: 0,  // Thêm phần giây vào thời gian đã chọn
      );
      setFanOnTime(selectedTime);
    }
  }

  // Chọn thời gian tắt quạt
  Future<void> selectTurnOffTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      // Lấy thời gian đã chọn và thiết lập giây là 0
      DateTime selectedTime = DateTime.now().copyWith(
        hour: time.hour,
        minute: time.minute,
        second: 0,  // Thêm phần giây vào thời gian đã chọn
      );
      setFanOffTime(selectedTime);
    }
  }

  @override
  void dispose() {
    _timerOn.cancel();
    _timerOff.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Control Fan")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              fanOn ? Icons.air : Icons.air_outlined,
              size: 100,
              color: fanOn ? Colors.blue : Colors.grey,
            ),
            SwitchListTile(
              title: Text("Fan"),
              value: fanOn,
              onChanged: (value) {
                setState(() {
                  fanOn = value;
                  updateFanState(fanOn);
                });
              },
            ),
            ElevatedButton(
              onPressed: selectTurnOnTime,
              child: Text("Set Turn On Time"),
            ),
            ElevatedButton(
              onPressed: selectTurnOffTime,
              child: Text("Set Turn Off Time"),
            ),
          ],
        ),
      ),
    );
  }
}
