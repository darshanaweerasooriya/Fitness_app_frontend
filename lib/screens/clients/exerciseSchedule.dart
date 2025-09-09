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
    {'image': 'images/Pistol squats.jpg', 'title': 'Pistol squats', 'duration': '25 Minutes'},
    {'image': 'images/Crunches.jpg', 'title': 'Crunches', 'duration': '25 Minutes'},
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 10,),
              Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, size: 30, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context); // Go back to the previous screen
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Exercise Plan",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 80, // Equal width and height for square shape
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (_) => signUpCLient()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Optional: for slightly rounded corners
                          ),
                          padding: EdgeInsets.zero, // Remove default padding
                        ),
                        child: Text("Save",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),), // Use an icon or short text
                      ),
                    ),
                  ]


              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildExerciseList(),
        ],
      ),
    ));
  }

  Widget _buildExerciseList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Exercise Schedule", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: exercises.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      exercise['image']!,
                      height: 55,
                      width: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exercise['title']!,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      Text(exercise['duration']!,
                          style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
