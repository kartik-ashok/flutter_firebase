// import 'package:doctorapp/services/database.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final DatabaseMethods databaseMethods = DatabaseMethods();
//   Stream? employewStream;

//   void addEmployeeData() async {
//     // Define the employee data to add
//     Map<String, dynamic> employeeData = {
//       "name": "John Doe",
//       "age": 30,
//       "position": "Software Engineer",
//       "department": "IT",
//       "joiningDate": DateTime.now().toString(),
//     };

//     // Define a unique employee ID
//     String empId = "EMP001";

//     // Call the addEmployee function
//     try {
//       await databaseMethods.addEmployee(employeeData, empId);
//       print("Employee data added successfully.");
//     } catch (e) {
//       print("Error adding employee data: $e");
//     }
//   }

//   void getEmployeeData() async {
//     try {
//       await databaseMethods.getEmployeeDetails();
//       print("Employee data get successfully.");
//     } catch (e) {
//       print("Error adding employee data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//             child: InkWell(
//                 onTap: () {
//                   addEmployeeData();
//                 },
//                 child: Text('Coming soon')),
//           ),
//           InkWell(
//               onTap: () {
//                 getEmployeeData();
//               },
//               child: Text('Get'))
//           // Container(child: Column(),)
//         ],
//       ),
//     );
//   }
// }

import 'package:doctorapp/services/database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseMethods databaseMethods = DatabaseMethods();
  Stream? employewStream; // Stream variable to hold employee data

  // Function to add employee data to the database
  void addEmployeeData() async {
    // Define the employee data to add
    Map<String, dynamic> employeeData = {
      "name": "Kartik Doe",
      "age": 30,
      "position": "Software Engineer",
      "department": "IT",
      "joiningDate": DateTime.now().toString(),
    };

    // Define a unique employee ID
    String empId = "EMP003";

    // Call the addEmployee function
    try {
      await databaseMethods.addEmployee(employeeData, empId);
      print("Employee data added successfully.");
    } catch (e) {
      print("Error adding employee data: $e");
    }
  }

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

  // Function to update an employee's data
  void updateEmployeeData(String empId) async {
    // Define the updated employee data
    Map<String, dynamic> updatedData = {
      "name": "Updated Kartik Doe",
      "position": "Senior Software Engineer",
      "age": 31, // Example of an updated field
    };

    try {
      await databaseMethods.updateEmployee(updatedData, empId);
      print("Employee with ID $empId updated successfully.");
    } catch (e) {
      print("Error updating employee: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Data')),
      body: Column(
        children: [
          Center(
            child: InkWell(
              onTap: () {
                addEmployeeData();
              },
              child: Text('Add Employee'),
            ),
          ),
          InkWell(
            onTap: () {
              getEmployeeData();
            },
            child: Text('Get Employee Data'),
          ),
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

                    return ListTile(
                      title: Text(employee['name'] ?? 'No name'),
                      subtitle: Text(
                          'Position: ${employee['position'] ?? 'Unknown'}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteEmployeeData(
                                  empId); // Delete employee by ID
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              updateEmployeeData(
                                  empId); // Update employee by ID
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
