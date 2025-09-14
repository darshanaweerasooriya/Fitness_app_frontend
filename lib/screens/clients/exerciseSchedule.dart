import 'package:flutter/material.dart';

class exerciseSChedule extends StatefulWidget {
  final String fitnessLevel;

  const exerciseSChedule({super.key, required this.fitnessLevel});

  @override
  State<exerciseSChedule> createState() => _exerciseSCheduleState();
}

class _exerciseSCheduleState extends State<exerciseSChedule> {
  late Map<String, List<Map<String, String>>> exercises;

  @override
  void initState() {
    super.initState();
    exercises = {
      "Beginner": [
        {"name": "Jumping Jacks", "reps": "3 sets of 10"},
        {"name": "Push-ups", "reps": "3 sets of 8"},
        {"name": "Bodyweight Squats", "reps": "3 sets of 10"},
      ],
      "Intermediate": [
        {"name": "Burpees", "reps": "3 sets of 12"},
        {"name": "Lunges", "reps": "3 sets of 12"},
        {"name": "Plank", "reps": "3 sets of 45 sec"},
      ],
      "Advanced": [
        {"name": "Pull-ups", "reps": "4 sets of 10"},
        {"name": "Deadlifts", "reps": "4 sets of 8"},
        {"name": "Squat Jumps", "reps": "4 sets of 12"},
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> currentExercises =
        exercises[widget.fitnessLevel] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.fitnessLevel} Exercises'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: currentExercises.length,
        itemBuilder: (context, index) {
          final exercise = currentExercises[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              leading:
              const Icon(Icons.fitness_center, color: Colors.deepPurple),
              title: Text(exercise["name"]!),
              subtitle: Text(exercise["reps"]!),
            ),
          );
        },
      ),
    );
  }
}