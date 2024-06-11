import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  TextEditingController _newChecklistItemController = TextEditingController();
  String _priority = 'Medium';
  String _reminder = '03 mins before';
  final _formKey = GlobalKey<FormState>();

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

  final List<String> _checklistItems = [
    'Housecleaning',
    'Ironing',
    'Door mat & entrance to be cleaned',
    'Fan blades to be cleaned and no noise',
    'Working AC with remote',
    'Clean ceiling and floor',
    'Working bedside lights',
    'Pillows as per number of guests',
    'Clean blankets and duvets',
    'Fresh linen',
    'Tidy curtains & blinds',
    'Clean balcony, furniture & floor',
    'Stocked, clean dustbin',
  ];

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final newTask = {
        'icon': Icons.task, // Set a default icon for the task
        'iconColor': Colors.blue, // Set a default icon color for the task
        'title': _titleController.text,
        'subtitle': _descriptionController.text,
        'priority': _priority,
        'priorityColor': _priority == 'High'
            ? Colors.red
            : (_priority == 'Medium' ? Colors.orange : Colors.green),
        'assignee': _assigneeController.text,
        'progressStatus': '0%',
        'progressColor': Colors.amber,
        'progress': 0.0,
        'dateTime': DateFormat.yMMMd().add_jm().format(_selectedDate),
        'statusText': 'To do task',
        'statusColor': Colors.amber,
        'isDone': false,
      };

      Navigator.of(context).pop(newTask);
    }
  }

  bool _isChecklistExpanded = false;

  void _toggleChecklistExpansion() {
    setState(() {
      _isChecklistExpanded = !_isChecklistExpanded;
    });
  }

  void _removeChecklistItem(String item) {
    setState(() {
      _checklistItems.remove(item);
    });
  }


  String _newChecklistItem = ''; // Variable to store the text from the TextField

  void _addChecklistItemFromTextField() {
    if (_newChecklistItem.isNotEmpty) {
      setState(() {
        _checklistItems.add(_newChecklistItem);
        _newChecklistItemController.clear(); // Clear the text field
        _newChecklistItem = ''; // Clear the variable
      });
    }
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
          child: Form(
            key: _formKey,
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
                            onPressed: _saveTask,
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
                                child: TextFormField(
                                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                  controller: _titleController,
                                  decoration: InputDecoration(
                                    hintText: 'Title',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a title';
                                    }
                                    return null;
                                  },
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
                                child: TextFormField(
                                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.grey[800]),
                                  controller: _descriptionController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a description';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 16),
                        ExpansionTile(
                          title: Text(
                            'TASK ALLOTMENT',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          initiallyExpanded: _isTaskAllotmentExpanded,
                          onExpansionChanged: (expanded) {
                            setState(() {
                              _isTaskAllotmentExpanded = expanded;
                            });
                          },
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading: Icon(Icons.calendar_today, size: 16),
                                    title: FittedBox(
                                        fit: BoxFit.fill, child: Text('SCHEDULE')),
                                    subtitle: Text(
                                      DateFormat.yMMMd().add_jm().format(_selectedDate),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    leading: Icon(Icons.location_on, size: 16),
                                    title: FittedBox(
                                        fit: BoxFit.fill, child: Text('LOCATION')),
                                    subtitle: TextFormField(
                                      controller: _locationController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Location',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    leading: Icon(Icons.person, size: 16),
                                    title: FittedBox(
                                        fit: BoxFit.fill, child: Text('ASSIGN TO')),
                                    subtitle: TextFormField(
                                      controller: _assigneeController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Assignee',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading: Icon(Icons.priority_high, size: 16),
                                    title: FittedBox(child: Text('PRIORITY')),
                                    subtitle: FittedBox(
                                      child: DropdownButton<String>(
                                        value: _priority,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _priority = newValue!;
                                          });
                                        },
                                        items: <String>['Low', 'Medium', 'High']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    leading: Icon(Icons.notifications, size: 16),
                                    title: FittedBox(child: Text('REMINDER')),
                                    subtitle: FittedBox(
                                      child: DropdownButton<String>(
                                        value: _reminder,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _reminder = newValue!;
                                          });
                                        },
                                        items: <String>['03 mins before', '10 mins before']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: FittedBox(child: Text('')),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'POINTS',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 40,
                          width: 100, // Set the width as needed
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '1000',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'CHECKLIST',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                        //SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _newChecklistItemController,
                                decoration: InputDecoration(
                                  hintText: 'Type here & Add Check List',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black12, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black12, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _newChecklistItem = value; // Update the new checklist item text
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 8), // Add space between TextField and IconButton
                            SizedBox(
                              width: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.green,width: 2), // Border color of the circular border
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.add, color: Colors.green,size:
                                    20,),
                                  onPressed: _addChecklistItemFromTextField,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 200,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _isChecklistExpanded
                                      ? _checklistItems.length + 1 // Add 1 for the minimize button
                                      : (_checklistItems.length > 10 ? 11 : _checklistItems.length),
                                  itemBuilder: (context, index) {
                                    if (_isChecklistExpanded && index == _checklistItems.length) {
                                      // Show minimize button at the end when expanded
                                      return Center(
                                        child: IconButton(
                                          icon: Icon(Icons.keyboard_arrow_up_outlined,color: Colors.green,size: 30,),
                                          onPressed: _toggleChecklistExpansion,
                                        ),
                                      );
                                    } else if (!_isChecklistExpanded && index == 10 && _checklistItems.length > 10) {
                                      // Show maximize button in the 11th position when collapsed
                                      return Center(
                                        child: IconButton(
                                          icon: Icon(Icons.keyboard_arrow_down_outlined,size: 30,color: Colors.green,),
                                          onPressed: _toggleChecklistExpansion,
                                        ),
                                      );
                                    } else if (_isChecklistExpanded || index < 10) {
                                      // Show checklist items
                                      return ListTile(
                                        leading: GestureDetector(
                                          onTap: () => _removeChecklistItem(_checklistItems[index]),
                                          child: Image.asset(
                                            'assets/image/minus_remove.png',
                                            width: 30,
                                            height: 50,
                                          ),
                                        ),
                                        title: Text(_checklistItems[index]),
                                        trailing: Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          child: Icon(Icons.warning, color: Colors.grey, size: 20),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                // Add other widgets below the checklist if needed
                              ],
                            ),
                          ),
                        ),
                        /*ExpansionTile(
                          title: Text(
                            'Show all checklist items',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          children: _checklistItems
                              .take(10) // Show only the first 10 checklist items initially
                              .map((item) => ListTile(
                            leading: GestureDetector(
                              onTap: () => _removeItem(item),
                              child: Image.asset(
                                'assets/image/minus_remove.png',
                                width: 30,
                                height: 50,
                              ),
                            ),
                            title: Text(item),
                            trailing: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Icon(Icons.warning, color: Colors.grey, size: 20),
                            ),
                          ))
                              .toList(),
                        ),*/
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
                          onPressed: _saveTask,
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
<<<<<<< HEAD
              ],
            ),
=======
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
>>>>>>> 5a81b08ae9497480cfda95e20acff7a7900dc65f
          ),
        ),
      ),
    );
  }
}
