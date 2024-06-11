import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ohsm/src/features/screens/add_task.dart';

class OverdueTaskList extends StatefulWidget {
  @override
  State<OverdueTaskList> createState() => _OverdueTaskListState();
}

class _OverdueTaskListState extends State<OverdueTaskList> {
  List<Map<String, dynamic>> tasks = [
    {
      'icon': Icons.cleaning_services,
      'iconColor': Colors.blue,
      'title': 'Room 303 Set Up',
      'subtitle': 'Housekeeping',
      'priority': 'High',
      'priorityColor': Colors.red,
      'assignee': 'Garima Bhatia',
      'atus': 'Overdue',
      'progressColor': Colors.red,
      'progress': 1.0,
      'dateTime': '14 July 2024, 05:00 PM',
      'statusText': 'Approval Awaited',
      'statusColor': Colors.red,
      'isDone': false,
    },
    {
      'icon': Icons.home_repair_service,
      'iconColor': Colors.purple,
      'title': 'Fire Place Check & Upkeep',
      'subtitle': 'Maintenance & Repairs',
      'priority': 'Low',
      'priorityColor': Colors.green,
      'assignee': 'Ranganathan',
      'atus': 'Overdue',
      'progressColor': Colors.red,
      'progress': 0.0,
      'dateTime': '14 July 2024, 05:00 PM',
      'statusText': 'Task Not Completed or started',
      'statusColor': Colors.red,
      'isDone': false,
    },
    {
      'icon': Icons.water_damage,
      'iconColor': Colors.red,
      'title': 'Water Leakage Repair',
      'subtitle': 'Raise a Incident',
      'priority': 'Low',
      'priorityColor': Colors.green,
      'assignee': 'Mahesh Taluk',
      'atus': 'Overdue',
      'progressColor': Colors.red,
      'progress': 1.0,
      'dateTime': '14 July 2024, 05:00 PM',
      'statusText': 'Approval Awaited',
      'statusColor': Colors.red,
      'isDone': false,
    },
    {
      'icon': Icons.lock,
      'iconColor': Colors.orange,
      'title': 'Door Lock Installation',
      'subtitle': 'Custom',
      'priority': 'Low',
      'priorityColor': Colors.green,
      'assignee': 'Mahender Singh',
      'atus': 'Overdue',
      'progressColor': Colors.red,
      'progress': 0.0,
      'dateTime': '14 July 2024, 05:00 PM',
      'statusText': 'Task Not Completed or started',
      'statusColor': Colors.red,
      'isDone': false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(2.0),
        children: tasks
            .map((task) => TaskCard(
                  icon: task['icon'],
                  iconColor: task['iconColor'],
                  title: task['title'],
                  subtitle: task['subtitle'],
                  priority: task['priority'],
                  priorityColor: task['priorityColor'],
                  assignee: task['assignee'],
                  atus: task['atus'],
                  progressColor: task['progressColor'],
                  progress: task['progress'],
                  dateTime: task['dateTime'],
                  statusText: task['statusText'],
                  statusColor: task['statusColor'],
                  isDone: task['isDone'],
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            isScrollControlled: true,
            builder: (context) => AddListScreen(),
          );

          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String priority;
  final Color priorityColor;
  final String assignee;
  final String atus;
  final Color progressColor;
  final double progress;
  final String dateTime;
  final String statusText;
  final Color statusColor;
  final bool isDone;

  const TaskCard({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.priority,
    required this.priorityColor,
    required this.assignee,
    required this.atus,
    required this.progressColor,
    required this.progress,
    required this.dateTime,
    required this.statusText,
    required this.statusColor,
    required this.isDone,
  }) : super(key: key);

  String _truncateWithEllipsis(String text, int wordLimit) {
    final words = text.split(' ');
    if (words.length <= wordLimit) {
      return text;
    } else {
      return words.take(wordLimit).join(' ') + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    String priorityImage;
    if (priority == 'High') {
      priorityImage = 'assets/image/high.png';
    } else {
      priorityImage = 'assets/image/low.png';
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 30,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              subtitle,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(width: 30),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: priorityColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  priorityImage,
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  priority,
                                  style: TextStyle(
                                    color: priorityColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Row(
                      children: [
                        SizedBox(height: 55),
                        Text(
                          assignee,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 0.5,
              height: 1,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text(
                  'Progress status:',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[500],
                      fontSize: 15),
                ),
                SizedBox(width: 3),
                Text(
                  atus,
                  style: TextStyle(
                      color: progressColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),

                Spacer(),
                Text(
                  dateTime,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[500],
                      fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StepIndicator(
                    isCompleted: progress > 0.0,
                    isCurrent: progress == 0.0,
                    statusColor: statusColor),
                StepConnector(
                  isCompleted: progress > 0.0,
                  progressColor: progressColor,
                ),
                StepIndicator(
                  isCompleted: progress > 0.25,
                  isCurrent: progress == 0.25,
                  statusColor: statusColor,
                ),
                StepConnector(
                  isCompleted: progress > 0.25,
                  progressColor: progressColor,
                ),
                StepIndicator(
                  isCompleted: progress > 0.5,
                  isCurrent: progress == 0.5,
                  statusColor: statusColor,
                ),
                StepConnector(
                  isCompleted: progress > 0.5,
                  progressColor: progressColor,
                ),
                StepIndicator(
                  isCompleted: progress > 0.75,
                  isCurrent: progress == 0.75,
                  statusColor: statusColor,
                ),
                StepConnector(
                  isCompleted: progress > 0.75,
                  progressColor: progressColor,
                ),
                StepIndicator(
                  isCompleted: progress > 0.99,
                  isCurrent: progress == 0.99,
                  statusColor: statusColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 55),
                SizedBox(
                  width: 5,
                ),
                Text(
                  statusText,
                  style: TextStyle(
                      color: progressColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      isDone
                          ? ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30),
                                ),
                              ),
                              icon: Icon(Icons.check_circle,
                                  color: Colors.white),
                              label: Text('Done',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18)),
                            )
                          : ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30),
                                  side: BorderSide(
                                      color: Colors.green,
                                      width: 1),
                                ),
                              ),
                              icon: Icon(
                                progress == 0.0
                                    ? Icons.play_circle_outline_outlined
                                    : Icons.check_circle_outline_rounded,
                                color: Colors.green,
                              ),
                              label: Text(
                                progress == 0.0 ? 'Start' : 'Done',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18),
                              ),
                            ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors
                                .white,
                            borderRadius:
                                BorderRadius.circular(10),
                            border: Border.all(
                                color: isDone ? Colors.grey : Colors.green,
                                width: 2),
                          ),
                          child: Center(
                            child: Text(
                              '...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20,
                                color: isDone
                                    ? Colors.grey
                                    : Colors
                                        .green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StepIndicator extends StatelessWidget {
  final bool isCompleted;
  final bool isCurrent;
  final Color statusColor;

  const StepIndicator({
    Key? key,
    required this.isCompleted,
    required this.isCurrent,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: isCurrent
          ? Colors.white
          : isCompleted
              ? statusColor
              : Colors.white,
      child: isCompleted
          ? Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
          : isCurrent
              ? ImageIcon(
                  AssetImage("assets/image/circleIcon.png"),
                  color: statusColor,
                  size: 30,
                )
              : ImageIcon(
                  AssetImage("assets/image/onlyCircle.png"),
                  color: Colors.grey,
                  size: 30,
                ),
    );
  }
}

class StepConnector extends StatelessWidget {
  final bool isCompleted;
  final Color progressColor;

  const StepConnector(
      {Key? key, required this.isCompleted, required this.progressColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        color: isCompleted
            ? progressColor
            : Colors.grey[300],
      ),
    );
  }
}
