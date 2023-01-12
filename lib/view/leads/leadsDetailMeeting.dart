// ignore_for_file: must_be_immutable, non_constant_identifier_names
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/meeting.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LeadsDetailMeeting extends StatefulWidget {
  LeadsDetailMeeting({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<LeadsDetailMeeting> createState() => _LeadsDetailMeetingState();
}

class _LeadsDetailMeetingState extends State<LeadsDetailMeeting> {
  bool isLoad = true;
  List<Meeting> meeting = [];
  String lead_id;
  _DataSource events;
  List<Appointment> appointment = [];

  getData() async {
    if (!mounted) return;
    setState(() {
      appointment = [];
      events = _DataSource(appointment);
      isLoad = true;
    });
    await getMeeting().then((val) async {
      setState(() {
        List<Meeting> y = val.where((e) => e.is_meeting == 1).toList();
        List<Meeting> x = y.where((e) => e.lead_id == widget.id).toList();
        meeting = x;
        for (var i = 0; i < x.length; i++) {
          appointment.add(
            Appointment(
              id: x[i].id,
              subject: val[i].name,
              startTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(x[i].date),
              endTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(x[i].date),
              color: CustomColor.brownColor,
            ),
          );
        }
        events = _DataSource(appointment);
        isLoad = false;
      });
    });
  }

  callback() {
    if (!GoRouter.of(context).location.contains("leads-detail-meeting-form")) {
      getData();
      GoRouter.of(context).removeListener(callback);
    }
  }

  @override
  void initState() {
    getData();
    setState(() {
      lead_id = widget.id.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: (isLoad)
            ? Center(child: CupertinoActivityIndicator())
            : (meeting.isEmpty)
                ? Center(child: Text("Not Found!"))
                : calendarWidget(),
      ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 40,
        child: FloatingActionButton(
          onPressed: () {
            String x = "000";
            GoRouter.of(context).push("/leads-detail-meeting-form/$x/$lead_id");
            GoRouter.of(context).addListener(callback);
          },
          backgroundColor: CustomColor.brownColor,
          child: Icon(
            Icons.add,
            size: 30,
          ),
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),

      // FloatingActionButton(
      //   onPressed: () {
      //     String x = "000";
      //     GoRouter.of(context).push("/leads-detail-meeting-form/$x/$lead_id");
      //     GoRouter.of(context).addListener(callback);
      //   },
      //   backgroundColor: CustomColor.brownColor,
      //   child: Icon(Icons.add),
      // ),
    );
  }

  calendarWidget() {
    return SfCalendar(
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
        int appointmentId = appointment.id;
        GoRouter.of(context)
            .push("/leads-detail-meeting-form/$appointmentId/$lead_id");
        GoRouter.of(context).addListener(callback);
      },
    );
  }

  listWidget() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: meeting.length,
      itemBuilder: (context, index) {
        Meeting meet = meeting[index];
        return Column(
          children: [
            (index == 0) ? SpacerHeight(h: 20) : SizedBox(),
            listItem(meet.id, meet.name, meet.date),
            SpacerHeight(h: 20),
          ],
        );
      },
    );
  }

  listItem(id, name, date) {
    return InkWell(
      onTap: (() {
        GoRouter.of(context).push("/leads-detail-meeting-form/$id/$lead_id");
        GoRouter.of(context).addListener(callback);
      }),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: CustomColor.brownColor,
                borderRadius: BorderRadius.circular(5)),
            child: SvgPicture.asset(
              "assets/svg/bell-solid.svg",
              color: CustomColor.whiteColor,
            ),
          ),
          SpacerWidth(w: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style:
                        CustomFont(CustomColor.blackColor, 16, FontWeight.bold)
                            .font,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  // width: 100,
                  child: Text(
                    tanggal(DateTime.parse(date), shortMonth: true),
                    style: CustomFont(
                            CustomColor.oldGreyColor, 12, FontWeight.bold)
                        .font,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
