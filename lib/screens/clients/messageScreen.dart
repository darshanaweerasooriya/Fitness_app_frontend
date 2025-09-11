import 'package:finessmobileapp/screens/clients/chatScreen.dart';
import 'package:flutter/material.dart';

class messageScreen extends StatefulWidget {
  final String coachName;
  final String coachImage;
  final String coachStatus;
  const messageScreen({super.key,
    required this.coachName,
    required this.coachImage,
    required this.coachStatus,});

  @override
  State<messageScreen> createState() => _messageScreenState();
}

class _messageScreenState extends State<messageScreen> {
  TextEditingController search = TextEditingController();

  final List<Map<String, String>> onlineUsers = [
    {'image': 'images/signUp.jpg', 'name': 'John Doe', 'status': 'Available'},
    {'image': 'images/user2.png', 'name': 'Emily Clark', 'status': 'Busy'},
    {'image': 'images/user3.png', 'name': 'Mike Ross', 'status': 'Active now'},
    {'image': 'images/user4.png', 'name': 'Sarah Lee', 'status': 'Available'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        // appBar: AppBar(
        //   backgroundColor: Colors.redAccent,
        //   elevation: 0,
        //   title: const Text(
        //     "Messages",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white,
        //     ),
        //   ),
        //   centerTitle: true,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back, color: Colors.white),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildCoachDetails(),
            const SizedBox(height: 20),
            _buildSearchBox(),
            const SizedBox(height: 20),
            _buildOnlineList(context),
          ],
        ),
      ),
    );
  }

  // Coach Section
  Widget _buildCoachDetails() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: widget.coachImage.isNotEmpty
              ? NetworkImage(widget.coachImage)
              : const AssetImage("images/user2.png") as ImageProvider,
        ),
        const SizedBox(height: 12),
        Text(
          widget.coachName,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          widget.coachStatus,
          style: TextStyle(
            fontSize: 16,
            color: widget.coachStatus == "Available"
                ? Colors.green
                : Colors.orange,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          icon: const Icon(Icons.message, color: Colors.white),
          label: const Text(
            "Message",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  username: widget.coachName,
                  userImage: widget.coachImage,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        const Divider(thickness: 1),
      ],
    );
  }

  // Search Bar
  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: TextField(
        controller: search,
        decoration: InputDecoration(
          hintText: 'Search online users...',
          prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // Online People List
  Widget _buildOnlineList(BuildContext context) {
    return Column(
      children: onlineUsers.map((user) {
        bool isOnline =
            user['status'] == 'Available' || user['status'] == 'Active now';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  username: user['name']!,
                  userImage: user['image']!,
                ),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(user['image']!),
                      ),
                      if (isOnline)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border:
                              Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user['name']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user['status']!,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chat_bubble, color: Colors.blueAccent),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}