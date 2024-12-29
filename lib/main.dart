import 'package:flutter/material.dart';

void main() => runApp(ClubApp());

class ClubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF1F1F1F),
        hintColor: Colors.tealAccent,
      ),
      home: PortraitLayoutLandingPage(),
    );
  }
}

class PortraitLayoutLandingPage extends StatelessWidget {
  const PortraitLayoutLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Session Manager',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 10,
        shadowColor: Colors.tealAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader('Welcome to the Club'),
            const SizedBox(height: 20),
            _buildSectionTitle('Start a New Session'),
            const SizedBox(height: 10),
            _buildInputField('Enter Session Key (Optional)', Icons.key),
            _buildInputField('Your Name', Icons.person),
            _buildInputField('Session Duration (in minutes)', Icons.timer),
            const SizedBox(height: 20),
            _buildSectionTitle('Select Music'),
            _buildMusicSelection(),
            const SizedBox(height: 20),
            _buildSectionTitle('Control IoT Devices'),
            _buildIotControls(),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Start Session',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.tealAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.tealAccent,
        shadows: [
          Shadow(
            offset: Offset(2, 2),
            blurRadius: 5,
            color: Colors.black45,
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.tealAccent,
      ),
    );
  }

  Widget _buildInputField(String hintText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: Icon(icon, color: Colors.tealAccent),
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.tealAccent, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildMusicSelection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          const BoxShadow(
            color: Colors.black45,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: const Column(
        children: [
          ListTile(
            leading: Icon(Icons.music_note, color: Colors.tealAccent),
            title: Text('Ambient Relaxation',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            trailing: Icon(Icons.check_circle, color: Colors.tealAccent),
          ),
          Divider(color: Colors.white54),
          ListTile(
            leading: Icon(Icons.music_note, color: Colors.tealAccent),
            title: Text('Energetic Beats',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            trailing:
                Icon(Icons.check_circle_outline, color: Colors.tealAccent),
          ),
        ],
      ),
    );
  }

  Widget _buildIotControls() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.tealAccent, size: 30),
              SizedBox(height: 5),
              Text('Lights', style: TextStyle(color: Colors.white)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.wb_sunny, color: Colors.tealAccent, size: 30),
              SizedBox(height: 5),
              Text('Fans', style: TextStyle(color: Colors.white)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.ac_unit, color: Colors.tealAccent, size: 30),
              SizedBox(height: 5),
              Text('AC', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
