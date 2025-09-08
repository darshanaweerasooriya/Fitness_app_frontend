import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class addDetails extends StatefulWidget {
  const addDetails({super.key});

  @override
  State<addDetails> createState() => _addDetailsState();
}

class _addDetailsState extends State<addDetails> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController targetDateController = TextEditingController();

  String _gender = 'Male';
  String _target = 'Body building';

  Future<void> submitData() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString('token');
    //
    // if (token == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Unauthorized: No token found")),
    //   );
    //   return;
    // }
    //
    // final uri = Uri.parse('http://10.0.2.2:3001/api/fitnessassess');
    //
    // final response = await http.post(
    //   uri,
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer $token',
    //   },
    //   body: jsonEncode({
    //     'age': int.parse(ageController.text.trim()),
    //     'height': double.parse(heightController.text.trim()),
    //     'weight': double.parse(weightController.text.trim()),
    //     'gender': _gender,
    //     'target': _target,
    //     'dailyStatus': statusController.text.trim(),
    //     'targetDate': targetDateController.text.trim(),
    //   }),
    // );
    //
    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   final responseData = jsonDecode(response.body);
    //   final result = responseData['result'];
    //
    //   double dailyCalories = double.parse(result['dailyCalories'].toString());
    //   double protein = double.parse(result['protein'].toString());
    //   double water = double.parse(result['water'].toString());
    //
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Details submitted successfully!")),
    //   );
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) =>
    //           results(
    //             dailyCalories: dailyCalories,
    //             protein: protein,
    //             water: water,
    //           ),
    //     ),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Failed to submit details")),
    //   );
    //   print(response.body); // for debugging
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _sectionTitle("Enter Your Details"),
            _fieldLabel("Age"),
            _buildInputField(controller: ageController,
                hint: "e.g. 25",
                icon: Icons.calendar_today),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel("Height (cm)"),
                      _buildInputField(controller: heightController,
                          hint: "e.g. 170",
                          icon: Icons.height),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel("Weight (kg)"),
                      _buildInputField(controller: weightController,
                          hint: "e.g. 70",
                          icon: Icons.monitor_weight),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _fieldLabel("Gender"),
            _radioGroup(
              options: ['Male', 'Female'],
              selectedValue: _gender,
              onChanged: (val) => setState(() => _gender = val),
            ),
            SizedBox(height: 20),
            _fieldLabel("Target"),
            _radioGroup(
              options: ['Flexibility', 'Fat loss'],
              selectedValue: _target,
              onChanged: (val) => setState(() => _target = val),
            ),
            SizedBox(height: 20),
            _fieldLabel("Current Fitness Level "),
            _radioGroup(
              options: ['Beginner', 'Intermediate',  'Advanced'],
              selectedValue: _target,
              onChanged: (val) => setState(() => _target = val),
            ),
            SizedBox(height: 20),
            _fieldLabel("Currently following a diet plan  "),
            _radioGroup(
              options: ['Yes', 'No', ],
              selectedValue: _target,
              onChanged: (val) => setState(() => _target = val),
            ),
            SizedBox(height: 20),
            _fieldLabel("Medical Conditions"),
            _buildInputField(controller: statusController,
                hint: "e.g. Heathy",
                icon: Icons.timeline),
            SizedBox(height: 20),
            _fieldLabel("Target Date"),
            _buildInputField(controller: targetDateController,
                hint: "e.g. 2025-12-31",
                icon: Icons.date_range),
            SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitData,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Submit",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
        label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600));
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
          title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInputField(
      {required TextEditingController controller, required String hint, required IconData icon}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.black),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _radioGroup({required List<
      String> options, required String selectedValue, required Function(String) onChanged}) {
    return Row(
      children: options.map((option) {
        return Row(
          children: [
            Radio<String>(
              value: option,
              groupValue: selectedValue,
              onChanged: (val) => onChanged(val!),
            ),
            Text(option, style: TextStyle(fontSize: 16)),
            SizedBox(width: 10),
          ],
        );
      }).toList(),
    );
  }
}