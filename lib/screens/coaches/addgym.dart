import 'package:flutter/material.dart';

class addGym extends StatefulWidget {
  const addGym({super.key});

  @override
  State<addGym> createState() => _addGymState();
}

class _addGymState extends State<addGym> {
  // Dummy gym data with local images
  final List<Map<String, String>> gyms = [
    {
      "name": "FitZone Gym",
      "location": "4th Floor, New Market Building, Kurunegala",
      "image": "images/gymex.jpg"
    },
    {
      "name": "PowerHouse Fitness",
      "location": "Colombo Road, Kurunegala",
      "image": "images/gymex.jpg"
    },
    {
      "name": "Muscle Factory",
      "location": "Main Street, Kandy",
      "image": "images/gymex.jpg"
    },
    {
      "name": "Kurunegala Fitness Hub",
      "location": "2nd Floor, Mall Complex, Kurunegala",
      "image": "images/gymex.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F6FC), // match dashboard background

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Removed search bar

              // List of gyms
              Expanded(
                child: gyms.isEmpty
                    ? const Center(
                  child: Text(
                    "No gyms available",
                    style: TextStyle(fontSize: 16),
                  ),
                )
                    : ListView.builder(
                  itemCount: gyms.length,
                  itemBuilder: (context, index) {
                    final gym = gyms[index];
                    return _buildGymCard(
                      gym["name"]!,
                      gym["location"]!,
                      gym["image"]!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Floating Action Button for adding gyms
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your add gym logic here (e.g., open form page)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Add Gym button clicked")),
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  // Gym Card Widget (match dashboard tile style)
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
          // Gym Image
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

          // Gym Details
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
            child: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          )
        ],
      ),
    );
  }
}