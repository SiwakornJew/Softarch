import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:medware/utils/statics.dart';
import 'package:medware/utils/api/event/patient/get_schedule.dart';
import 'package:medware/utils/models/event/patient/patient_event.dart';
import 'package:medware/screens/main/event/patient/confirm_appointment.dart';
import 'package:medware/utils/statics.dart' as statics;

LinkedHashMap<DateTime, List<PatientEvent>>? _groupedEvents;

class CalendarAppointment extends StatefulWidget {
  final int type;
  const CalendarAppointment({super.key, required this.type});
  @override
  State<CalendarAppointment> createState() => _CalendarAddState();
}

class _CalendarAddState extends State<CalendarAppointment> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  var events;
  late bool _isLoading;

  List<dynamic> _getEventsForDay(DateTime date) {
    return _groupedEvents?[date] ?? [];
  }

  Future _loadAppointments() async {
    _isLoading = true;
    events = await getPatientSchedule(widget.type);
    _isLoading = false;
    setState(() {
      _groupEvent(events);
    });
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month + 10002 + key.year;
  }

  bool _checkEventEnrollable(dynamic dayEvent) {
    for (int i = 0; i < dayEvent.length; i++) {
      if (dayEvent[i].capacity > dayEvent[i].patientCount) {
        return true;
      }
    }
    return false;
  }

  _groupEvent(List<PatientEvent> events) {
    events.sort(((a, b) {
      return a.startTime.compareTo(b.startTime);
    }));
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    for (var event in events) {
      DateTime date =
          DateTime.utc(event.date.year, event.date.month, event.date.day, 12);
      if (_groupedEvents![date] == null) {
        _groupedEvents![date] = [];
      }
      _groupedEvents![date]!.add(event);
    }
  }

  @override
  void initState() {
    _loadAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fullDateFormatter = DateFormat.yMMMMEEEEd();
    final timeFormatter = DateFormat.jm();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          toolbarHeight: size.height * 0.1,
          backgroundColor: Colors.white,
          leadingWidth: size.width * 0.22,
          leading: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(size.width * 0.07, 0, 0, 0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: size.width * 0.04,
                        color: primaryColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(size.width * 0.01, 0, 0, 0),
                      child: Text('กลับ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'NotoSansThai',
                            fontWeight: FontWeight.w400,
                            fontSize: size.width * 0.046,
                            color: primaryColor,
                          )),
                    )
                  ],
                )),
          ]),
          title: SizedBox(
            width: size.width * 0.67,
            child: Text('การทำนัดหมาย',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'NotoSansThai',
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.072,
                  color: primaryColor,
                )),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemStatusBarContrastEnforced: true,
          ),
        ),
        body: _isLoading == false
            ? RefreshIndicator(
                onRefresh: () async {
                  await _loadAppointments();
                },
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                backgroundColor: quaternaryColor,
                color: secondaryColor,
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(size.width * 0.045,
                                size.height * 0.003, size.width * 0.045, 0),
                            child: SizedBox(
                              height: size.height * 0.44,
                              width: size.width,
                              child: TableCalendar(
                                eventLoader: (day) {
                                  return _getEventsForDay(day);
                                },
                                calendarBuilders: CalendarBuilders(
                                  markerBuilder: (context, day, events) {
                                    if (events.isNotEmpty) {
                                      return Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Positioned(
                                            bottom: 2.0,
                                            child: Container(
                                              height: 10.0,
                                              width: 10.0,
                                              decoration: BoxDecoration(
                                                color: _checkEventEnrollable(
                                                        events)
                                                    ? primaryColor
                                                    : Color(0xFFFF0000),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {}
                                  },
                                  selectedBuilder:
                                      ((context, _datetime, focusedDay) {
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(
                                          size.width * 0.005,
                                          size.height * 0.005,
                                          size.width * 0.005,
                                          size.height * 0.005),
                                      decoration: BoxDecoration(
                                          color: tertiaryColor,
                                          borderRadius: BorderRadius.circular(
                                              size.height * 0.02)),
                                      child: Center(
                                          child: Text(
                                        _datetime.day.toString(),
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    );
                                  }),
                                  todayBuilder:
                                      (context, _datetime, focusedDay) {
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(
                                          size.width * 0.005,
                                          size.height * 0.005,
                                          size.width * 0.005,
                                          size.height * 0.005),
                                      decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: BorderRadius.circular(
                                              size.height * 0.02)),
                                      child: Center(
                                          child: Text(
                                        _datetime.day.toString(),
                                        style: TextStyle(
                                            color: Color(0xFFEEF2E6),
                                            fontWeight: FontWeight.w500),
                                      )),
                                    );
                                  },
                                ),
                                shouldFillViewport: true,
                                firstDay: DateTime(1990),
                                lastDay: DateTime(2050),
                                focusedDay: _focusedDay,
                                calendarFormat: _calendarFormat,
                                daysOfWeekStyle: DaysOfWeekStyle(
                                    weekdayStyle:
                                        TextStyle(color: primaryColor),
                                    weekendStyle:
                                        TextStyle(color: tertiaryColor)),
                                calendarStyle: CalendarStyle(
                                    selectedTextStyle: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500),
                                    weekendTextStyle:
                                        TextStyle(color: tertiaryColor),
                                    defaultTextStyle: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500)),
                                headerStyle: HeaderStyle(
                                  leftChevronIcon: Icon(
                                    Icons.arrow_back_ios,
                                    color: primaryColor,
                                    size: size.width * 0.05,
                                  ),
                                  rightChevronIcon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: primaryColor,
                                    size: size.width * 0.05,
                                  ),
                                  titleTextStyle: TextStyle(
                                      color: primaryColor,
                                      fontSize: size.width * 0.05),
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  titleTextFormatter: (date, locale) =>
                                      DateFormat.MMMM(locale).format(date),
                                ),
                                selectedDayPredicate: (day) {
                                  return isSameDay(_selectedDay, day);
                                },
                                onDaySelected: (selectedDay, focusedDay) {
                                  if (!isSameDay(_selectedDay, selectedDay)) {
                                    setState(() {
                                      _selectedDay = selectedDay;
                                      _focusedDay = focusedDay;
                                    });
                                  }
                                },
                                onPageChanged: (focusedDay) {
                                  _focusedDay = focusedDay;
                                },
                              ),
                            )),
                        SizedBox(
                          height: size.height * 0.038,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.height * 0.03)),
                          child: Container(
                              width: size.width * 0.88,
                              height: size.height * 0.31,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: Color.fromARGB(106, 28, 103, 88),
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.height * 0.03))),
                              child: ScrollConfiguration(
                                behavior: CustomScroll(),
                                child:
                                    !_getEventsForDay(_selectedDay as DateTime)
                                            .isEmpty
                                        ? ListView(
                                            shrinkWrap: false,
                                            itemExtent: size.height * 0.102,
                                            children: [
                                              ..._getEventsForDay(
                                                      _selectedDay as DateTime)
                                                  .map((event) => ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    size.height *
                                                                        0.04)),
                                                        child: Card(
                                                            shadowColor: Colors
                                                                .transparent,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    size.height *
                                                                        0.003),
                                                            color:
                                                                quaternaryColor,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      size.height *
                                                                          0.03),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () {
                                                                if (event.capacity <=
                                                                        event
                                                                            .patientCount ||
                                                                    DateTime.now()
                                                                            .add(Duration(days: 3))
                                                                            .compareTo(event.date) >=
                                                                        0) {
                                                                } else {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => ConfirmAppointment(
                                                                          id: event
                                                                              .id,
                                                                          capacity: event
                                                                              .capacity,
                                                                          patientCount: event
                                                                              .patientCount,
                                                                          date: event
                                                                              .date,
                                                                          startTime: event
                                                                              .startTime,
                                                                          finishTime: event
                                                                              .finishTime,
                                                                          type: event
                                                                              .type,
                                                                          doctorFirstName: event
                                                                              .doctorFirstName,
                                                                          doctorMiddleName: event
                                                                              .doctorMiddleName,
                                                                          doctorLastName: event
                                                                              .doctorLastName,
                                                                          department:
                                                                              event.department),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(
                                                                    size.width *
                                                                        0.02,
                                                                    size.width *
                                                                        0.015,
                                                                    size.width *
                                                                        0.02,
                                                                    size.width *
                                                                        0.015),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: event.type ==
                                                                                3
                                                                            ? Color(0xFFFF0000)
                                                                            : Color(0xFF4CC9FF),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          size.width *
                                                                              0.03,
                                                                        ),
                                                                      ),
                                                                      padding: EdgeInsets.all(
                                                                          size.width *
                                                                              0.025),
                                                                      child:
                                                                          Icon(
                                                                        event.type ==
                                                                                3
                                                                            ? Icons.water_drop_outlined
                                                                            : Icons.medical_services_outlined,
                                                                        size: size.width *
                                                                            0.09,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: size
                                                                              .width *
                                                                          0.04,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          statics
                                                                              .appointmentTypes[event.type],
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                primaryColor,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontSize:
                                                                                size.height * 0.02,
                                                                          ),
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              '${fullDateFormatter.format(event.date)}',
                                                                              style: TextStyle(
                                                                                fontSize: size.height * 0.0145,
                                                                                color: primaryColor,
                                                                              ),
                                                                            ),
                                                                            Text('เวลา ${timeFormatter.format(event.startTime)} - ${timeFormatter.format(event.finishTime)}',
                                                                                style: TextStyle(
                                                                                  fontSize: size.height * 0.0145,
                                                                                  color: primaryColor,
                                                                                ))
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Spacer(),
                                                                    Padding(
                                                                      padding: EdgeInsets.fromLTRB(
                                                                          0,
                                                                          size.height *
                                                                              0.045,
                                                                          size.width *
                                                                              0.03,
                                                                          0),
                                                                      child: Text(
                                                                          '${event.patientCount} / ${event.capacity}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                size.width * 0.032,
                                                                            color: event.patientCount >= event.capacity
                                                                                ? Color(0xFFFF0000)
                                                                                : primaryColor,
                                                                          )),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                      ))
                                            ],
                                          )
                                        : Center(
                                            child: Text(
                                            'ไม่มีนัดหมายที่ท่านสามารถทำการจองได้',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
                                                color: primaryColor),
                                          )),
                              )),
                        )
                      ],
                    )))
            : Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, size.height * 0.3, 0, 0),
                  child: Column(children: [
                    SpinKitCircle(
                      color: primaryColor,
                      size: size.height * 0.1,
                    ),
                    Text(
                      'Loading...',
                      style: TextStyle(
                          color: secondaryColor, fontSize: size.width * 0.05),
                    )
                  ]),
                ),
              ));
  }
}

class CustomScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
