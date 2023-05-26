import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class PermanentStaff {
  String id;
  String courseid;

  PermanentStaff({
    required this.id,
    required this.courseid
  });
}
class Applicant {
  final String id;
  final String name;
  final String email;
  final String qualification;

  Applicant({
    required this.id,
    required this.name,
    required this.email,
    required this.qualification,
  });
}

class ApplicantsScreen extends StatefulWidget {
  final String courseId;

  ApplicantsScreen({required this.courseId});

  @override
  _ApplicantsScreenState createState() => _ApplicantsScreenState();
}

class _ApplicantsScreenState extends State<ApplicantsScreen> {
  List<Applicant> applicants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchApplicants();
  }

  Future<void> fetchApplicants() async {
    try {
      final url = Uri.parse('https://corp-u.herokuapp.com/getApplicants/${widget.courseId}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Applicant> fetchedApplicants = data.map((item) {
          return Applicant(
            id: item['_id'],
            name: item['name'],
            email: item['email'],
            qualification: item['qualification'],
          );
        }).toList();

        setState(() {
          applicants = fetchedApplicants;
          isLoading = false;
        });
      } else {
        print('Failed to fetch applicants. Status code: ${response.statusCode}');
        // TODO: Handle error case (e.g., show an error message)
      }
    } catch (e) {
      print('Error fetching applicants: $e');
      // TODO: Handle error case (e.g., show an error message)
    }
  }

  Future<void> showConfirmationDialog(String applicantId, bool isAccepted) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text(isAccepted ? 'Are you sure you want to accept this applicant?' : 'Are you sure you want to reject this applicant?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Yes'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      if (isAccepted) {
        acceptApplication(applicantId);
      } else {
        rejectApplication(applicantId);
      }
    }
  }

  Future<void> acceptApplication(String applicantId) async {
    try {
      final url = Uri.parse('https://corp-u.herokuapp.com/applicationStatus/${applicantId}/${widget.courseId}/assigned');
      final response = await http.put(url);
      print(response.body);
      print(url);

      if (response.statusCode == 200) {
        print('Application accepted');
        // TODO: Handle success case (e.g., show a success message)
      } else {

        print('Failed to accept application. Status code: ${response.statusCode}');
        // TODO: Handle error case (e.g., show an error message)
      }
    } catch (e) {
      print('Error accepting application: $e');
      // TODO: Handle error case (e.g., show an error message)
    }
  }

  Future<void> rejectApplication(String applicantId) async {
    try {
      final url = Uri.parse('https://corp-u.herokuapp.com/applicationStatus/${applicantId}/${widget.courseId}/false');
      print(url);
      final response = await http.put(url);

      if (response.statusCode == 200) {
        print('Application rejected');
        // TODO: Handle success case (e.g., show a success message)
      } else {
        print('Failed to reject application. Status code: ${response.statusCode}');
        // TODO: Handle error case (e.g., show an error message)
      }
    } catch (e) {
      print('Error rejecting application: $e');
      // TODO: Handle error case (e.g., show an error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: applicants.length,
        itemBuilder: (context, index) {
          final applicant = applicants[index];
          return Card(
            child: ListTile(
              title: Text(applicant.name),
              subtitle: Text(applicant.email),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplicantDetailsScreen(applicant: applicant),
                  ),
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      showConfirmationDialog(applicant.id, true);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      showConfirmationDialog(applicant.id, false);
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

class ApplicantDetailsScreen extends StatelessWidget {
  final Applicant applicant;

  ApplicantDetailsScreen({required this.applicant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicant Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${applicant.name}'),
            Text('Email: ${applicant.email}'),
            Text('Qualification: ${applicant.qualification}'),
          ],
        ),
      ),
    );
  }
}
