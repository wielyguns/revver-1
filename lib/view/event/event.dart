import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/event.dart';
import 'package:revver/controller/meeting.dart';
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

  // 0: Peronal Event
  // 1: Lead Meeting
  // 2: Global Event

  getData() async {
    if (!mounted) return;
    setState(() {
      appointment = [];
      events = _DataSource(appointment);
      isLoad = true;
    });
    await getEvent().then((val) async {
      setState(() {
        for (var i = 0; i < val.length; i++) {
          appointment.add(
            Appointment(
              notes: "2",
              id: val[i].id,
              subject: val[i].name,
              startTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(val[i].date),
              endTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(val[i].date),
              color: CustomColor.brownColor,
            ),
          );
        }
      });
      await getMeeting().then((val) {
        setState(() {
          for (var i = 0; i < val.length; i++) {
            appointment.add(
              Appointment(
                  notes: val[i].is_meeting.toString(),
                  id: val[i].id,
                  subject: val[i].name,
                  startTime:
                      DateFormat("yyyy-MM-dd hh:mm:ss").parse(val[i].date),
                  endTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(val[i].date),
                  color: (val[i].is_meeting == 0)
                      ? CustomColor.goldColor
                      : CustomColor.oldGreyColor),
            );
          }
          events = _DataSource(appointment);
          isLoad = false;
        });
      });
    });
  }

  callbackPE() {
    if (!GoRouter.of(context).location.contains("personal-event")) {
      getData();
      GoRouter.of(context).removeListener(callbackPE);
    }
  }

  callbackLM() {
    if (!GoRouter.of(context).location.contains("lead-meeting")) {
      getData();
      GoRouter.of(context).removeListener(callbackLM);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        isPop: false,
        title: "Event",
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpacerHeight(h: 10),
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
                              .push("/personal-event/$appointmentId");
                          GoRouter.of(context).addListener(callbackPE);
                        }
                        if (appointmentNote == "1") {
                          GoRouter.of(context)
                              .push("/lead-meeting/$appointmentId");
                          GoRouter.of(context).addListener(callbackLM);
                        }
                        if (appointmentNote == "2") {
                          GoRouter.of(context)
                              .push("/global-event/$appointmentId");
                        }
                      },
                    ),
                  ),
                  SpacerHeight(h: 5),
                ],
              ),
            ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 40,
        child: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push("/personal-event/000");
            GoRouter.of(context).addListener(callbackPE);
          },
          backgroundColor: CustomColor.brownColor,
          child: Icon(
            Icons.add,
            size: 30,
          ),
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
