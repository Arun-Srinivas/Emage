import 'package:flutter/material.dart';
import 'package:flutter_auth/Profile/profile.dart';
import 'package:flutter_auth/Emergency%20page/hospital/hospital.dart';
import 'dart:async';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  Timer? _longPressTimer;
  bool _isButtonPressed = false;
  bool _isColorChanged = false;
  bool _showCancelButton = false;
  String? _selectedEmergencyType;

  void _startLongPressTimer() {
    setState(() {
      _isButtonPressed = true;
    });
    _longPressTimer = Timer(const Duration(seconds: 3), () {
      if (_isButtonPressed) {
        setState(() {
          _isColorChanged = true;
          _showCancelButton = true; // Show cancel button after 3 seconds
        });
        print("SOS alert triggered!");
      }
    });
  }

  void _cancelLongPressTimer() {
    _longPressTimer?.cancel();
    setState(() {
      _isButtonPressed = false;
      _isColorChanged = false;
      _showCancelButton = false; // Hide cancel button when action is canceled
    });
  }

  void _handleEmergencyOption(String label) {
    setState(() {
      _selectedEmergencyType = label;
    });
    print("Emergency option pressed: $label");
  }

  void _onBottomNavBarTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HospitalPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  void dispose() {
    _longPressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Colors.blue),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Location',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  '4th Mound road, Puducherry',
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Are you in an emergency?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                text: "Press and hold the SOS button for ",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                children: <TextSpan>[
                  TextSpan(
                    text: "3 SECONDS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(text: " to send an alert."),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: GestureDetector(
                onLongPressStart: (details) {
                  _startLongPressTimer();
                },
                onLongPressEnd: (details) {
                  if (!_isColorChanged) {
                    _cancelLongPressTimer();
                  }
                },
                onLongPressCancel: () {
                  if (!_isColorChanged) {
                    _cancelLongPressTimer();
                  }
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _isColorChanged
                        ? const RadialGradient(
                            colors: [Colors.red, Colors.redAccent],
                            stops: [0.5, 1.0],
                          )
                        : const RadialGradient(
                            colors: [Colors.orange, Colors.red],
                            stops: [0.5, 1.0],
                          ),
                  ),
                  child: const Center(
                    child: Text(
                      "SOS",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_showCancelButton)
              Center(
                child: IconButton(
                  onPressed: _cancelLongPressTimer,
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            const SizedBox(height: 40),
            const Text(
              "What's your emergency?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                EmergencyOption(
                  icon: Icons.local_hospital,
                  label: 'Medical',
                  color: Colors.green,
                  isSelected: _selectedEmergencyType == 'Medical',
                  onTap: () => _handleEmergencyOption('Medical'),
                ),
                EmergencyOption(
                  icon: Icons.local_fire_department,
                  label: 'Fire',
                  color: Colors.red,
                  isSelected: _selectedEmergencyType == 'Fire',
                  onTap: () => _handleEmergencyOption('Fire'),
                ),
                EmergencyOption(
                  icon: Icons.car_crash,
                  label: 'Accident',
                  color: Colors.blue,
                  isSelected: _selectedEmergencyType == 'Accident',
                  onTap: () => _handleEmergencyOption('Accident'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: _onBottomNavBarTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Hospitals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class EmergencyOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const EmergencyOption({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }
}