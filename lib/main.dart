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
                    subtitle: 'ভবন ও টিন শেড-এর ফ্লোর ভিত্তিক সকল কোর্ট',
                    icon: Icons.gavel_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MetropolitanSessionsCourtScreen(),
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

// ------------------- METROPOLITAN SESSIONS COURT SCREEN -------------------

class MetropolitanSessionsCourtScreen extends StatefulWidget {
  const MetropolitanSessionsCourtScreen({super.key});

  @override
  State<MetropolitanSessionsCourtScreen> createState() =>
      _MetropolitanSessionsCourtScreenState();
}

class _MetropolitanSessionsCourtScreenState
    extends State<MetropolitanSessionsCourtScreen> {
  String selectedFloor = 'সব ফ্লোর';

  final List<String> floorList = [
    'সব ফ্লোর',
    '৬ষ্ঠ তলা',
    '৫ম তলা',
    '৪র্থ তলা',
    '৩য় তলা',
    '২য় তলা',
    'নীচ তলা',
    'টিন শেড',
  ];

  final List<Map<String, dynamic>> courtData = [
    // ৬ষ্ঠ তলা
    {'floor': '৬ষ্ঠ তলা', 'title': 'বিশেষ জজ আদালত নং- ১, ঢাকা।'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'বিশেষ জজ আদালত নং- ২, ঢাকা।'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'বিশেষ জজ আদালত নং- ৩, ঢাকা।'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'বিশেষ জজ আদালত নং- ৪, ঢাকা।'},

    // ৫ম তলা
    {'floor': '৫ম তলা', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল নং- ৫, ঢাকা।'},
    {'floor': '৫ম তলা', 'title': 'বিশেষ জজ আদালত নং- ৫, ঢাকা।'},
    {'floor': '৫ম তলা', 'title': 'দ্রুত বিচার ট্রাইব্যুনাল নং- ৩, ঢাকা।'},
    {
      'floor': '৫ম তলা',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ৮মে আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৬, ঢাকা'
    },
    {'floor': '৫ম তলা', 'title': 'পরিবেশ আপীল আদালত, ঢাকা।'},

    // ৪র্থ তলা
    {
      'floor': '৪র্থ তলা',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ৫মে আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৬, ঢাকা'
    },
    {
      'floor': '৪র্থ তলা',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ৭ম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৫, ঢাকা'
    },
    {
      'floor': '৪র্থ তলা',
      'title': 'যুগ্ম মহানগর দায়রা জজ ১ম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১১, ঢাকা'
    },
    {
      'floor': '৪র্থ তলা',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ৬ষ্ঠ আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৪, ঢাকা'
    },
    {
      'floor': '৪র্থ তলা',
      'title': 'যুগ্ম মহানগর দায়রা জজ ৫ম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১০, ঢাকা'
    },

    // ৩য় তলা
    {'floor': '৩য় তলা', 'title': 'বিভাগীয় স্পেশাল জজ আদালত, ঢাকা।'},
    {'floor': '৩য় তলা', 'title': 'দ্রুত বিচার ট্রাইব্যুনাল নং- ১, ঢাকা।'},
    {'floor': '৩য় তলা', 'title': 'অনুলিপি শাখা, মহানগর দায়রা জজ আদালত, ঢাকা।'},
    {
      'floor': '৩য় তলা',
      'title': 'যুগ্ম মহানগর দায়রা জজ ৪র্থ আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৯, ঢাকা'
    },
    {'floor': '৩য় তলা', 'title': 'দ্রুত বিচার ট্রাইব্যুনাল নং- ২, ঢাকা।'},

    // ২য় তলা
    {
      'floor': '২য় তলা',
      'title': 'মহানগর দায়রা জজ আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১, ঢাকা'
    },
    {
      'floor': '২য় তলা',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ১ম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২, ঢাকা'
    },
    {'floor': '২য় তলা', 'title': 'নেজারত ও সেরেস্তা এবং প্রশাসনিক কর্মকর্তা মহানগর দায়রা জজ।'},
    {
      'floor': '২য় তলা',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ৪র্থ আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৫, ঢাকা'
    },
    {
      'floor': '২য় তলা',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ৩য় আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৪, ঢাকা'
    },
    {
      'floor': '২য় তলা',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ২য় আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৩, ঢাকা'
    },

    // নীচ তলা
    {
      'floor': 'নীচ তলা',
      'title': 'যুগ্ম মহানগর দায়রা জজ ২য় আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৭, ঢাকা'
    },
    {
      'floor': 'নীচ তলা',
      'title': 'যুগ্ম মহানগর দায়রা জজ ৬ষ্ঠ আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১২, ঢাকা'
    },
    {
      'floor': 'নীচ তলা',
      'title': 'যুগ্ম মহানগর দায়রা জজ ৩য় আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৮, ঢাকা'
    },
    {
      'floor': 'নীচ তলা',
      'title': 'যুগ্ম মহানগর দায়রা জজ ৭ম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৩, ঢাকা'
    },

    // টিন শেড
    {'floor': 'টিন শেড', 'title': 'মানব পাচার ট্রাইব্যুনাল, ঢাকা।'},
    {'floor': 'টিন শেড', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল নং- ৯, ঢাকা।'},
    {
      'floor': 'টিন শেড',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ৯ম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৭, ঢাকা'
    },
    {
      'floor': 'টিন শেড',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ১০ম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৮, ঢাকা'
    },
    {
      'floor': 'টিন শেড',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ১১ তম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৯, ঢাকা'
    },
    {
      'floor': 'টিন শেড',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ১২ তম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২০, ঢাকা'
    },
    {
      'floor': 'টিন শেড',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ১৩তম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২১, ঢাকা'
    },
    {
      'floor': 'টিন শেড',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ১৪ তম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২২, ঢাকা'
    },
    {
      'floor': 'টিন শেড',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ১৫ তম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২৩, ঢাকা'
    },
    {
      'floor': 'টিন শেড',
      'title': 'অতিরিক্ত মহানগর দায়রা জজ ১৬ তম আদালত, ঢাকা',
      'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২৪, ঢাকা'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCourts = selectedFloor == 'সব ফ্লোর'
        ? courtData
        : courtData.where((item) => item['floor'] == selectedFloor).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'মহানগর দায়রা জজ আদালত',
          style: GoogleFonts.tiroBangla(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0A192F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Filter Chips Scrollable Bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: floorList.map((floor) {
                  final isSelected = selectedFloor == floor;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(
                        floor,
                        style: GoogleFonts.tiroBangla(
                          color: isSelected ? const Color(0xFF0A192F) : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFFD4AF37),
                      backgroundColor: const Color(0xFFF4F6F9),
                      onSelected: (bool selected) {
                        setState(() {
                          selectedFloor = floor;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

           // Court Cards List
          Expanded(
            child: filteredCourts.isEmpty
                ? const Center(child: Text('কোন তথ্য পাওয়া যায়নি'))
                : ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: filteredCourts.length,
                    itemBuilder: (context, index) {
                      final court = filteredCourts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Floor Indicator Tag
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: court['floor'] == 'টিন শেড'
                                      ? Colors.orange.shade800
                                      : const Color(0xFF0A192F),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  court['floor'],
                                  style: GoogleFonts.tiroBangla(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Court Name Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      court['title'],
                                      style: GoogleFonts.tiroBangla(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF0A192F),
                                      ),
                                    ),
                                    if (court.containsKey('sub')) ...[
                                      const SizedBox(height: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD4AF37).withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: const Color(0xFFD4AF37),
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Text(
                                          court['sub'],
                                          style: GoogleFonts.tiroBangla(
                                            fontSize: 12,
                                            color: const Color(0xFF0A192F),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
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
        ],
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
                'এই বিল্ডিংয়ের রুম এবং তলা সংক্রান্ত বিস্তারিত ডাটা শীঘ্রই যুক্ত করা হবে। আপনি আপনার কাছে থাকা তথ্য প্রদান করলে তা এখানে ডাইনামিকালি সাজিয়ে দেওয়া হবে।',
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
      model: 'gemini-2.0-flash',
      apiKey: _apiKey,
    );
  }

  Future<void> _sendMessage() async {
    final text = _promptController.text.trim();
    if (text.isEmpty || _isLoading) return;

    if (_apiKey.isEmpty) {
      setState(() {
        _messages.add({"role": "user", "text": text});
        _messages.add({
          "role": "ai",
          "text": "ত্রুটি ঘটেছে: Gemini API Key পাওয়া যায়নি। অনুগ্রহ করে GitHub Secrets-এ GEMINI_API_KEY সঠিকভাবে সেট করার পর বিল্ড দিন।"
        });
        _promptController.clear();
      });
      return;
    }

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
          "text": "ত্রুটি ঘটেছে: $e"
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
