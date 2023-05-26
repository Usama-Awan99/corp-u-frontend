import 'package:corp_u/Dashboard/listofapplicants.dart';
import 'package:flutter/material.dart';

class Applicant {
  final String name;
  final String phone;
  final String date;
  final String experience;
  final String education;
  final String availabilityDay;
  final String availabilityTime;
  bool accepted;

  Applicant({
    required this.name,
    required this.phone,
    required this.date,
    required this.experience,
    required this.education,
    required this.availabilityDay,
    required this.availabilityTime,
    this.accepted = false,
  });
}

class ApplicantListScreen extends StatefulWidget {
  final String courseUnit;

  ApplicantListScreen({required this.courseUnit, required PermanentStaff data});

  @override
  _ApplicantListScreenState createState() => _ApplicantListScreenState();
}

class _ApplicantListScreenState extends State<ApplicantListScreen> {
  List<Applicant> _applicants = [
    Applicant(
      name: 'Rahul JiJi',
      phone: '07587652',
      date: 'May 4, 2023',
      experience: '2 years of teaching experience',
      education: 'Bachelor of Education',
      availabilityDay: 'Monday, Wednesday, Friday',
      availabilityTime: '9am-12pm',
      accepted: true,
    ),
    Applicant(
      name: 'Muhammad Muneeb',
      phone: '0987654321',
      date: 'May 5, 2023',
      experience: '5 years of teaching experience',
      education: 'Master of Education',
      availabilityDay: 'Tuesday, Thursday',
      availabilityTime: '1pm-4pm',

    ),
    Applicant(
      name: 'Usama Abdul Rehman',
      phone: '5555555555',
      date: 'May 6, 2023',
      experience: '1 year of teaching experience',
      education: 'Bachelor of Arts',
      availabilityDay: 'Monday, Wednesday, Friday',
      availabilityTime: '10am-2pm',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemCount: _applicants.length,
        itemBuilder: (context, index) {
          final applicant = _applicants[index];
          return Card(
            child: ListTile(
              title: Text(applicant.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phone: ${applicant.phone}'),
                  Text('Date Applied: ${applicant.date}'),
                  Text('Experience: ${applicant.experience}'),
                  Text('Education: ${applicant.education}'),
                  Text('Availability: ${applicant.availabilityDay} ${applicant.availabilityTime}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check),
                    color: applicant.accepted ? Colors.green : null,
                    onPressed: () {
                      setState(() {
                        applicant.accepted = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: applicant.accepted == false ? Colors.red : null,
                    onPressed: () {
                      setState(() {
                        applicant.accepted = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
