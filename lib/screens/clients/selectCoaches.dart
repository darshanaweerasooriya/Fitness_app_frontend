import 'package:finessmobileapp/screens/clients/messageScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class selectCoaches extends StatefulWidget {
  const selectCoaches({super.key});

  @override
  State<selectCoaches> createState() => _selectCoachesState();
}

class _selectCoachesState extends State<selectCoaches> {
  TextEditingController search = TextEditingController();

  List<dynamic> allCoaches = [];
  List<dynamic> filteredCoaches = [];

  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    fetchCoaches();
  }

  Future<void> fetchCoaches() async {
    final List<Map<String, dynamic>> sampleCoaches = [
      {
        'name': 'Coach Lee',
        'type': 1,
        'profileImage': '',
        'status': 'Available',
      },
      {
        'name': 'Coach Chaminda',
        'type': 1,
        'profileImage': '',
        'status': 'Busy',
      },
    ];

    setState(() {
      allCoaches = sampleCoaches;
      filteredCoaches = sampleCoaches;
    });

    final url = Uri.parse('http://localhost:3001/api/professionals');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final backendCoaches = data
            .where((coach) => coach['type'] == 1)
            .toList();
        setState(() {
          allCoaches.addAll(backendCoaches);
          filteredCoaches = allCoaches;
        });
      }
    } catch (e) {
      print('Error fetching backend data: $e');
    }
  }

  void filterSearch(String query) {
    final results = allCoaches.where((coach) {
      final name = coach['name'].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredCoaches = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        // appBar: AppBar(
        //   backgroundColor: Colors.redAccent,
        //   title: const Text(
        //     "Select Coaches",
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        //   elevation: 0,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: TextField(
                  controller: search,
                  onChanged: filterSearch,
                  decoration: InputDecoration(
                    hintText: "Search coaches...",
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Coaches Grid
              Expanded(
                child: filteredCoaches.isEmpty
                    ? const Center(
                  child: Text(
                    "No coaches found",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                )
                    : GridView.builder(
                  itemCount: filteredCoaches.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final coach = filteredCoaches[index];
                    final isSelected = index == selectedIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.red[50] : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: isSelected
                                ? Colors.redAccent
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16)),
                                child: Image.network(
                                  coach['profileImage'] != null &&
                                      coach['profileImage']
                                          .toString()
                                          .isNotEmpty
                                      ? 'http://localhost:3001/${coach['profileImage']}'
                                      : 'https://via.placeholder.com/300x300?text=${coach['name']}',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    coach['name'] ?? 'No Name',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    coach['status'] ?? 'Unknown',
                                    style: TextStyle(
                                        color: coach['status'] == "Available"
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Continue button
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: selectedIndex != null
                    ? () {
                  final selectedCoach = filteredCoaches[selectedIndex!];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          messageScreen( coachName: selectedCoach['name'] ?? '',
                            coachImage: selectedCoach['profileImage'] ?? '',
                            coachStatus: selectedCoach['status'] ?? 'Available',)
                    ),
                  );
                }
                    : null,
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
