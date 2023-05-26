import 'package:flutter/material.dart';

class Applicant {
  final String id;
  final String name;
  final String status;

  Applicant({required this.id, required this.name, required this.status});
}

class ApplicationsScreen extends StatefulWidget {
  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> with SingleTickerProviderStateMixin {
  List<Applicant> allApplications = [];
  List<Applicant> acceptedApplications = [];
  bool isLoading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchApplications();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchApplications() async {
    // Simulating the API call delay with a delay of 2 seconds
    await Future.delayed(Duration(seconds: 2));

    // Dummy data for testing
    List<Applicant> dummyData = [
      Applicant(id: '1', name: 'Muhammad Muneeb', status: 'Pending'),
      Applicant(id: '2', name: 'Rahul JiJi', status: 'Accepted'),
      Applicant(id: '3', name: 'Usama Abdul Rehman', status: 'Rejected'),
      // Applicant(id: '4', name: 'Bob Williams', status: 'Pending'),
      // Applicant(id: '5', name: 'Sarah Thompson', status: 'Accepted'),
    ];

    setState(() {
      allApplications = dummyData;
      acceptedApplications = allApplications.where((applicant) => applicant.status == 'Accepted').toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Accepted'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ApplicationsList(applications: allApplications),
                ApplicationsList(applications: acceptedApplications),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ApplicationsList extends StatelessWidget {
  final List<Applicant> applications;

  ApplicationsList({required this.applications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: applications.length,
      itemBuilder: (context, index) {
        final applicant = applications[index];
        return ListTile(
          title: Text(applicant.name),
          subtitle: Text(applicant.status),
        );
      },
    );
  }
}
