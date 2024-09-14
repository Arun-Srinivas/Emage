// profile_page.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false; // Track whether we are in edit mode

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController(text: 'Sanjiv Kumar J');
  final TextEditingController _dobController = TextEditingController(text: '01/01/2000');
  final TextEditingController _phoneController = TextEditingController(text: '8181234567');
  final TextEditingController _bloodGroupController = TextEditingController(text: 'A+');
  final TextEditingController _addressController = TextEditingController(text: 'No.1, Gandhi Street, Gandhi Nagar, Puducherry 605 002');
  final TextEditingController _emailController = TextEditingController(text: 'example@mail.com');
  final TextEditingController _emergencyContactController = TextEditingController(text: 'Emergency Contact');

  void _toggleEditMode() {
    if (_isEditing) {
      // Save changes
      // Here you can add logic to save updated data
    }
    setState(() {
      _isEditing = !_isEditing; // Toggle edit mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.white,
          child: Column(
            children: [
              // Profile Picture and Name
              CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('assets/images/profileImage.jpg'), // Replace with your image
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(height: 10),
              // Displaying the name with ValueListenableBuilder
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _nameController,
                builder: (context, value, child) {
                  return Text(
                    value.text, // Use the text from the controller
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Profile Details
              ProfileDetailField(
                icon: Icons.person,
                controller: _nameController,
                isEditable: _isEditing,
              ),
              ProfileDetailField(
                icon: Icons.calendar_today,
                controller: _dobController,
                isEditable: _isEditing,
              ),
              ProfileDetailField(
                icon: Icons.phone,
                controller: _phoneController,
                isEditable: _isEditing,
              ),
              ProfileDetailField(
                icon: Icons.bloodtype,
                controller: _bloodGroupController,
                isEditable: _isEditing,
              ),
              ProfileDetailField(
                icon: Icons.location_on,
                controller: _addressController,
                isEditable: _isEditing,
              ),
              ProfileDetailField(
                icon: Icons.email,
                controller: _emailController,
                isEditable: _isEditing,
              ),
              ProfileDetailField(
                icon: Icons.contacts,
                controller: _emergencyContactController,
                isEditable: _isEditing,
              ),
              const SizedBox(height: 20),
              // Edit Profile Button
              ElevatedButton(
                onPressed: _toggleEditMode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Background color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Text color
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(_isEditing ? 'Save' : 'Edit profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileDetailField extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final bool isEditable;
  final bool isPassword;

  const ProfileDetailField({
    super.key,
    required this.icon,
    required this.controller,
    required this.isEditable,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate height based on text length and available width
          double textHeight = controller.text.isNotEmpty
              ? (TextPainter(
                  text: TextSpan(
                    text: controller.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                  maxLines: null,
                  textDirection: TextDirection.ltr,
                )..layout(maxWidth: constraints.maxWidth))
                  .size
                  .height
              : 0;
          return TextField(
            controller: controller,
            obscureText: isPassword,
            readOnly: !isEditable, // Set readOnly based on edit mode
            minLines: 1,
            maxLines: null, // Allow the field to expand based on content
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.deepPurple),
              labelText: controller.text, // Display the text from the controller
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
