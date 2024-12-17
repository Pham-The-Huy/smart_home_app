import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class PumpPage extends StatefulWidget {
  @override
  _PumpPageState createState() => _PumpPageState();
}

class _PumpPageState extends State<PumpPage> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Pump");
  bool pumpOn = false;

  void updatePumpState(bool state) {
    dbRef.set({"Switch": state});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Control Pump")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              pumpOn ? Icons.water_drop : Icons.water_drop_outlined,
              size: 100,
              color: pumpOn ? Colors.lightBlue : Colors.grey,
            ),
            SwitchListTile(
              title: Text("Pump"),
              value: pumpOn,
              onChanged: (value) {
                setState(() {
                  pumpOn = value;
                  updatePumpState(pumpOn);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
