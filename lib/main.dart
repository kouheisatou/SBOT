import 'package:SBOT/common/bus_timetable_api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SBOT());
}

class SBOT extends StatelessWidget {
  const SBOT({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SBOT",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timetable sampleTimetable = Timetable();

  @override
  void initState() {
    sampleTimetable.fetchOperationTimetable(
        TimetableSeason.weekDayTimetable, TimetableType.busFromCampus,
        (timetable) {
      setState(() {
        sampleTimetable = timetable;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sampleTimetable.title)),
      body: Text(sampleTimetable.timetable.toString()),
    );
  }
}
