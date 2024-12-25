import 'package:flutter/material.dart';
import 'package:doctorapp/services/database.dart';

class UpdateEmployeeFormPage extends StatefulWidget {
  @override
  _UpdateEmployeeFormPageState createState() => _UpdateEmployeeFormPageState();
}

class _UpdateEmployeeFormPageState extends State<UpdateEmployeeFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final DatabaseMethods databaseMethods = DatabaseMethods();
  late String id;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // Fetch the employee ID from arguments and load data
      id = ModalRoute.of(context)!.settings.arguments as String;
      _loadEmployeeData();
    });
  }

  void _loadEmployeeData() async {
    try {
      // Fetch existing employee data using the ID
      final data = await databaseMethods.getEmployeeById(id);
      setState(() {
        _nameController.text = data['name'] ?? '';
        _emailController.text = data['email'] ?? '';
        _positionController.text = data['position'] ?? '';
      });
    } catch (e) {
      print("Error loading employee data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading employee data: $e')),
      );
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Update employee data in the database
        await updateEmployeeData(
          id,
          _nameController.text,
          _emailController.text,
          _positionController.text,
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Employee updated successfully!')),
        );

        // Navigate back
        Navigator.pop(context);
      } catch (e) {
        // Handle update error
        print("Error updating employee: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating employee: $e')),
        );
      }
    }
  }

  Future<void> updateEmployeeData(
      String id, String name, String email, String position) async {
    Map<String, dynamic> updatedData = {
      "name": name,
      "email": email,
      "position": position,
      "department": "IT",
      "joiningDate": DateTime.now().toString(),
    };

    await databaseMethods.updateEmployee(updatedData, id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Update Employee Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter employee name',
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
                  hintText: 'Enter employee email',
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
                  hintText: 'Enter employee position',
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
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Update',
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
