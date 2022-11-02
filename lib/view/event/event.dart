import 'dart:math';

import 'package:flutter/material.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Event extends StatefulWidget {
  Event({Key key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  _DataSource events;

  @override
  void initState() {
    events = _DataSource(_getAppointments());
    super.initState();
  }

  List<Appointment> _getAppointments() {
    final List<String> subjectCollection = <String>[];
    subjectCollection.add('General Meeting');
    subjectCollection.add('Plan Execution');
    subjectCollection.add('Project Plan');
    subjectCollection.add('Consulting');
    subjectCollection.add('Support');
    subjectCollection.add('Development Meeting');
    subjectCollection.add('Project Completion');
    subjectCollection.add('Release updates');
    subjectCollection.add('Performance Check');

    final List<Color> colorCollection = <Color>[];
    colorCollection.add(Color(0xFF0F8644));
    colorCollection.add(Color(0xFF8B1FA9));
    colorCollection.add(Color(0xFFD20100));
    colorCollection.add(Color(0xFFFC571D));
    colorCollection.add(Color(0xFF36B37B));
    colorCollection.add(Color(0xFF01A1EF));
    colorCollection.add(Color(0xFF3D4FB5));
    colorCollection.add(Color(0xFFE47C73));
    colorCollection.add(Color(0xFF636363));
    colorCollection.add(Color(0xFF0A8043));

    final Random random = Random();
    final DateTime rangeStartDate =
        DateTime.now().add(Duration(days: -(365 ~/ 2)));
    final DateTime rangeEndDate = DateTime.now().add(Duration(days: 365));
    final List<Appointment> appointments = <Appointment>[];
    for (DateTime i = rangeStartDate;
        i.isBefore(rangeEndDate);
        i = i.add(Duration(days: random.nextInt(10)))) {
      final DateTime date = i;
      final int count = 1 + random.nextInt(3);
      for (int j = 0; j < count; j++) {
        final DateTime startDate =
            DateTime(date.year, date.month, date.day, 8 + random.nextInt(8));
        appointments.add(Appointment(
          subject: subjectCollection[random.nextInt(7)],
          startTime: startDate,
          endTime: startDate.add(Duration(hours: random.nextInt(3))),
          color: colorCollection[random.nextInt(9)],
        ));
      }
    }

    DateTime date = DateTime.now();
    date = DateTime(date.year, date.month, date.day, 11);
    // added recurrence appointment
    appointments.add(Appointment(
        subject: 'Scrum',
        startTime: date,
        endTime: date.add(Duration(hours: 1)),
        color: colorCollection[random.nextInt(9)],
        recurrenceRule: 'FREQ=DAILY;INTERVAL=10'));
    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpacerHeight(h: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Event", style: CustomFont.heading24),
            ),
            SpacerHeight(h: 20),
            Expanded(
              child: SfCalendar(
                todayTextStyle: CustomFont.regular12,
                headerStyle: CalendarHeaderStyle(
                    backgroundColor: CustomColor.whiteColor,
                    textStyle: CustomFont.regular12),
                showDatePickerButton: true,
                dataSource: events,
                view: CalendarView.schedule,
                scheduleViewSettings: ScheduleViewSettings(
                  appointmentTextStyle: CustomFont.regular12,
                  appointmentItemHeight: 60,
                  monthHeaderSettings: MonthHeaderSettings(
                      monthTextStyle: CustomFont.bold24,
                      height: 120,
                      backgroundColor: CustomColor.brownColor),
                ),
              ),
            ),
            SpacerHeight(h: 5),
          ],
        ),
      ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
