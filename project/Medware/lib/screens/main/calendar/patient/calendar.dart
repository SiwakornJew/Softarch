import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medware/utils/api/appointment/get_patient_appointments.dart';
import 'package:medware/utils/models/appointment/patient_appointment.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medware/utils/statics.dart';
import '../../../../components/notification_bell.dart';
import 'package:intl/intl.dart';

LinkedHashMap<DateTime, List<PatientAppointment>>? _groupedEvents;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  var events;
  DateTime? _selectedDay;
  final int id = SharedPreference.getUserId();

  String _mapAppointmentType(int type) {
    if (type == 1) {
      return 'นัดหมายพิเศษ';
    } else if (type == 2) {
      return 'ตรวจสุขภาพ';
    } else if (type == 3) {
      return 'บริจาคเลือด';
    } else {
      return 'อื่นๆ';
    }
  }

  List<dynamic> _getEventsForDay(DateTime date) {
    return _groupedEvents?[date] ?? [];
  }

  Future _loadAppointments() async {
    events = await getPatientAppointments(id);
    _groupEvent(events);
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month + 10002 + key.year;
  }

  _groupEvent(List<PatientAppointment> events) {
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
    super.initState();
    _loadAppointments();
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
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.045, 0, size.width * 0.045, 0),
              child: SizedBox(
                width: size.width * 0.67,
                child: Text('ปฎิทินการนัดหมาย',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'NotoSansThai',
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.072,
                      color: primaryColor,
                    )),
              ),
            ),
            NotificationBell(backgroundColor: quaternaryColor),
          ],
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemStatusBarContrastEnforced: true,
        ),
      ),
      body: Column(
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
                    selectedBuilder: ((context, _datetime, focusedDay) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(
                            size.width * 0.005,
                            size.height * 0.005,
                            size.width * 0.005,
                            size.height * 0.005),
                        decoration: BoxDecoration(
                            color: tertiaryColor,
                            borderRadius:
                                BorderRadius.circular(size.height * 0.02)),
                        child: Center(
                            child: Text(
                          _datetime.day.toString(),
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w500),
                        )),
                      );
                    }),
                    todayBuilder: (context, _datetime, focusedDay) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(
                            size.width * 0.005,
                            size.height * 0.005,
                            size.width * 0.005,
                            size.height * 0.005),
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius:
                                BorderRadius.circular(size.height * 0.02)),
                        child: Center(
                            child: Text(
                          _datetime.day.toString(),
                          style: TextStyle(
                              color: Color(0xFFEEF2E6),
                              fontWeight: FontWeight.w500),
                        )),
                      );
                    },
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
                                  color: primaryColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {}
                    },
                  ),
                  shouldFillViewport: true,
                  firstDay: DateTime(1990),
                  lastDay: DateTime(2050),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: primaryColor),
                      weekendStyle: TextStyle(color: tertiaryColor)),
                  calendarStyle: CalendarStyle(
                      selectedTextStyle: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w500),
                      weekendTextStyle: TextStyle(color: tertiaryColor),
                      defaultTextStyle: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w500)),
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
                        color: primaryColor, fontSize: size.width * 0.05),
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
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(size.height * 0.03)),
            child: Container(
                width: size.width * 0.88,
                height: size.height * 0.31,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Color.fromARGB(106, 28, 103, 88),
                    ),
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height * 0.03))),
                child: ScrollConfiguration(
                  behavior: CustomScroll(),
                  child: !_getEventsForDay(_selectedDay as DateTime).isEmpty
                      ? ListView(
                          shrinkWrap: false,
                          itemExtent: size.height * 0.102,
                          children: [
                            ..._getEventsForDay(_selectedDay as DateTime)
                                .map((event) => ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.height * 0.04)),
                                      child: Card(
                                          shadowColor: Colors.transparent,
                                          margin: EdgeInsets.all(
                                              size.height * 0.003),
                                          color: quaternaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                size.height * 0.03),
                                          ),
                                          child: InkWell(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  size.width * 0.02,
                                                  size.width * 0.015,
                                                  size.width * 0.02,
                                                  size.width * 0.015),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: event.type == 1
                                                          ? Colors.amber[500]
                                                          : event.type == 2
                                                              ? Color(0xFF4CC9FF)
                                                              : Colors.red[400],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        size.width * 0.03,
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.all(
                                                        size.width * 0.025),
                                                    child: Icon(
                                                      event.type == 1
                                                          ? Icons
                                                              .medical_services_outlined
                                                          : event.type == 2
                                                              ?Icons.medical_services_outlined
                                                              :Icons.water_drop_outlined,
                                                              
                                                      size: size.width * 0.09,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.04,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _mapAppointmentType(
                                                            event.type),
                                                        style: TextStyle(
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize:
                                                              size.height *
                                                                  0.02,
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${fullDateFormatter.format(event.date)}',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.0145,
                                                              color:
                                                                  primaryColor,
                                                            ),
                                                          ),
                                                          Text(
                                                              'เวลา ${timeFormatter.format(event.startTime)} - ${timeFormatter.format(event.finishTime)}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.0145,
                                                                color:
                                                                    primaryColor,
                                                              ))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    )),
                            SizedBox(
                              height: size.height * 0.038,
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                          'ไม่มีนัดหมายของท่านในวันนี้',
                          style: TextStyle(
                              fontSize: size.width * 0.05, color: primaryColor),
                        )),
                )),
          )
        ],
      ),
    );
  }
}

class CustomScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
