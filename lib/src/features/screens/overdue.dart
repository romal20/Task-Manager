import 'package:flutter/material.dart';
import 'package:ohsm/src/features/screens/calendar_section.dart';
import 'package:ohsm/src/features/screens/task_list.dart';
import 'package:ohsm/src/features/screens/task_list_overdue.dart';
import 'package:ohsm/src/features/screens/task_overview_section.dart';

class Overdue extends StatefulWidget {
  const Overdue({super.key});

  @override
  State<Overdue> createState() => _OverdueState();
}

class _OverdueState extends State<Overdue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            // Handle back action
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Manage Tasks',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.info_outline, color: Colors.green,size: 18,),
              onPressed: () {
                // Handle info action
              },
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // Handle incident logs action
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
                decoration: BoxDecoration(
                  color: Color(0xffff0d0d),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.white,
                      size: 10.0,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Incident Logs',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            ImageIcon(AssetImage("assets/image/search.png"),size: 50,color: Colors.green,),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tablet/Desktop layout
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CalendarSection(),
                        //SizedBox(height: 16.0),
                        TaskOverviewSection(),
                        //SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Flexible(
                    flex: 3,
                    child: TaskList(),
                  ),
                ],
              ),
            );
          } else {
            // Mobile layout
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarSection(),
                  SizedBox(height: 16.0),
                  TaskOverviewSection(),
                  SizedBox(height: 16.0),
                  Expanded(child: OverdueTaskList()),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
