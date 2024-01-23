// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalender {
  Future<String> showDatePicker(BuildContext context, String fromOrto) async {
    DateTime currentDate = DateTime.now();
    DateTime selectedDay = DateTime.now();
    int nextMonday = DateTime.monday;
    int nextTuesday = DateTime.tuesday;
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
                padding: EdgeInsets.only(
                    top: fromOrto == 'from' ? 70 : 120.0,
                    bottom: 85,
                    left: 25,
                    right: 25),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15.0, top: 5),
                                child: ElevatedButton(
                                    onPressed: () {
                                      debugPrint('--------------- today');
                                      setState(() {
                                        selectedDay = DateTime.now();
                                      });
                                    },
                                    child: const Text('Today'),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.lightBlue[50]),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .primaryColor))),
                              ),
                            ),
                            fromOrto == 'from'
                                ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, top: 5),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            debugPrint(
                                                '--------------- next monday $selectedDay');
                                            setState(() {
                                              // Find the next Monday from the current selected day
                                              final daysUntilNextMonday =
                                                  (nextMonday -
                                                          selectedDay.weekday +
                                                          7) %
                                                      7;

                                              // If the current selected day is already a Monday, move to the next week's Monday
                                              selectedDay = selectedDay.add(
                                                  Duration(
                                                      days: daysUntilNextMonday ==
                                                              0
                                                          ? 7
                                                          : daysUntilNextMonday));
                                            });
                                          },
                                          child: const Text('Next Monday')),
                                    ),
                                  )
                                : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, top: 5),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            debugPrint(
                                                '--------------- next monday $selectedDay');
                                            setState(() {
                                              // Find the next Monday from the current selected day
                                              selectedDay = DateTime(0);
                                            });
                                          },
                                          child: const Text('No Date')),
                                    ),
                                  )
                          ],
                        ),
                        fromOrto == 'from'
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15.0,
                                      ),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            debugPrint(
                                                '--------------- next tuesday $selectedDay');
                                            setState(() {
                                              // Find the next Monday from the current selected day
                                              final daysUntilNextTuesday =
                                                  (nextTuesday -
                                                          selectedDay.weekday +
                                                          7) %
                                                      7;

                                              // If the current selected day is already a Monday, move to the next week's Monday
                                              selectedDay = selectedDay.add(Duration(
                                                  days: daysUntilNextTuesday ==
                                                          0
                                                      ? 7
                                                      : daysUntilNextTuesday));
                                            });
                                          },
                                          child: const Text('Next Tuesday'),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.lightBlue[50]),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Theme.of(context)
                                                          .primaryColor))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 15.0,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          debugPrint(
                                              '--------------- next monday $selectedDay');
                                          setState(() {
// Calculate the date for the next Monday
                                            DateTime nextWeekStart = selectedDay
                                                .add(const Duration(days: 7));

                                            // Check if moving to next week goes beyond the current month
                                            if (nextWeekStart.month !=
                                                selectedDay.month) {
                                              // Move to the first day of the next month
                                              selectedDay = DateTime(
                                                  nextWeekStart.year,
                                                  nextWeekStart.month,
                                                  1);
                                            } else {
                                              // If not, simply move to the next week
                                              selectedDay = nextWeekStart;
                                            }
                                          });
                                        },
                                        child: const Text('After 1 week'),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.lightBlue[50]),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Theme.of(context)
                                                        .primaryColor)),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
                        Expanded(
                          child: Material(
                            child: TableCalendar(
                              // customize your TableCalendar here
                              calendarStyle: const CalendarStyle(
                                cellMargin: EdgeInsets.all(0),
                              ),
                              availableCalendarFormats: const {
                                CalendarFormat.month: 'Month',
                              },
                              headerStyle:
                                  const HeaderStyle(titleCentered: true),
                              rowHeight: 40,
                              calendarFormat: CalendarFormat.month,

                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: currentDate,
                              selectedDayPredicate: (day) {
                                return isSameDay(selectedDay, day);
                              },
                              onDaySelected: (selectedDayy, focusedDay) {
                                setState(() {
                                  selectedDay = selectedDayy;
                                  currentDate =
                                      focusedDay; // update `_focusedDay` here as well
                                });
                              },
                              // other properties...
                            ),
                          ),
                        ),
                        const Divider(thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Icon(
                                        Icons.calendar_month_outlined,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Material(
                                        child: selectedDay == DateTime(0)
                                            ? const Text('No Date')
                                            : Text(DateFormat('dd MMM yyyy')
                                                .format(selectedDay))),
                                  )
                                ]),
                            Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, bottom: 10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.lightBlue[50]),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 15.0,
                                  ),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context,
                                            DateFormat('dd MMM yyyy')
                                                .format(selectedDay));
                                      },
                                      child: const Text('Save')),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )));
          });
        });
  }
}
