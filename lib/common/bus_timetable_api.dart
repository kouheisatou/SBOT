import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  Timetable().fetchOperationTimetable(
    TimetableSeason.weekDayTimetable,
    TimetableType.busFromCampus,
    (timetable) {
      print(timetable.timetable);
      print(timetable.title);
    },
  );
}

class TimetableSeason {
  static const int weekDayTimetable = 0;
  static const int holidayTimetable = 1;
  static const int summerVacationWeekDayTimetable = 2;
  static const int summerVacationHolidayTimetable = 3;
}

class TimetableType {
  static const String busFromCampus = "bus_left";
  static const String bsuFromHigashiOmiyaStation = "bus_right";
  static const String trainForUtsunomiya = "bus_right";
  static const String trainForOmiya = "bus_right";
}

class Timetable {
  late Map<String, List<String>> timetable;
  late String title;

  Future<void> fetchOperationTimetable(
    int timetableSeason,
    String timetableType,
    Function(Timetable timetable) onFinished,
  ) async {
    timetable = {};
    final response = await http.get(
      Uri.parse("http://bus.shibaura-it.ac.jp/db/bus_data.json"),
    );

    Map<String, dynamic> json = jsonDecode(response.body);

    List<dynamic> timetableRows = json["timesheet"][timetableSeason]["list"];
    for (var row in timetableRows) {
      String hour = row["time"];
      String minutesString = row[timetableType]["num1"];
      timetable[hour] = minutesString.split(".");
    }

    title = json["timesheet"][timetableSeason]["title"];

    onFinished(this);
  }
}
