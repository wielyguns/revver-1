import 'package:intl/intl.dart';

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
  bool isLoad = true;
  _DataSource events;
  List<Appointment> appointment = [];

  getData() async {
    await getEvent().then((val) {
      setState(() {
        for (var i = 0; i < val.length; i++) {
          appointment.add(
            Appointment(
              notes: "0",
              id: val[i].id,
              subject: val[i].name,
              startTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(val[i].date),
              endTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(val[i].date),
              color: CustomColor.brownColor,
            ),
          );
        }
        events = _DataSource(appointment);
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoad)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
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
                      todayHighlightColor: CustomColor.brownColor,
                      todayTextStyle: CustomFont.regular12,
                      headerStyle: CalendarHeaderStyle(
                          backgroundColor: CustomColor.backgroundColor,
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
                        String appointmentNote = appointment.notes;
                        int appointmentId = appointment.id;
                        if (appointmentNote == "0") {
                          GoRouter.of(context)
                              .push("/global-event/$appointmentId");
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
        backgroundColor: CustomColor.brownColor,
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
