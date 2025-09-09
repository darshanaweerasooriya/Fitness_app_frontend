import 'package:flutter/material.dart';

class gymmDetails extends StatefulWidget {
  const gymmDetails({super.key});

  @override
  State<gymmDetails> createState() => _gymmDetailsState();
}

class _gymmDetailsState extends State<gymmDetails> {
  final TextEditingController searchController = TextEditingController();

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

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    // Filter gyms based on search text
    List<Map<String, String>> filteredGyms = gyms.where((gym) {
      return gym["location"]!
          .toLowerCase()
          .contains(searchText.toLowerCase());
    }).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search Gyms"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildSearchField(
                controller: searchController,
                hint: "Search by location...",
              ),
            ),

            // List of gyms
            Expanded(
              child: filteredGyms.isEmpty
                  ? const Center(
                child: Text(
                  "No gyms found for this location",
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: filteredGyms.length,
                itemBuilder: (context, index) {
                  final gym = filteredGyms[index];
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
    );
  }

  // Search Field Widget
  Widget _buildSearchField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
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
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: Colors.black),
            onPressed: () {
              controller.clear();
              setState(() {
                searchText = "";
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  // Gym Card Widget
  Widget _buildGymCard(String name, String location, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Row(
        children: [
          // Gym Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            child: Image.asset(
              imagePath, // <-- Use local asset
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),

          // Gym Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    location,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}