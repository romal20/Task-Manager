import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class AddListScreen extends StatefulWidget {
  @override
  _AddListScreenState createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  bool _isTaskDetailsExpanded = false;
  bool _isTaskCategoryExpanded = false;
  bool _isTaskAllotmentExpanded = false;
  String _selectedCategory = 'Housekeeping';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _assigneeController = TextEditingController();
  String _priority = 'Medium';
  String _reminder = '03 mins before';

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: SafeArea(
                  child: Container(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          'New Task',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(child: Container()),
                        TextButton(
                          onPressed: () {
                            // Save action
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 1,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            Text(
                              'TASK DETAILS',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(
                                _isTaskDetailsExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isTaskDetailsExpanded =
                                      !_isTaskDetailsExpanded;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      if (_isTaskDetailsExpanded)
                        Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                children: [
                                  Text(
                                    'TASK CATEGORY',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                children: [
                                  //SizedBox(width: 30),
                                  Text(
                                    _selectedCategory,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(width: 8),
                                  IconButton(
                                    icon: Icon(
                                      _isTaskCategoryExpanded
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isTaskCategoryExpanded =
                                            !_isTaskCategoryExpanded;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            if (_isTaskCategoryExpanded)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text('Housekeeping'),
                                      onTap: () {
                                        setState(() {
                                          _selectedCategory = 'Housekeeping';
                                          _isTaskCategoryExpanded = false;
                                        });
                                      },
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text('Shopping'),
                                      onTap: () {
                                        setState(() {
                                          _selectedCategory = 'Shopping';
                                          _isTaskCategoryExpanded = false;
                                        });
                                      },
                                    ),
                                    // Add more categories as needed
                                  ],
                                ),
                              ),
                            SizedBox(height: 15,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: Colors.grey[200]!, // very light grey
                                ),
                              ),
                              child: TextField(
                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                controller: _titleController,
                                decoration: InputDecoration(
                                  //labelText: 'Title',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: Colors.grey[200]!, // very light grey
                                ),
                              ),
                              child: TextField(
                                style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.grey[800]),
                                controller: _descriptionController,
                                maxLines: 3,
                                decoration: InputDecoration(
//                                  labelText: 'Description',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 16),
                      ExpansionTile(
                        title: Text('TASK ALLOTMENT',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w600),),
                        initiallyExpanded: _isTaskAllotmentExpanded,
                        onExpansionChanged: (expanded) {
                          setState(() {
                            _isTaskAllotmentExpanded = expanded;
                          });
                        },
                        children: [
                          ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Text('SCHEDULE'),
                            subtitle: Text(DateFormat.yMMMd()
                                .add_jm()
                                .format(_selectedDate)),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text('LOCATION'),
                            subtitle: TextField(
                              controller: _locationController,
                              decoration: InputDecoration(
                                hintText: 'Enter Location',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text('ASSIGN TO'),
                            subtitle: TextField(
                              controller: _assigneeController,
                              decoration: InputDecoration(
                                hintText: 'Enter Assignee',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.priority_high),
                            title: Text('PRIORITY'),
                            subtitle: Text(_priority),
                            onTap: () {
                              setState(() {
                                _priority = _priority == 'Medium'
                                    ? 'High'
                                    : 'Medium'; // Toggle for example
                              });
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.notifications),
                            title: Text('REMINDER'),
                            subtitle: Text(_reminder),
                            onTap: () {
                              setState(() {
                                _reminder = _reminder == '03 mins before'
                                    ? '10 mins before'
                                    : '03 mins before'; // Toggle for example
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text('POINTS'),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.grey[100]!, // Set your desired border color
                              width: 1.0, // Set your desired border width
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Type here & Add Check List',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0), // Adds some space between the TextField and the IconButton
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey), // Adjust the border color
                            ),
                            child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                // Add checklist item
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Column(
                        children: List.generate(10, (index) {
                          return ListTile(
                            leading: Icon(Icons.remove, color: Colors.red),
                            title: Text('Checklist Item $index'),
                            trailing: Icon(Icons.warning, color: Colors.grey),
                          );
                        }),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Show more items
                        },
                        child: Text('Show more'),
                      ),
                      SizedBox(height: 16),
                      SwitchListTile(
                        title: Text('Save this template'),
                        value: false,
                        onChanged: (value) {
                          // Save template toggle
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Create task
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Center(child: Text('Create Task')),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
