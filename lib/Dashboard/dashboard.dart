import 'package:corp_u/Dashboard/listofapplicants.dart';
import 'package:flutter/material.dart';

import 'addclass.dart';
import 'allandaccepted.dart';
import 'newschedule.dart';


class HomeScreen extends StatefulWidget {
  final PermanentStaff data;
  const HomeScreen({super.key, required this.data});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;




  //ClassScreen
  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      ScheduleScreen(permanentStaff: widget.data,),
      ApplicantsScreen( courseId: widget.data.courseid,),
      ApplicationsScreen(),
    ];
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              // ListTile(
              //   leading: Icon(Icons.schedule),
              //   title: Text('Make a Schedule'),
              //   onTap: () {
              //     // Navigate to the Make a Schedule screen
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.location_on),
              //   title: Text('Available Units'),
              //   onTap: () {
              //     // Navigate to the Available Units screen
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  // Navigate to the Profile screen
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('List of Applicants'),
                onTap: () {
                  // Navigate to the List of Applicants screen
                },
              ),
              ListTile(
                leading: Icon(Icons.meeting_room),
                title: Text('Add Class'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddClassScreen()
                    ),
                  );
                  // Navigate to the Profile screen
                },
              ),
            ],
          ),
        ),
      appBar: AppBar(
        title: Text('Corp U'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}

// class ScheduleScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Schedule Screen'),
//     );
//   }
// }
//
// class ApplicationsScreen extends StatefulWidget {
//   final PermanentStaff data;
//   ApplicationsScreen({required this.data});
//   @override
//   State<ApplicationsScreen> createState() => _ApplicationsScreenState();
// }
//
// class _ApplicationsScreenState extends State<ApplicationsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return ApplicantListScreen(data: widget.data,);
//   }
// }

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Dashboard Screen'),
    );
  }
}