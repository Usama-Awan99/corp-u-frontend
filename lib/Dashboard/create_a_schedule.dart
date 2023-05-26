import 'package:flutter/material.dart';

class CreateScheduleScreen extends StatefulWidget {
  @override
  _CreateScheduleScreenState createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
  final TextEditingController _unitController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tutorController = TextEditingController();

  String _selectedTutor = '';
  String _selectedUnit = '';
  String _selectedDay = '';
  String _selectedStartTime = '';
  String _selectedEndTime = '';

  List<String> _tutorList = [
    '',
    'Tutor A',
    'Tutor B',
    'Tutor C',
  ];

  List<String> _unitList = [
    '',
    'Unit A',
    'Unit B',
    'Unit C',
  ];

  List<String> _dayList = [
    '',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  List<String> _startTimeList = [
    '',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',

  ];

  List<String> _endTimeList = [
    '',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  void _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedStartTime = pickedTime.format(context);
      });
    }
  }

  void _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 0),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedEndTime = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tutor',
                style: TextStyle(fontSize: 18.0),
              ),
              DropdownButtonFormField<String>(
                value: _selectedTutor,
                items: _tutorList
                    .map(
                      (tutor) => DropdownMenuItem<String>(
                        value: tutor,
                        child: Text(tutor),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTutor = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Unit',
                style: TextStyle(fontSize: 18.0),
              ),
              DropdownButtonFormField<String>(
                value: _selectedUnit,
                items: _unitList
                    .map(
                      (unit) => DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUnit = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Day',
                style: TextStyle(fontSize: 18.0),
              ),
              DropdownButtonFormField<String>(
                value: _selectedDay,
                items: _dayList
                    .map(
                      (day) => DropdownMenuItem<String>(
                        value: day,
                        child: Text(day),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDay = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              // Text(
              //   'Start Time',
              //   style: TextStyle(fontSize: 18.0),
              // ),
              // DropdownButtonFormField<String>(
              //   value: _selectedStartTime,
              //   items: _startTimeList
              //       .map(
              //         (startTime) => DropdownMenuItem<String>(
              //       value: startTime,
              //       child: Text(startTime),
              //     ),
              //   )
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedStartTime = value!;
              //     });
              //   },
              // ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5)
                ),
                child: GestureDetector(
                  onTap: ()=>_selectStartTime(context),
                  child: Text(
                    'Select Start Time $_selectedStartTime',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5)
                ),
                child: GestureDetector(
                  onTap: ()=>_selectEndTime(context),
                  child: Text(
                    'Select End Time $_selectedEndTime',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),

              // DropdownButtonFormField<String>(
              //   value: _selectedEndTime,
              //   items: _endTimeList
              //       .map(
              //         (endtime) => DropdownMenuItem<String>(
              //       value: endtime,
              //       child: Text(endtime),
              //     ),
              //   )
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedEndTime = value!;
              //     });
              //   },
              // ),
              SizedBox(height: 16.0),
              Text(
                'Unit',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _unitController,
                decoration: InputDecoration(
                  hintText: 'Enter unit',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a unit';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Tutor',
                style: TextStyle(fontSize: 18.0),
              ),
              TextFormField(
                controller: _tutorController,
                decoration: InputDecoration(
                  hintText: 'Enter tutor',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a tutor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveSchedule();
                      }
                    },
                    child: Text('Save Schedule             '),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveSchedule();
                      }
                    },
                    child: Text('Show Saved Schedule'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSchedule() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, so save the schedule data to a database or server
      String tutor = _tutorController.text;
      String unit = _unitController.text;
      String day = _selectedDay!;
      String startTime = _selectedStartTime!;
      String endTime = _selectedEndTime!;

      // Save the data to a database or server
      // ...

      // Show a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Schedule created successfully')),
      );

      // Clear the form fields
      _tutorController.clear();
      _unitController.clear();
      setState(() {
        _selectedDay = '';
        _selectedStartTime = '';
        _selectedEndTime = '';
      });
    }
  }
}
