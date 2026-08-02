import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const BiplobAdalatApp());
}

class BiplobAdalatApp extends StatelessWidget {
  const BiplobAdalatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biplob Adalat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF0A192F),
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A192F),
          primary: const Color(0xFF0A192F),
          secondary: const Color(0xFFD4AF37), // Premium Gold accent
        ),
        textTheme: GoogleFonts.tiroBanglaTextTheme(Theme.of(context).textTheme),
      ),
      home: const MainHomeScreen(),
    );
  }
}

// ------------------- MAIN HOME SCREEN -------------------

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0A192F),
        title: Text(
          'Biplob Adalat',
          style: GoogleFonts.tiroBangla(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.psychology, color: Color(0xFFD4AF37), size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GeminiAIScreen()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Search & Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF0A192F),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'কোর্ট বা রুম নম্বর খুঁজুন...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFD4AF37), width: 0.8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.gavel, color: Color(0xFFD4AF37)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'আইনজীবী ও বিচারপ্রার্থীদের জন্য দ্রুত কোর্ট ট্র্যাকিং সমাধান',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Main Category Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildMainCategoryCard(
                    title: 'ম্যাজিস্ট্রেট কোর্ট',
                    subtitle: 'CMM, CJM ও নির্বাহী ম্যাজিস্ট্রেট কোর্ট',
                    icon: Icons.account_balance,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubCategoryScreen(
                            title: 'ম্যাজিস্ট্রেট কোর্ট',
                            items: [
                              'চিফ মেট্রোপলিটন ম্যাজিস্ট্রেট কোর্ট (CMM)',
                              'চিফ জুডিশিয়াল ম্যাজিস্ট্রেট কোর্ট (CJM)',
                              'নির্বাহী ম্যাজিস্ট্রেট কোর্ট',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  _buildMainCategoryCard(
                    title: 'মহানগর দায়রা জজ আদালত',
                    subtitle: 'মহানগর জজ ও মানব পাচার প্রতিরোধ ট্রাইব্যুনাল',
                    icon: Icons.gavel_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubCategoryScreen(
                            title: 'মহানগর দায়রা জজ আদালত',
                            items: [
                              'মহানগর দায়রা জজ আদালত',
                              'মানব পাচার ও অতিরিক্ত মহানগর (টিনশেড নিচতলা)',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  _buildMainCategoryCard(
                    title: 'জেলা ও দায়রা জজ আদালত',
                    subtitle: 'নতুন ও পুরাতন বিল্ডিং ভবন',
                    icon: Icons.domain,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubCategoryScreen(
                            title: 'জেলা ও দায়রা জজ আদালত',
                            items: [
                              'জেলা ও দায়রা জজ আদালত (নতুন বিল্ডিং)',
                              'জেলা ও দায়রা জজ আদালত (পুরাতন বিল্ডিং)',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  _buildMainCategoryCard(
                    title: 'রেবতী ম্যানশন, জেলা জজ আদালত',
                    subtitle: 'রেবতী ম্যানশনের সংশ্লিষ্ট সকল কোর্টসমূহ',
                    icon: Icons.location_city,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CourtDetailsScreen(
                            courtName: 'রেবতী ম্যানশন, জেলা জজ আদালত',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFD4AF37),
        icon: const Icon(Icons.auto_awesome, color: Color(0xFF0A192F)),
        label: Text(
          'Gemini AI অ্যাসিস্ট্যান্ট',
          style: GoogleFonts.tiroBangla(
            color: const Color(0xFF0A192F),
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GeminiAIScreen()),
          );
        },
      ),
    );
  }

  Widget _buildMainCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0A192F).withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF0A192F), size: 28),
        ),
        title: Text(
          title,
          style: GoogleFonts.tiroBangla(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: const Color(0xFF0A192F),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFD4AF37), size: 18),
        onTap: onTap,
      ),
    );
  }
}

// ------------------- SUB CATEGORY SCREEN -------------------

class SubCategoryScreen extends StatelessWidget {
  final String title;
  final List<String> items;

  const SubCategoryScreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: GoogleFonts.tiroBangla(color: Colors.white)),
        backgroundColor: const Color(0xFF0A192F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFD4AF37),
                child: Icon(Icons.stairs_rounded, color: Colors.white),
              ),
              title: Text(
                items[index],
                style: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: const Color(0xFF0A192F),
                ),
              ),
              subtitle: const Text('তলার তালিকা দেখতে ক্লিক করুন'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourtDetailsScreen(courtName: items[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ------------------- DETAILS SCREEN (FLOOR INFO) -------------------

class CourtDetailsScreen extends StatelessWidget {
  final String courtName;

  const CourtDetailsScreen({super.key, required this.courtName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courtName, style: GoogleFonts.tiroBangla(color: Colors.white, fontSize: 16)),
        backgroundColor: const Color(0xFF0A192F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 80, color: Color(0xFFD4AF37)),
            const SizedBox(height: 20),
            Text(
              courtName,
              textAlign: TextAlign.center,
              style: GoogleFonts.tiroBangla(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0A192F),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                'এই বিল্ডিংয়ের রুম এবং তলা সংক্রান্ত বিস্তারিত ডাটা শীঘ্রই যুক্ত করা হবে। আপনি আপনার কাছে থাকা PDF ফাইলটি প্রদান করলে তা এখানে ডাইনামিকালি সাজিয়ে দেওয়া হবে।',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- GEMINI AI ASSISTANT SCREEN -------------------

class GeminiAIScreen extends StatefulWidget {
  const GeminiAIScreen({super.key});

  @override
  State<GeminiAIScreen> createState() => _GeminiAIScreenState();
}

class _GeminiAIScreenState extends State<GeminiAIScreen> {
  final TextEditingController _promptController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  // Safe Integration using environment variables
  static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY');

  late final GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
    );
  }

  Future<void> _sendMessage() async {
    final text = _promptController.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add({"role": "user", "text": text});
      _isLoading = true;
      _promptController.clear();
    });

    try {
      final response = await _model.generateContent([
        Content.text(
          'তুমি বিপ্লব আদালত (Biplob Adalat) অ্যাপের একজন পেশাদার বাংলা আইনি সহকারী। সংক্ষেপে ও নির্ভুলভাবে উত্তর দাও: $text',
        )
      ]);

      setState(() {
        _messages.add({
          "role": "ai",
          "text": response.text ?? "দুঃখিত, কোনো উত্তর পাওয়া যায়নি।"
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "role": "ai",
          "text": "ত্রুটি ঘটেছে: উত্তর পেতে সমস্যা হচ্ছে। অনুগ্রহ করে আপনার ইন্টারনেট সংযোগ পরীক্ষা করুন।"
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Gemini আইনি সহকারী', style: GoogleFonts.tiroBangla(color: Colors.white)),
        backgroundColor: const Color(0xFF0A192F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUser = _messages[index]["role"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF0A192F) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
                      ],
                    ),
                    child: Text(
                      _messages[index]["text"]!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: LinearProgressIndicator(color: Color(0xFFD4AF37)),
            ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promptController,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: 'আইন বা কোর্ট বিষয়ক যেকোনো প্রশ্ন লিখুন...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFFD4AF37)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
