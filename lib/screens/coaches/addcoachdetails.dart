import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class coachDetail extends StatefulWidget {
  const coachDetail({super.key});

  @override
  State<coachDetail> createState() => _coachDetailState();
}

class _coachDetailState extends State<coachDetail> {

  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController targetDateController = TextEditingController();


  String _gender = 'Male';
  String _target = 'Fat loss';
  String _fitnessLevel = 'Beginner';
  String _dietPlan = 'No';

  Future<void> submitData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unauthorized: No token found")),
      );
      return;
    }

    final uri = Uri.parse('http://localhost:3001/api/fitnessassess');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'age': int.tryParse(ageController.text.trim()) ?? 0,
          'height': double.tryParse(heightController.text.trim()) ?? 0.0,
          'weight': double.tryParse(weightController.text.trim()) ?? 0.0,
          'gender': _gender,
          'target': _target,
          'fitnessLevel': _fitnessLevel,
          'dietPlan': _dietPlan,
          'medicalCondition': statusController.text.trim(),
          'targetDate': targetDateController.text.trim(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        // if your backend returns calculated values
        if (responseData['result'] != null) {
          final result = responseData['result'];
          double dailyCalories = double.tryParse(result['dailyCalories'].toString()) ?? 0.0;
          double protein = double.tryParse(result['protein'].toString()) ?? 0.0;
          double water = double.tryParse(result['water'].toString()) ?? 0.0;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Details submitted successfully!")),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => result(
                dailyCalories: dailyCalories,
                protein: protein,
                water: water,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Details submitted, but no results returned")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FC),
      // appBar: AppBar(
      //   title: const Text("Enter Your Details"),
      //   backgroundColor: Colors.white,
      //   elevation: 1,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _inputCard(
                title: "Age",
                child: _buildInputField(
                  controller: ageController,
                  hint: "e.g. 25",
                  icon: Icons.calendar_today,
                ),
              ),
              _inputCard(
                title: "Height & Weight",
                child: Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        controller: heightController,
                        hint: "e.g. 170 cm",
                        icon: Icons.height,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInputField(
                        controller: weightController,
                        hint: "e.g. 70 kg",
                        icon: Icons.monitor_weight,
                      ),
                    ),
                  ],
                ),
              ),
              _inputCard(
                title: "Gender",
                child: _radioGroup(
                  options: ['Male', 'Female'],
                  selectedValue: _gender,
                  onChanged: (val) => setState(() => _gender = val),
                ),
              ),
              _inputCard(
                title: "Target",
                child: _radioGroup(
                  options: ['Fat loss', 'Body building', 'Flexibility'],
                  selectedValue: _target,
                  onChanged: (val) => setState(() => _target = val),
                ),
              ),
              _inputCard(
                title: "Fitness Level",
                child: _radioGroup(
                  options: ['Beginner', 'Intermediate', 'Advanced'],
                  selectedValue: _fitnessLevel,
                  onChanged: (val) => setState(() => _fitnessLevel = val),
                ),
              ),
              _inputCard(
                title: "Following a Diet Plan?",
                child: _radioGroup(
                  options: ['Yes', 'No'],
                  selectedValue: _dietPlan,
                  onChanged: (val) => setState(() => _dietPlan = val),
                ),
              ),
              _inputCard(
                title: "Medical Conditions",
                child: _buildInputField(
                  controller: statusController,
                  hint: "e.g. Healthy",
                  icon: Icons.timeline,
                ),
              ),
              _inputCard(
                title: "Target Date",
                child: _buildInputField(
                  controller: targetDateController,
                  hint: "e.g. 2025-12-31",
                  icon: Icons.date_range,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Submit",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildInputField(
      {required TextEditingController controller,
        required String hint,
        required IconData icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.green),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _radioGroup(
      {required List<String> options,
        required String selectedValue,
        required Function(String) onChanged}) {
    return Wrap(
      spacing: 10,
      children: options.map((option) {
        return ChoiceChip(
          label: Text(option),
          selected: selectedValue == option,
          onSelected: (val) {
            if (val) onChanged(option);
          },
          selectedColor: Colors.green,
          labelStyle: TextStyle(
            color: selectedValue == option ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}