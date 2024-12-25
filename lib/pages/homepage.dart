import 'package:doctorapp/common%20widgets/custom_appbar.dart';
import 'package:doctorapp/common%20widgets/drawer.dart';
import 'package:doctorapp/pages/add_employee.dart';
import 'package:doctorapp/pages/update_employee.dart';
import 'package:doctorapp/provider/theme_provider.dart';
import 'package:doctorapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseMethods databaseMethods = DatabaseMethods();
  Stream? employewStream; // Stream variable to hold employee data
  TextEditingController _nameController = TextEditingController();
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _PositionController = TextEditingController();

  // Function to get employee data and set the stream
  void getEmployeeData() async {
    try {
      var stream = await databaseMethods.getEmployeeDetails();
      setState(() {
        employewStream = stream; // Set the stream to update the UI
      });
      print("Employee data fetched successfully.");
    } catch (e) {
      print("Error fetching employee data: $e");
    }
  }

  // Function to delete an employee by their ID
  void deleteEmployeeData(String empId) async {
    try {
      await databaseMethods.deleteEmployee(empId);
      print("Employee with ID $empId deleted successfully.");
    } catch (e) {
      print("Error deleting employee: $e");
    }
  }

  // // Function to update an employee's data
  // void updateEmployeeData(String empId) async {
  //   // Define the updated employee data
  //   Map<String, dynamic> updatedData = {
  //     "name": "Updated Kartik Doe",
  //     "position": "Senior Software Engineer",
  //     "age": 31, // Example of an updated field
  //   };

  //   try {
  //     await databaseMethods.updateEmployee(updatedData, empId);
  //     print("Employee with ID $empId updated successfully.");
  //   } catch (e) {
  //     print("Error updating employee: $e");
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(title: "EMPLOYEES"),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Display employee data if available
            Expanded(
              child: StreamBuilder(
                stream: employewStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No employee data available.'));
                  }

                  var querySnapshot = snapshot.data;
                  var employeeData =
                      querySnapshot.docs; // Get the list of document snapshots

                  return ListView.builder(
                    itemCount: employeeData.length,
                    itemBuilder: (context, index) {
                      var employee =
                          employeeData[index].data(); // Get the document data
                      String empId =
                          employeeData[index].id; // Get the document ID

                      return Card(
                        color: Colors
                            .green[50], // Light green background for the card
                        elevation: 5, // Card shadow for depth
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Employee info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      employee['name'] ?? 'No name',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[
                                            800], // Green text for the name
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Position: ${employee['position'] ?? 'Unknown'}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green[
                                            600], // Darker green for position
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Employee ID: $empId',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green[
                                            500], // Lighter green for empId
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Joined: ${employee['joiningDate'] ?? 'N/A'}',
                                      style:
                                          // Theme.of(context).textTheme.bodyLarge,
                                          TextStyle(
                                        fontSize: 14,
                                        color: Colors.green[
                                            400], // Even lighter green for date
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Action buttons (Edit & Delete)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      deleteEmployeeData(
                                          empId); // Call delete function
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              settings: RouteSettings(
                                                  arguments: empId),
                                              builder: (context) =>
                                                  UpdateEmployeeFormPage()));
                                    },
                                  ),
                                ],
                              ),
                              // ----------------
                              Switch(
                                value: themeProvider.isDarkMode,
                                onChanged: (value) {
                                  themeProvider.toggleTheme();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity, // Make the button take full width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SubmitFormPage();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Green button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
