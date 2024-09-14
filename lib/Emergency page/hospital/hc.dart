import 'package:flutter/material.dart';
class HospitalConfirmationPage extends StatelessWidget {
 const HospitalConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hospital Response')),
      body: Padding(
        padding: const EdgeInsets.all(16+.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Emergency Accepted for:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
               'hospital.name',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 10),
              const Text(
                'Location:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to hospital list
                  Navigator.pop(context);
                },
                child: const Text('Back to Emergencies'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}