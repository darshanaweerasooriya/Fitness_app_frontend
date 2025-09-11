import 'package:flutter/material.dart';

class mentalhealth extends StatefulWidget {
  const mentalhealth({super.key});

  @override
  State<mentalhealth> createState() => _mentalhealthState();
}

class _mentalhealthState extends State<mentalhealth> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          title: const Text(
            "Mental Health Resources",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 4,
          iconTheme: const IconThemeData(
            color: Colors.white, // Change back arrow color to white
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildLinkCard(
                title: "Music",
                icon: Icons.music_note,
                color: Colors.blueAccent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MusicScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildLinkCard(
                title: "Videos",
                icon: Icons.video_library,
                color: Colors.purpleAccent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VideoScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildLinkCard(
                title: "Articles",
                icon: Icons.article,
                color: Colors.orangeAccent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ArticleScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinkCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        shadowColor: Colors.black26,
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 40),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===================== MUSIC SCREEN =====================
class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  final List<Map<String, String>> musics = const [
    {"title": "Relaxing Piano", "artist": "Calm Minds", "thumbnail": "🎹"},
    {"title": "Ocean Waves", "artist": "Nature Sounds", "thumbnail": "🌊"},
    {"title": "Guitar Chill", "artist": "Peaceful Tunes", "thumbnail": "🎸"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Music")),
      body: ListView.builder(
        itemCount: musics.length,
        itemBuilder: (context, index) {
          final music = musics[index];
          return ListTile(
            leading: Text(
              music["thumbnail"]!,
              style: const TextStyle(fontSize: 28),
            ),
            title: Text(music["title"]!),
            subtitle: Text(music["artist"]!),
            trailing: const Icon(Icons.play_arrow, color: Colors.teal),
            onTap: () {
              // here you can play music
            },
          );
        },
      ),
    );
  }
}

// ===================== VIDEO SCREEN =====================
class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  final List<Map<String, String>> videos = const [
    {"title": "Meditation Guide", "channel": "Mindful Living", "thumbnail": "🧘"},
    {"title": "Stress Relief Yoga", "channel": "Yoga Hub", "thumbnail": "🧎"},
    {"title": "Positive Thinking", "channel": "Motivation TV", "thumbnail": "💡"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Videos")),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return ListTile(
            leading: Text(
              video["thumbnail"]!,
              style: const TextStyle(fontSize: 28),
            ),
            title: Text(video["title"]!),
            subtitle: Text(video["channel"]!),
            trailing: const Icon(Icons.play_circle_fill, color: Colors.purple),
            onTap: () {
              // here you can open video player
            },
          );
        },
      ),
    );
  }
}

// ===================== ARTICLE SCREEN =====================
class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  final List<Map<String, String>> articles = const [
    {"title": "5 Ways to Reduce Anxiety", "author": "Dr. Smith", "thumbnail": "📖"},
    {"title": "The Power of Mindfulness", "author": "Jane Doe", "thumbnail": "🧠"},
    {"title": "Healthy Sleep Habits", "author": "Sleep Foundation", "thumbnail": "😴"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Articles")),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            leading: Text(
              article["thumbnail"]!,
              style: const TextStyle(fontSize: 28),
            ),
            title: Text(article["title"]!),
            subtitle: Text("By ${article["author"]!}"),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              // here you can open article details page
            },
          );
        },
      ),
    );
  }
}