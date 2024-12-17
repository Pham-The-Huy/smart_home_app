import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class LightsPage extends StatefulWidget {
  @override
  _LightsPageState createState() => _LightsPageState();
}

class _LightsPageState extends State<LightsPage> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Light");
  bool light1On = false;
  bool light2On = false;
  bool bothLightsOn = false;

  TimeOfDay? light1OnTime, light1OffTime;
  TimeOfDay? light2OnTime, light2OffTime;
  TimeOfDay? bothLightsOnTime, bothLightsOffTime;

  @override
  void initState() {
    super.initState();
    _syncLightStates();
  }

  // Lắng nghe trạng thái từ Firebase
  void _syncLightStates() {
    dbRef.child("Light1").child("Switch").onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != null) {
        setState(() {
          light1On = value as bool;
        });
      }
    });

    dbRef.child("Light2").child("Switch").onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != null) {
        setState(() {
          light2On = value as bool;
        });
      }
    });
  }

  // Cập nhật trạng thái đèn lên Firebase
  void updateLightState(String light, bool state) {
    dbRef.child(light).set({"Switch": state});
  }

  // Cập nhật trạng thái cho cả hai đèn
  void updateBothLightsState(bool state) {
    updateLightState("Light1", state);
    updateLightState("Light2", state);
  }

  // Thiết lập hẹn giờ bật tắt cho từng đèn
  void setTimerForLight(TimeOfDay? onTime, TimeOfDay? offTime, String light) {
    if (onTime != null && offTime != null) {
      // Tính toán thời gian cho bật/tắt
      DateTime now = DateTime.now();
      DateTime onDateTime = DateTime(now.year, now.month, now.day, onTime.hour, onTime.minute);
      DateTime offDateTime = DateTime(now.year, now.month, now.day, offTime.hour, offTime.minute);

      // Kiểm tra xem thời gian bật/tắt có qua ngày không
      if (onDateTime.isBefore(now)) {
        onDateTime = onDateTime.add(Duration(days: 1));
      }
      if (offDateTime.isBefore(now)) {
        offDateTime = offDateTime.add(Duration(days: 1));
      }

      // Hẹn giờ bật đèn
      Timer(onDateTime.difference(now), () {
        setState(() {
          if (light == "Light1") light1On = true;
          if (light == "Light2") light2On = true;
          updateLightState(light, true);
        });
      });

      // Hẹn giờ tắt đèn
      Timer(offDateTime.difference(now), () {
        setState(() {
          if (light == "Light1") light1On = false;
          if (light == "Light2") light2On = false;
          updateLightState(light, false);
        });
      });
    }
  }

  // Hẹn giờ bật tắt cả hai đèn
  void setTimerForBothLights(TimeOfDay? onTime, TimeOfDay? offTime) {
    if (onTime != null && offTime != null) {
      DateTime now = DateTime.now();
      DateTime onDateTime = DateTime(now.year, now.month, now.day, onTime.hour, onTime.minute);
      DateTime offDateTime = DateTime(now.year, now.month, now.day, offTime.hour, offTime.minute);

      // Kiểm tra thời gian qua ngày
      if (onDateTime.isBefore(now)) {
        onDateTime = onDateTime.add(Duration(days: 1));
      }
      if (offDateTime.isBefore(now)) {
        offDateTime = offDateTime.add(Duration(days: 1));
      }

      // Hẹn giờ bật cả hai đèn
      Timer(onDateTime.difference(now), () {
        setState(() {
          bothLightsOn = true;
          updateBothLightsState(true);
        });
      });

      // Hẹn giờ tắt cả hai đèn
      Timer(offDateTime.difference(now), () {
        setState(() {
          bothLightsOn = false;
          updateBothLightsState(false);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Control Lights")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Điều khiển đèn 1
            _buildLightControl("Light 1", light1On, (value) {
              setState(() {
                light1On = value;
                updateLightState("Light1", light1On);
              });
            }),
            _buildTimePicker("Set Timer for Light 1", (time) {
              setState(() {
                light1OnTime = time;
              });
              if (light1OnTime != null && light1OffTime != null) {
                setTimerForLight(light1OnTime, light1OffTime, "Light1");
              }
            }, light1OnTime, (time) {
              setState(() {
                light1OffTime = time;
              });
              if (light1OnTime != null && light1OffTime != null) {
                setTimerForLight(light1OnTime, light1OffTime, "Light1");
              }
            }),

            // Điều khiển đèn 2
            _buildLightControl("Light 2", light2On, (value) {
              setState(() {
                light2On = value;
                updateLightState("Light2", light2On);
              });
            }),
            _buildTimePicker("Set Timer for Light 2", (time) {
              setState(() {
                light2OnTime = time;
              });
              if (light2OnTime != null && light2OffTime != null) {
                setTimerForLight(light2OnTime, light2OffTime, "Light2");
              }
            }, light2OnTime, (time) {
              setState(() {
                light2OffTime = time;
              });
              if (light2OnTime != null && light2OffTime != null) {
                setTimerForLight(light2OnTime, light2OffTime, "Light2");
              }
            }),

            // Điều khiển cả hai đèn
            _buildLightControl("Both Lights", bothLightsOn, (value) {
              setState(() {
                bothLightsOn = value;
                updateBothLightsState(bothLightsOn);
              });
            }),
            _buildTimePicker("Set Timer for Both Lights", (time) {
              setState(() {
                bothLightsOnTime = time;
              });
              if (bothLightsOnTime != null && bothLightsOffTime != null) {
                setTimerForBothLights(bothLightsOnTime, bothLightsOffTime);
              }
            }, bothLightsOnTime, (time) {
              setState(() {
                bothLightsOffTime = time;
              });
              if (bothLightsOnTime != null && bothLightsOffTime != null) {
                setTimerForBothLights(bothLightsOnTime, bothLightsOffTime);
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLightControl(String label, bool state, Function(bool) onChanged) {
    return Column(
      children: [
        Icon(
          state ? Icons.lightbulb : Icons.lightbulb_outline,
          size: 100,
          color: state ? Colors.amber : Colors.grey,
        ),
        SwitchListTile(
          title: Text(label),
          value: state,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Hiển thị bộ chọn thời gian
  Widget _buildTimePicker(String label, Function(TimeOfDay) onTimeSelected, TimeOfDay? initialOnTime, Function(TimeOfDay) onOffTimeSelected) {
    return Column(
      children: [
        Text(label),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: initialOnTime ?? TimeOfDay.now(),
                );
                if (time != null) onTimeSelected(time);
              },
              child: Text('Set On Time'),
            ),
            TextButton(
              onPressed: () async {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: initialOnTime ?? TimeOfDay.now(),
                );
                if (time != null) onOffTimeSelected(time);
              },
              child: Text('Set Off Time'),
            ),
          ],
        ),
      ],
    );
  }
}
