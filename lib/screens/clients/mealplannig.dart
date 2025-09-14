import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final Map<String, String> mealPlan = const {
    'Breakfast': 'Oatmeal with fruits, 1 boiled egg',
    'Lunch': 'Grilled chicken, steamed vegetables, brown rice',
    'Dinner': 'Baked fish, salad, quinoa',
    'Snack': 'Greek yogurt with nuts',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Suggested Meal Plan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 5,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change back arrow color to white
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE7F6), Color(0xFFF2F6FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: mealPlan.length,
          itemBuilder: (context, index) {
            String meal = mealPlan.keys.elementAt(index);
            String details = mealPlan.values.elementAt(index);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              shadowColor: Colors.deepPurple.withOpacity(0.3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.deepPurple.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Icon(
                      _getMealIcon(meal),
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    meal,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      details,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _getMealIcon(String meal) {
    switch (meal) {
      case 'Breakfast':
        return Icons.free_breakfast;
      case 'Lunch':
        return Icons.lunch_dining;
      case 'Dinner':
        return Icons.dinner_dining;
      case 'Snack':
        return Icons.fastfood;
      default:
        return Icons.restaurant_menu;
    }
  }
}