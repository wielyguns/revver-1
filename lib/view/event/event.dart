import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/event.dart';
import 'package:revver/globals.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Event extends StatefulWidget {
  Event({Key key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  _DataSource events;

  getMeetingList() async {
    await getEvent().then((val) {});
  }

  @override
  void initState() {
    events = _DataSource(_getAppointments());
    getMeetingList();
    super.initState();
  }

  List<Appointment> _getAppointments() {
    final List<String> subjectCollection = <String>[];
    subjectCollection.add('Global Event');
    subjectCollection.add('Personal Event / Meeting');

    final List<Color> colorCollection = <Color>[];
    colorCollection.add(CustomColor.goldColor);
    colorCollection.add(CustomColor.oldGreyColor);

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
        appointments.add(
          Appointment(
            id: random.nextInt(2).toString(),
            subject: subjectCollection[random.nextInt(2)],
            notes: "isMeeting",
            startTime: startDate,
            endTime: startDate,
            color: colorCollection[random.nextInt(2)],
          ),
        );
      }
    }

    DateTime date = DateTime.now();
    date = DateTime(date.year, date.month, date.day, 11);
    // added recurrence appointment
    // appointments.add(Appointment(
    //     subject: 'Scrum',
    //     startTime: date,
    //     endTime: date.add(Duration(hours: 1)),
    //     color: colorCollection[random.nextInt(9)],
    //     recurrenceRule: 'FREQ=DAILY;INTERVAL=10'));
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
                onTap: (CalendarTapDetails details) {
                  Appointment appointment = details.appointments[0];
                  int appointmentId = int.parse(appointment.id);
                  if (appointmentId == 0) {
                    GoRouter.of(context).push("/global-event/$appointmentId");
                  } else {
                    GoRouter.of(context).push("/personal-event/1");
                  }
                },
              ),
            ),
            SpacerHeight(h: 5),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push("/personal-event/0");
        },
        backgroundColor: CustomColor.goldColor,
        child: Icon(Icons.add),
      ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
