import 'package:finessmobileapp/screens/auth/coaches/coachLoging.dart';
import 'package:finessmobileapp/screens/coaches/feedbackCoach.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class coachDarhsboard extends StatefulWidget {
  const coachDarhsboard({super.key});

  @override
  State<coachDarhsboard> createState() => _coachDarhsboardState();
}

class _coachDarhsboardState extends State<coachDarhsboard> {
  double? height;
  double? weight;
  bool isLoading = true;
  String? username; // ✅ username from token

  @override
  void initState() {
    super.initState();
    loadAssessment();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedName = prefs.getString('username'); // ✅ saved during login
    setState(() {
      username = storedName ?? "User";
    });
  }

  Future<void> loadAssessment() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isEmpty) {
      setState(() {
        isLoading = false;
      });
      print('No token found');
      return;
    }

    final latest = await fetchLatestAssessment(token);
    if (latest != null) {
      setState(() {
        height = (latest['height'] != null)
            ? double.tryParse(latest['height'].toString())
            : null;
        weight = (latest['weight'] != null)
            ? double.tryParse(latest['weight'].toString())
            : null;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>?> fetchLatestAssessment(String token) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3001/api/fitnessassess/latest'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['latest'];
    } else {
      print('Failed to fetch assessment: ${response.statusCode}');
      return null;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('username');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => coachLoging()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FC),
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
            tooltip: 'Logout',
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildScrollableStats(),
              const SizedBox(height: 20),
              _buildScrollableStat(),
              const SizedBox(height: 20),
              _buildMealAndExerciseOptions(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username ?? "Loading...", // ✅ Show username here
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text("Age 23",
                        style:
                        TextStyle(fontSize: 16, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _infoColumn("Height",
                  height != null ? "${height!.toStringAsFixed(0)} cm" : "N/A"),
              _infoColumn("Weight",
                  weight != null ? "${weight!.toStringAsFixed(0)} kg" : "N/A"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildScrollableStats() {
    return SizedBox(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _statCard("Calories", "2200 kcal", Icons.local_fire_department,
              Colors.redAccent),
          _statCard(
              "Protein", "120 g", Icons.fitness_center, Colors.deepPurple),
          _statCard("Water", "2.5 L", Icons.water_drop, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildScrollableStat() {
    return SizedBox(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _statCard("Calories", "2200 kcal", Icons.local_fire_department,
              Colors.redAccent),
          _statCard(
              "Protein", "120 g", Icons.fitness_center, Colors.deepPurple),
          _statCard("Water", "2.5 L", Icons.water_drop, Colors.blue),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: color),
          const Spacer(),
          Text(title,
              style: const TextStyle(fontSize: 16, color: Colors.black87)),
          Text(value,
              style:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMealAndExerciseOptions() {
    return Column(
      children: [

        const SizedBox(height: 10),
        _navigationTile(
          icon: Icons.feedback,
          title: "Feedbacks ",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => coachFeedback()),
          ),
        ),
      ],
    );
  }

  Widget _navigationTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.green, size: 30),
            const SizedBox(width: 20),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}