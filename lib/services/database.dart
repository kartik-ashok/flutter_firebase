import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Add employee data to Firestore
  Future addEmployee(Map<String, dynamic> userInfoMap, String empId) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(empId)
        .set(userInfoMap);
  }

  // Fetch employee details as a stream
  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return FirebaseFirestore.instance.collection('Employee').snapshots();
  }

  // Delete an employee based on employee ID
  Future deleteEmployee(String empId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Employee')
          .doc(empId)
          .delete();
      print("Employee with ID $empId deleted successfully.");
    } catch (e) {
      print("Error deleting employee: $e");
    }
  }

  // Update employee details based on employee ID
  Future updateEmployee(Map<String, dynamic> updatedData, String empId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Employee')
          .doc(empId)
          .update(updatedData);
      print("Employee with ID $empId updated successfully.");
    } catch (e) {
      print("Error updating employee: $e");
    }
  }
}
