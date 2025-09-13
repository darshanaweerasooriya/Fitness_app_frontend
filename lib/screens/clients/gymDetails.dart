import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Gym Model
class Gym {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  Gym({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      id: json["_id"],
      name: json["name"],
      latitude: (json["latitude"] as num).toDouble(),
      longitude: (json["longitude"] as num).toDouble(),
    );
  }
}

// Gym Service
class GymService {
  static const String baseUrl = "http://10.0.2.2:3001/api/gyms/get";

  static Future<List<Gym>> getGyms() async {
    final response = await http.get(Uri.parse("$baseUrl/get"));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((gym) => Gym.fromJson(gym)).toList();
    } else {
      throw Exception("Failed to load gyms");
    }
  }
}




class gymmDetails extends StatefulWidget {
  const gymmDetails({super.key});

  @override
  State<gymmDetails> createState() => _gymmDetailsState();
}

class _gymmDetailsState extends State<gymmDetails> {
  late Future<List<Gym>> _futureGyms;
  final TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  void initState() {
    super.initState();
    _futureGyms = GymService.getGyms();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F6FC),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchField(
                controller: searchController,
                hint: "Search by gym name...",
              ),
              const SizedBox(height: 16),

              Expanded(
                child: FutureBuilder<List<Gym>>(
                  future: _futureGyms,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No gyms found"));
                    }

                    // Filter gyms
                    final gyms = snapshot.data!.where((gym) {
                      return gym.name
                          .toLowerCase()
                          .contains(searchText.toLowerCase());
                    }).toList();

                    return ListView.builder(
                      itemCount: gyms.length,
                      itemBuilder: (context, index) {
                        final gym = gyms[index];
                        return _buildGymCard(
                          gym.name,
                          "Lat: ${gym.latitude}, Lng: ${gym.longitude}",
                          "images/gymex.jpg", // Default image
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Refresh button
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            setState(() {
              _futureGyms = GymService.getGyms();
            });
          },
          child: const Icon(Icons.refresh, color: Colors.white),
        ),
      ),
    );
  }

  // Search Field
  Widget _buildSearchField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search, color: Colors.green),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: Colors.redAccent),
            onPressed: () {
              controller.clear();
              setState(() {
                searchText = "";
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // Gym Card
  Widget _buildGymCard(String name, String location, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18), bottomLeft: Radius.circular(18)),
            child: Image.asset(
              imagePath,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    location,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey),
          )
        ],
      ),
    );
  }
}