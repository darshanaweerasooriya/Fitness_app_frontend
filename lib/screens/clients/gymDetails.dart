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
        backgroundColor: const Color(0xFFF2F6FC), // match dashboard background
        // appBar: AppBar(
        //   title: const Text("Find Gyms"),
        //   backgroundColor: Colors.white,
        //   elevation: 1,
        //   titleTextStyle: const TextStyle(
        //     fontSize: 22,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.black,
        //   ),
        //   iconTheme: const IconThemeData(color: Colors.black),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search bar styled like dashboard input
              _buildSearchField(
                controller: searchController,
                hint: "Search by location...",
              ),
              const SizedBox(height: 16),

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
      ),
    );
  }

  // Search Field Widget (modern)
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