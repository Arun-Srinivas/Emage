// hospital_page.dart
import 'package:flutter/material.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  final List<Hospital> _hospitals = [
    Hospital('City Hospital', '123 City Road, Puducherry', false),
    Hospital('Global Care', '78 Avenue Street, Puducherry', false),
    Hospital('Unity Health', '22 Main St, Puducherry', false),
  ];

  void _acceptEmergency(int index) {
    setState(() {
      _hospitals[index].isEmergencyAccepted = true;
    });
    print("${_hospitals[index].name} has accepted the emergency.");
  }

  void _rejectEmergency(int index) {
    setState(() {
      _hospitals[index].isEmergencyAccepted = false;
    });
    print("${_hospitals[index].name} has rejected the emergency.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Hospitals"),
      ),
      body: ListView.builder(
        itemCount: _hospitals.length,
        itemBuilder: (context, index) {
          final hospital = _hospitals[index];
          return ListTile(
            title: Text(hospital.name),
            subtitle: Text(hospital.address),
            trailing: hospital.isEmergencyAccepted
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.cancel, color: Colors.red),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Handle Emergency"),
                    content: Text(
                        "Would you like to accept the emergency at ${hospital.name}?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _rejectEmergency(index);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Reject"),
                      ),
                      TextButton(
                        onPressed: () {
                          _acceptEmergency(index);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Accept"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class Hospital {
  final String name;
  final String address;
  bool isEmergencyAccepted;

  Hospital(this.name, this.address, this.isEmergencyAccepted);
}
