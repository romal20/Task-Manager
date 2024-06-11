import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarSection extends StatefulWidget {
  @override
  _CalendarSectionState createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  DateTime _selectedDate = DateTime.now();
  int _selectedDayIndex = DateTime.now().day - 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.green),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
                  _selectedDayIndex = -1;
                });
              },
            ),
            Text(
              '${DateFormat('MMMM yyyy').format(_selectedDate)}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right, color: Colors.green),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
                  _selectedDayIndex = -1;
                });
              },
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.calendar_month_outlined, color: Colors.green),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      _selectedDate = selectedDate;
                      _selectedDayIndex = selectedDate.day - 1;
                    });
                  }
                });
              },
            )
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          height: 65.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day,
            controller: ScrollController(
              initialScrollOffset: (_selectedDate.day - 1) * (50.0 + 7.0),
            ),
            itemBuilder: (context, index) {
              final currentDate = DateTime(_selectedDate.year, _selectedDate.month, index + 1);
              final dayOfMonth = (index + 1).toString().padLeft(2, '0');
              final dayOfWeek = currentDate.weekday;
              final dayName = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][dayOfWeek - 1];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDayIndex = index;
                  });
                },
                child: Container(
                  width: 50.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    border: _selectedDayIndex == index
                        ? Border.all(color: Colors.pink, width: 1.5)
                        : currentDate.day == DateTime.now().day &&
                        currentDate.month == DateTime.now().month &&
                        currentDate.year == DateTime.now().year
                        ? Border.all(color: Colors.white, width: 1.5)
                        : null,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$dayOfMonth',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: _selectedDayIndex == index ? Colors.pink : Colors.grey[900],
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        '$dayName',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: _selectedDayIndex == index ? Colors.pink : Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
