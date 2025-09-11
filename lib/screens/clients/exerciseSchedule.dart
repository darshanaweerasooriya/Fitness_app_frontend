import 'package:flutter/material.dart';

class exerciseSChedule extends StatefulWidget {
  const exerciseSChedule({super.key});

  @override
  State<exerciseSChedule> createState() => _exerciseSCheduleState();
}

class _exerciseSCheduleState extends State<exerciseSChedule> {
  final List<Map<String, String>> exercises = [
    {'image': 'images/cycling.jpg', 'title': 'Cycling', 'duration': '20 Minutes'},
    {'image': 'images/pushups.jpg', 'title': 'Push Ups', 'duration': '15 Minutes'},
    {'image': 'images/Plank.jpg', 'title': 'Plank', 'duration': '30 Minutes'},
    {'image': 'images/Dip.jpg', 'title': 'Dip', 'duration': '25 Minutes'},
    {'image': 'images/Pistol squats.jpg', 'title': 'Pistol Squats', 'duration': '25 Minutes'},
    {'image': 'images/Crunches.jpg', 'title': 'Crunches', 'duration': '25 Minutes'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Save action
          },
          backgroundColor: Colors.deepPurple,
          icon: const Icon(Icons.save, color: Colors.white),
          label: const Text(
            "Save Plan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildExerciseList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 10),
          const Text(
            "Exercise Plan",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: exercises.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                exercise['image']!,
                height: 55,
                width: 55,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              exercise['title']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              exercise['duration']!,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            trailing: const Icon(Icons.fitness_center, color: Colors.deepPurple),
          ),
        );
      },
    );
  }
}