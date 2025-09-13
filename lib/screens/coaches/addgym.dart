import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class addGym extends StatefulWidget {
  const addGym({super.key});

  @override
  State<addGym> createState() => _addGymState();
}

class _addGymState extends State<addGym> {
  List<dynamic> gyms = [];

  @override
  void initState() {
    super.initState();
    fetchGyms();
  }

  Future<void> fetchGyms() async {
    try {
      final response =
      await http.get(Uri.parse("http://10.0.2.2:3001/api/gyms/get"));
      if (response.statusCode == 200) {
        setState(() {
          gyms = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching gyms: $e");
    }
  }

  Future<void> addGym(String name, String latitude, String longitude) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:3001/api/gyms/add"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "name": name,
          "latitude": double.tryParse(latitude),
          "longitude": double.tryParse(longitude),
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context); // close dialog
        fetchGyms(); // refresh list
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gym added successfully ✅")),
        );
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

  void _showAddGymDialog() {
    final nameController = TextEditingController();
    final latController = TextEditingController();
    final longController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add New Gym",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Gym Name",
                  prefixIcon: const Icon(Icons.fitness_center),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: latController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Latitude",
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: longController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Longitude",
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      latController.text.isNotEmpty &&
                      longController.text.isNotEmpty) {
                    addGym(
                        nameController.text, latController.text, longController.text);
                  }
                },
                child: const Text("Add Gym",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F6FC),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: gyms.isEmpty
              ? const Center(child: Text("No gyms available"))
              : ListView.builder(
            itemCount: gyms.length,
            itemBuilder: (context, index) {
              final gym = gyms[index];
              return _buildGymCard(
                gym["name"],
                "${gym["latitude"]}, ${gym["longitude"]}",
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddGymDialog,
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildGymCard(String name, String location) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: ListTile(
        leading: const Icon(Icons.fitness_center, color: Colors.green),
        title: Text(name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text(location),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}