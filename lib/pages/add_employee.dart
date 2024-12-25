import 'package:doctorapp/services/database.dart';
import 'package:doctorapp/utils.dart';
import 'package:flutter/material.dart';

class SubmitFormPage extends StatefulWidget {
  @override
  _SubmitFormPageState createState() => _SubmitFormPageState();
}

class _SubmitFormPageState extends State<SubmitFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for the form
  final DatabaseMethods databaseMethods = DatabaseMethods();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Pass the controller values to the addEmployeeData function
      addEmployeeData(
        _nameController.text,
        _emailController.text,
        _positionController.text,
      );

      // If the form is valid, perform submission logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
    }
  }

// Function to add employee data to the database, accepting the controller values
  void addEmployeeData(String name, String email, String position) async {
    // Define the employee data to add, dynamically taken from text controllers
    Map<String, dynamic> employeeData = {
      "name": name,
      "email": email,
      "position": position,
      "department": "IT", // You can modify this or make it dynamic
      "joiningDate": DateTime.now().toString(),
    };

    // Define a unique employee ID
    String empId = UtilityFunctions.generateUniqueId();

    // Call the addEmployee function
    try {
      await databaseMethods.addEmployee(employeeData, empId);
      print("Employee data added successfully.");
    } catch (e) {
      print("Error adding employee data: $e");
    } finally {
      _nameController.clear();
      _emailController.clear();
      _positionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Your Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter Your Details',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Position Field
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(
                  labelText: 'Position',
                  hintText: 'Enter your position',
                  prefixIcon: Icon(Icons.work),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Position is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Green button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
