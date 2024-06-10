import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ohsm/src/features/screens/completion.dart';
import 'package:ohsm/src/features/screens/dashboard_screen.dart';
import 'package:ohsm/src/features/screens/inprogress.dart';
import 'package:ohsm/src/features/screens/overdue.dart';
import 'package:ohsm/src/features/screens/task_list.dart';
import 'package:ohsm/src/features/screens/todo.dart';

class TaskOverviewSection extends StatefulWidget {
  @override
  _TaskOverviewSectionState createState() => _TaskOverviewSectionState();
}

class _TaskOverviewSectionState extends State<TaskOverviewSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      return;
    }

    if (_tabController.index == 0) {
      Get.offAll(() => DashboardScreen()); // Navigate to the Task Overview Page
    } else {
      setState(() {
        selectedIndex = null;
      });
    }
  }

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        Get.offAll(() => Todo());
        break;
      case 1:
        Get.offAll(() => Overdue());
        break;
      case 2:
        Get.offAll(() => InProgress());
        break;
      case 3:
        Get.offAll(() => Completion());
        break;
      default:
        Get.offAll(() => TaskList());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.pink,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(100),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            GestureDetector(
              onTap: () {
                Get.offAll(() => DashboardScreen()); // Navigate to the Task Overview Page
              },
              child: Tab(text: 'Task Overview', height: 40),
            ),
            Tab(text: 'My SOP\'s', height: 40),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          height: 100, // Adjust this height as needed
          child: TabBarView(
            controller: _tabController,
            children: [
              // Task Overview Tab
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 4.5,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  String text;
                  int taskCount;
                  Color color;

                  switch (index) {
                    case 0:
                      text = 'To Do Task';
                      taskCount = 16;
                      color = Colors.amber;
                      break;
                    case 1:
                      text = 'Overdue';
                      taskCount = 16;
                      color = Colors.red;
                      break;
                    case 2:
                      text = 'In-progress';
                      taskCount = 16;
                      color = Colors.deepOrangeAccent;
                      break;
                    case 3:
                      text = 'Completed';
                      taskCount = 16;
                      color = Colors.green;
                      break;
                    default:
                      text = 'Unknown';
                      taskCount = 0;
                      color = Colors.grey;
                  }

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: color,
                      backgroundColor: selectedIndex == index ? color.withOpacity(0.2) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: color),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      print(text);
                      navigateToPage(index);
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(height: 38,),
                            ImageIcon(
                              AssetImage("assets/image/circle.png",),
                              size: 18,
                              color: color,
                            ),
                            Spacer(),
                            Text(
                              text + " ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                            ),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                            Text(
                              taskCount.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),

              // My SOP's Tab
              Center(child: Text('My SOP\'s Content')), // Replace with actual content
            ],
          ),
        ),
      ],
    );
  }
}
