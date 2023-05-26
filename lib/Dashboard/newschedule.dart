// import 'package:flutter/material.dart';
//
// class ScheduleScreen extends StatefulWidget {
//   @override
//   _ScheduleScreenState createState() => _ScheduleScreenState();
// }
//
// class _ScheduleScreenState extends State<ScheduleScreen> {
//   List<Map<String, dynamic>> schedule = [];
//
//   List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
//   List<String> times = ['AM', 'PM'];
//   List<String> courses = ['Course A', 'Course B', 'Course C'];
//   List<String> applicants = ['Applicant 1', 'Applicant 2', 'Applicant 3'];
//
//   String? selectedDay;
//   String? selectedTime;
//   String? selectedCourse;
//   String? selectedApplicant;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedDay = days[0];
//     selectedTime = times[0];
//     selectedCourse = courses[0];
//     selectedApplicant = applicants[0];
//   }
//
//   void addSchedule() {
//     setState(() {
//       schedule.add({
//         'day': selectedDay!,
//         'time': selectedTime!,
//         'course': selectedCourse!,
//         'applicant': selectedApplicant!,
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Create Schedule',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: DropdownButtonFormField<String>(
//                     value: selectedDay,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedDay = value;
//                       });
//                     },
//                     items: days.map((day) {
//                       return DropdownMenuItem<String>(
//                         value: day,
//                         child: Text(day),
//                       );
//                     }).toList(),
//                     decoration: InputDecoration(
//                       labelText: 'Day',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8.0),
//                 Expanded(
//                   child: DropdownButtonFormField<String>(
//                     value: selectedTime,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedTime = value;
//                       });
//                     },
//                     items: times.map((time) {
//                       return DropdownMenuItem<String>(
//                         value: time,
//                         child: Text(time),
//                       );
//                     }).toList(),
//                     decoration: InputDecoration(
//                       labelText: 'Time',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: DropdownButtonFormField<String>(
//               value: selectedCourse,
//               onChanged: (value) {
//                 setState(() {
//                   selectedCourse = value;
//                 });
//               },
//               items: courses.map((course) {
//                 return DropdownMenuItem<String>(
//                   value: course,
//                   child: Text(course),
//                 );
//               }).toList(),
//               decoration: InputDecoration(
//                 labelText: 'Course',
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: DropdownButtonFormField<String>(
//               value: selectedApplicant,
//               onChanged: (value) {
//                 setState(() {
//                   selectedApplicant = value;
//                 });
//               },
//               items: applicants.map((applicant) {
//                 return DropdownMenuItem<String>(
//                   value: applicant,
//                   child: Text(applicant),
//                 );
//               }).toList(),
//               decoration: InputDecoration(
//                 labelText: 'Applicant',
//               ),
//             ),
//           ),
//           SizedBox(height: 16.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: ElevatedButton(
//               onPressed: addSchedule,
//               child: Text('Add'),
//             ),
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             '      Schedule',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: schedule.length,
//               itemBuilder: (context, index) {
//                 final entry = schedule[index];
//                 return Card(
//                   margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                   child: ListTile(
//                     title: Text(
//                       '${entry['day']}, ${entry['time']} - ${entry['course']}',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text('Applicant: ${entry['applicant']}'),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:convert';

import 'package:corp_u/Dashboard/allandaccepted.dart';
import 'package:corp_u/Dashboard/listofapplicants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScheduleScreen extends StatefulWidget {
  PermanentStaff permanentStaff;

  ScheduleScreen({required this.permanentStaff});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Map<String, dynamic>> schedule = [];

  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  List<String> times = ['AM', 'PM'];
  List<String> courses = ['Bs Mathematics',];
  List<String> applicants = ['Rahul Ji Ji'];

  Future<void> fetchData() async {

    final apiUrl = 'https:/corp-u.herokuapp.com/courses'; // Replace with your API endpoint

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Map<String, dynamic>> fetchedCourses =
      data.map((item) => item as Map<String, dynamic>).toList();
      setState(() {
        courses = fetchedCourses.cast<String>();
      });
    } else {
      throw Exception('Failed to fetch courses');
    }
  }

  String? selectedDay;
  String? selectedTime;
  String? selectedCourse;
  String? selectedApplicant;

  @override
  void initState() {
    super.initState();
    fetchData();
    selectedDay = days[0];
    selectedTime = times[0];
    selectedCourse = courses[0];
    selectedApplicant = applicants[0];
  }

  void addSchedule() {
    setState(() {
      schedule.add({
        'day': selectedDay!,
        'time': selectedTime!,
        'course': selectedCourse!,
        'applicant': selectedApplicant!,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Schedule',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Day',
                style: TextStyle(fontSize: 18),
              ),
              DropdownButtonFormField<String>(
                value: selectedDay,
                onChanged: (value) {
                  setState(() {
                    selectedDay = value;
                  });
                },
                items: days.map((day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              Text(
                'Time',
                style: TextStyle(fontSize: 18),
              ),
              DropdownButtonFormField<String>(
                value: selectedTime,
                onChanged: (value) {
                  setState(() {
                    selectedTime = value;
                  });
                },
                items: times.map((time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              Text(
                'Course',
                style: TextStyle(fontSize: 18),
              ),
              DropdownButtonFormField<String>(
                value: selectedCourse,
                onChanged: (value) {
                  setState(() {
                    selectedCourse = value;
                  });
                },
                items: courses.map((course) {
                  return DropdownMenuItem<String>(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              Text(
                'Applicant',
                style: TextStyle(fontSize: 18),
              ),
              DropdownButtonFormField<String>(
                value: selectedApplicant,
                onChanged: (value) {
                  setState(() {
                    selectedApplicant = value;
                  });
                },
                items: applicants.map((applicant) {
                  return DropdownMenuItem<String>(
                    value: applicant,
                    child: Text(applicant),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: addSchedule,
                child: Text('Add Schedule'),
              ),
              SizedBox(height: 32.0),
              Text(
                'Schedule',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: schedule.length,
                  itemBuilder: (context, index) {
                    final entry = schedule[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          '${entry['day']}, ${entry['time']} - ${entry['course']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Applicant: ${entry['applicant']}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// shedule = {
//   "Day":"Monday",
// "Time":"AM",
// "Course":"45345345454534",
// "tutor":"4354534",
// "Pid":"IDdfdf",
// "Roomno":"234"
// }
