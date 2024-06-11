import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddListScreen extends StatefulWidget {
  @override
  _AddListScreenState createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  bool _isTaskDetailsExpanded = false;
  bool _saveTemplate = false;
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
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  final List<String> _checklistItems = [
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
        'icon': Icons.task,
        'iconColor': Colors.blue,
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

  void _removeChecklistItem(String item) async {
    setState(() {
      _checklistItems.remove(item);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('checklistItems', _checklistItems);
  }

  String _newChecklistItem =
      '';

  void _addChecklistItemFromTextField() async {
    if (_newChecklistItem.isNotEmpty) {
      setState(() {
        _checklistItems.add(_newChecklistItem);
        _newChecklistItemController.clear();
        _newChecklistItem = '';
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('checklistItems', _checklistItems);
    }
  }

  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void initState() {
    super.initState();
    _loadChecklistItems();
  }

  void _loadChecklistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedItems = prefs.getStringList('checklistItems');
    if (savedItems != null) {
      setState(() {
        _checklistItems.addAll(savedItems);
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.green),
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
                              SizedBox(width: 30),
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
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

                                    ],
                                  ),
                                ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                  ),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
                                    color: Colors.grey[200]!,
                                  ),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.grey[800]),
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





                        InkWell(
                          onTap: _toggleExpansion,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'TASK ALLOTMENT',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                _isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: _isExpanded ? null : 0,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      leading:
                                          Icon(Icons.calendar_today, size: 16),
                                      title: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text('SCHEDULE')),
                                      subtitle: Text(
                                        DateFormat.yMMMd()
                                            .add_jm()
                                            .format(_selectedDate),
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      leading:
                                          Icon(Icons.location_on, size: 16),
                                      title: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text('LOCATION'),
                                      ),
                                      subtitle: TextField(
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
                                        fit: BoxFit.fill,
                                        child: Text('ASSIGN TO'),
                                      ),
                                      subtitle: TextField(
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
                                      leading:
                                          Icon(Icons.priority_high, size: 16),
                                      title: FittedBox(child: Text('PRIORITY')),
                                      subtitle: FittedBox(
                                        child: DropdownButton<String>(
                                          value: _priority,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _priority = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'Low',
                                            'Medium',
                                            'High'
                                          ]
                                              .map<DropdownMenuItem<String>>(
                                                (String value) =>
                                                    DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                        leading:
                                            Icon(Icons.notifications, size: 16),
                                        title:
                                            FittedBox(child: Text('REMINDER')),
                                        subtitle: FittedBox(
                                          child: DropdownButton<String>(
                                            value: _reminder,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _reminder = newValue!;
                                              });
                                            },
                                            items: <String>[
                                              '03 mins before',
                                              '10 mins before'
                                            ]
                                                .map<DropdownMenuItem<String>>(
                                                  (String value) =>
                                                      DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        )),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_outline_rounded,
                              color: Colors.grey[400],
                            ),
                            Text(
                              'POINTS',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '1000',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
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
                                    borderSide: BorderSide(
                                        color: Colors.black12, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black12, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _newChecklistItem =
                                        value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                                width:
                                    8),
                            SizedBox(
                              width: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.green,
                                      width:
                                          2),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  onPressed: _addChecklistItemFromTextField,
                                ),
                              ),
                            ),
                          ],
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

                        Container(
                          height: 300,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _isChecklistExpanded
                                      ? _checklistItems.length +
                                          1
                                      : (_checklistItems.length > 10
                                          ? 11
                                          : _checklistItems.length),
                                  itemBuilder: (context, index) {
                                    if (_isChecklistExpanded &&
                                        index == _checklistItems.length) {

                                      return Center(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.keyboard_arrow_up_outlined,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                          onPressed: _toggleChecklistExpansion,
                                        ),
                                      );
                                    } else if (!_isChecklistExpanded &&
                                        index == 10 &&
                                        _checklistItems.length > 10) {

                                      return Center(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            size: 30,
                                            color: Colors.green,
                                          ),
                                          onPressed: _toggleChecklistExpansion,
                                        ),
                                      );
                                    } else if (_isChecklistExpanded ||
                                        index < 10) {

                                      return ListTile(
                                        leading: GestureDetector(
                                          onTap: () => _removeChecklistItem(
                                              _checklistItems[index]),
                                          child: Image.asset(
                                            'assets/image/minus_remove.png',
                                            width: 30,
                                            height: 50,
                                          ),
                                        ),
                                        title: Text(
                                          _checklistItems[index],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        trailing: Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: Icon(Icons.warning,
                                              color: Colors.grey, size: 20),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),

                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: SwitchListTile(
                            activeColor: Colors.green,
                            inactiveTrackColor: Colors.grey,
                            title: Center(
                                child: Text(
                              'Save this template',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            )),
                            value: _saveTemplate,
                            onChanged: (value) {
                              setState(() {
                                _saveTemplate = value;
                              });

                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _saveTask,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            'Create Task',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
