import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddClassScreen extends StatefulWidget {
  @override
  _AddClassScreenState createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  String className = '';
  int capacity = 0;
  List<List<bool>> availability = [
    [false, false],
    [false, false],
    [false, false],
    [false, false],
    [false, false],
  ];

  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

  bool isLoading = false;

  void addClass() {
    if (className.isEmpty || capacity == 0) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final classData = {
      'class_name': className,
      'capacity': capacity,
      'availability': availability,
    };

    postClassData(classData);
  }

  Future<void> postClassData(Map<String, dynamic> classData) async {
    final apiUrl = 'https://corp-u.herokuapp.com/addclass';
print(classData);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(classData),
      );

      if (response.statusCode == 200) {
        // Class added successfully
        Navigator.pop(context);
        Navigator.pop(context);
        print('Class added successfully!');
      } else {
        // Failed to add class
        print('Failed to add class');
      }
    } catch (error) {
      print('Error: $error');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Class'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Class Name',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        className = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Capacity',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        capacity = int.tryParse(value) ?? 0;
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Availability',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8.0),
                  DataTable(
                    columns: [
                      DataColumn(
                        label: Text('Day'),
                      ),
                      DataColumn(
                        label: Text('AM'),
                      ),
                      DataColumn(
                        label: Text('PM'),
                      ),
                    ],
                    rows: List.generate(availability.length, (index) {
                      return DataRow(
                        cells: [
                          DataCell(Text(days[index])),
                          DataCell(Checkbox(
                            value: availability[index][0],
                            onChanged: (value) {
                              setState(() {
                                availability[index][0] = value!;
                              });
                            },
                          )),
                          DataCell(Checkbox(
                            value: availability[index][1],
                            onChanged: (value) {
                              setState(() {
                                availability[index][1] = value!;
                              });
                            },
                          )),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: addClass,
                    child: Text('Add Class'),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
