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
          final item = items[index];
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
                item,
                style: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: const Color(0xFF0A192F),
                ),
              ),
              subtitle: const Text('তলার তালিকা ও বিস্তারিত দেখতে ক্লিক করুন'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () {
                // Route for Chief Judicial Magistrate Court (CJM)
                if (item.contains('চিফ জুডিশিয়াল ম্যাজিস্ট্রেট') || item.contains('CJM')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CjmCourtScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourtDetailsScreen(courtName: item),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

// ------------------- PREMIUM CJM COURT DIRECTORY SCREEN -------------------

class CjmCourtScreen extends StatefulWidget {
  const CjmCourtScreen({super.key});

  @override
  State<CjmCourtScreen> createState() => _CjmCourtScreenState();
}

class _CjmCourtScreenState extends State<CjmCourtScreen> {
  String selectedFloor = 'সব ফ্লোর';
  String searchQuery = '';

  final List<String> floorList = [
    'সব ফ্লোর',
    '২য় তলা',
    '৩য় তলা',
    '৪র্থ তলা',
    '৫ম তলা',
    '৬ষ্ঠ তলা',
    '৭ম তলা',
    '৮ম তলা',
    '৯ম তলা',
  ];

  final List<Map<String, String>> cjmData = [
    // ২য় তলা
    {'floor': '২য় তলা', 'room': '২০১', 'title': 'রেকর্ড শাখা', 'details': 'কর্মকর্তা: আব্দুল্লাহ-আল-মাহমুদ (রেকর্ড কিপার)', 'contact': '01685216681, 01734299955, হেল্পলাইন: 01335-145001'},
    {'floor': '২য় তলা', 'room': '২০২', 'title': 'প্রশাসনিক কর্মকর্তা', 'details': 'প্রশাসনি জামানত ও হাইকোর্ট বিভাগ সংক্রান্ত আপীল আদালত বিষয়ক শাখা।', 'contact': ''},
    {'floor': '২য় তলা', 'room': '২০৩', 'title': 'নেজারত শাখা', 'details': 'নেজারত হেল্পলাইন সংক্রান্ত কাজ', 'contact': '০১৩৩৫-১৪৫০০১'},
    {'floor': '২য় তলা', 'room': '২০৪', 'title': 'জুডিশিয়াল মুন্সীখানা অফিস', 'details': 'জুডিশিয়াল মুন্সীখানা প্রশাসনিক কাজ', 'contact': '০১৩৩৫-১৪৫০০১'},
    {'floor': '২য় তলা', 'room': 'হাজতখানা', 'title': 'সিজিএম কোর্ট হাজতখানা', 'details': 'নিরাপত্তা বিশেষ নির্দেশ: বিনা অনুমতিতে প্রবেশ সম্পূর্ণ নিষেধ।', 'contact': ''},

    // ৩য় তলা
    {'floor': '৩য় তলা', 'room': '৩০১', 'title': 'চীফ জুডিশিয়াল ম্যাজিস্ট্রেট আদালত', 'details': 'প্রধান আদালত, চীফ জুডিশিয়াল ম্যাজিস্ট্রেট, ঢাকা।', 'contact': ''},
    {'floor': '৩য় তলা', 'room': '৩০২', 'title': 'অতিরিক্ত চীফ জুডিশিয়াল ম্যাজিস্ট্রেট আদালত', 'details': 'অতিরিক্ত চীফ জুডিশিয়াল ম্যাজিস্ট্রেট, ঢাকা।', 'contact': ''},
    {'floor': '৩য় তলা', 'room': '৩০৩', 'title': 'সম্মেলন ও মিলনায়তন', 'details': 'কনফারেন্স ও মিটিং রুম।', 'contact': ''},
    {'floor': '৩য় তলা', 'room': '৩০৪', 'title': 'স্টেনোগ্রাফার শাখা (CJM)', 'details': 'চীফ জুডিশিয়াল ম্যাজিস্ট্রেট স্টেনোগ্রাফার কক্ষ।', 'contact': ''},
    {'floor': '৩য় তলা', 'room': '৩০৫', 'title': 'অতিথি কক্ষ (Guest Room)', 'details': 'দর্শনার্থী ও অতিথি বিশ্রামাগার।', 'contact': ''},
    {'floor': '৩য় তলা', 'room': '৩০৬', 'title': 'হিসাব শাখা', 'details': 'অর্থ শাখা, জেলা ও দায়রা জজ এবং সিজিএম আদালত, ঢাকা।', 'contact': '০১৩৩৫-১৪৫০০১'},
    {'floor': '৩য় তলা', 'room': '৩০৭', 'title': 'স্টেনোগ্রাফার (ACJM) ও শাখা', 'details': 'অতিরিক্ত চীফ জুডিশিয়াল ম্যাজিস্ট্রেট শাখা ও স্টেনো কক্ষ।', 'contact': ''},
    {'floor': '৩য় তলা', 'room': '৩০৮', 'title': 'আদালত লাইব্রেরী', 'details': 'লাইব্রেরী আইন গ্রন্থ ও নথিভিত্তিক পাঠাগার।', 'contact': ''},

    // ৪র্থ তলা
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: মোহাম্মদপুর ও আদাবর থানা', 'details': 'G.R. অপরাধ তথ্য ও প্রসেকিউশন বিভাগ, ডিএমপি।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: রামপুরা ও সবুজবাগ থানা', 'details': 'G.R. অপরাধ তথ্য ও প্রসেকিউশন বিভাগ।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': '৪১১', 'title': 'জি.আর. শাখা: মিরপুর, শেরেবাংলা নগর, শাহআলী ও দারুস-সালাম থানা', 'details': 'জি.আর. সেকশন।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': '৪১২', 'title': 'জি.আর. শাখা: বাড্ডা ও ভাটারা থানা', 'details': 'G.R. জি.আর. সেকশন।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': '৪১৩', 'title': 'জি.আর. শাখা: লালবাগ, চকবাজার, কামরাঙ্গীরচর, কোতয়ালী ও বংশাল থানা', 'details': 'জি.আর. শাখা ও প্রসেকিউশন বিভাগ।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': '৪০৬', 'title': 'জি.আর. শাখা: মতিঝিল, পল্টন ও শাহজাহানপুর থানা', 'details': 'G.R. জি.আর. শাখা, প্রসেকিউশন বিভাগ।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: রমনা ও শাহবাগ থানা', 'details': 'G.R. প্যারাফ্যাসিলিটি পরামর্শ', 'contact': '01647130339'},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: মিরপুর, পল্লবী, রূপনগর, কাফরুল ও ভাসানটেক থানা', 'details': 'প্যারাফ্যাসিলিটি পরামর্শ', 'contact': '01647130339'},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: নিউমার্কেট ও কলাবাগান থানা', 'details': 'G.R. প্রসেকিউশন বিভাগ, ডিএমপি।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: খিলক্ষেত ও ক্যান্টনমেন্ট থানা', 'details': 'G.R. প্রসেকিউশন বিভাগ, ডিএমপি।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: সূত্রাপুর, গেন্ডারিয়া ও ওয়ারী থানা', 'details': 'G.R. প্রসেকিউশন বিভাগ, ডিএমপি।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: তেজগাঁও, তেজগাঁও শিল্পাঞ্চল ও হাতিরঝিল থানা', 'details': 'জি.আর. শাখা ও প্রসেকিউশন।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: গুলশান ও বনানী থানা', 'details': 'G.R. জি.আর. শাখা।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: কদমতলী ও শ্যামপুর থানা', 'details': 'G.R. জি.আর. শাখা।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: যাত্রাবাড়ী, ডেমরা, খিলগাঁও ও মুগদা থানা', 'details': 'G.R. জি.আর. শাখা।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: বিমানবন্দর, উত্তরখান ও দক্ষিণখান থানা', 'details': 'জি.আর. শাখা।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: ধানমন্ডি ও হাজারীবাগ থানা', 'details': 'G.R. জি.আর. শাখা।', 'contact': ''},
    {'floor': '৪র্থ তলা', 'room': 'রিসিভ', 'title': 'শাখা রিসিভ ও ডেসপ্যাচ শাখা (DMP)', 'details': 'ডিএমপি, ঢাকা শাখা রিসিভ-ডেসপ্যাচ।', 'contact': ''},

    // ৫ম তলা
    {'floor': '৫ম তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: দোহার, নবাবগঞ্জ, ধামরাই, আশুলিয়া ও সাভার থানা', 'details': 'ঢাকা জেলা উপজেলার জি.আর. শাখাসমূহ।', 'contact': ''},
    {'floor': '৫ম তলা', 'room': 'G.R.', 'title': 'জি.আর. শাখা: কেরানীগঞ্জ ও দক্ষিণ কেরানীগঞ্জ থানা', 'details': 'জি.আর. শাখা।', 'contact': ''},
    {'floor': '৫ম তলা', 'room': 'Non-GR', 'title': 'নন-জি.আর. শাখা: সাভার, আশুলিয়া, ধামরাই ও রেলওয়ে থানা', 'details': 'নন-জি.আর. মামলা শাখা।', 'contact': ''},
    {'floor': '৫ম তলা', 'room': '২৯', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট কোর্ট (আদালত ২৯)', 'details': 'কোর্ট বিচারের দায়িত্বে: আলবেরুনী মীর।', 'contact': ''},
    {'floor': '৫ম তলা', 'room': 'Legal Aid', 'title': 'জেলা লিগ্যাল এইড অফিসারের কার্যালয়', 'details': 'আইনি সহায়তা, বিনামূল্যে সরকারি আইনি সহায়তা কেন্দ্র।', 'contact': ''},
    {'floor': '৫ম তলা', 'room': 'Record', 'title': 'পুলিশ রেকর্ড রুম (সিডি শাখা)', 'details': 'গোপনীয় শাখা / কেস ডায়েরি (CD) শাখা।', 'contact': ''},
    {'floor': '৫ম তলা', 'room': 'Prosecution', 'title': 'মাদক প্রসেকিউশন সেকশন', 'details': 'মাদকদ্রব্য নিয়ন্ত্রণ প্রসেকিউশন সেকশন ঢাকা মেট্রো (উত্তর), ঢাকা মেট্রো (দক্ষিণ) ও ঢাকা জেলা কার্যালয়।', 'contact': ''},
    {'floor': '৫ম তলা', 'room': 'IT Room', 'title': 'ডিজিটাল ডাটা ম্যানেজমেন্ট রুম', 'details': 'কোঅর্ডিনেশন ও তথ্য ব্যবস্থাপনা রুম (কোর্ট পুলিশ, ঢাকা জেলা)।', 'contact': ''},

    // ৬ষ্ঠ তলা
    {'floor': '৬ষ্ঠ তলা', 'room': '৬০১', 'title': 'জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-৩, ঢাকা কোর্ট', 'details': 'স্টেনো টাইপিস্ট: কক্ষ নং-৬০৫', 'contact': ''},
    {'floor': '৬ষ্ঠ তলা', 'room': '৬০২', 'title': 'সিনিয়র জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-১, ঢাকা কোর্ট', 'details': 'স্টেনো টাইপিস্ট: কক্ষ নং-৬০৬', 'contact': ''},
    {'floor': '৬ষ্ঠ তলা', 'room': '৬০৩', 'title': 'সিনিয়র জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-২, ঢাকা কোর্ট', 'details': 'স্টেনো টাইপিস্ট: কক্ষ নং-৬০৭', 'contact': ''},
    {'floor': '৬ষ্ঠ তলা', 'room': '৬০৪', 'title': 'জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-২, ঢাকা কোর্ট', 'details': 'স্টেনো টাইপিস্ট: কক্ষ নং-৬০৮', 'contact': ''},

    // ৭ম তলা
    {'floor': '৭ম তলা', 'room': '৭০১', 'title': 'জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-৫, ঢাকা কোর্ট', 'details': 'স্টেনো টাইপিস্ট: কক্ষ নং-৭০৫', 'contact': ''},
    {'floor': '৭ম তলা', 'room': '৭০২', 'title': 'সিনিয়র জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-৩, ঢাকা কোর্ট', 'details': 'স্টেনো টাইপিস্ট: কক্ষ নং-৭০৬', 'contact': ''},
    {'floor': '৭ম তলা', 'room': '৭০৩', 'title': 'জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-১, ঢাকা কোর্ট', 'details': 'স্টেনো টাইপিস্ট: কক্ষ নং-৭০৭', 'contact': ''},
    {'floor': '৭ম তলা', 'room': '৭০৪', 'title': 'জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-৪, ঢাকা কোর্ট', 'details': 'স্টেনো টাইপিস্ট: কক্ষ নং-৭০৮', 'contact': ''},
    {'floor': '৭ম তলা', 'room': '৭০০', 'title': 'ফর্মস অ্যান্ড স্টেশনারী শাখা', 'details': 'সরবরাহ সরকারি ফরম ও প্রয়োজনীয় স্টেশনারী শাখা।', 'contact': ''},

    // ৮ম তলা
    {'floor': '৮ম তলা', 'room': '৩০', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট আদালত নং-৩০ কোর্ট', 'details': 'বিচারক: মোঃ সিদ্দিক আজাদ (এজলাস)', 'contact': ''},
    {'floor': '৮ম তলা', 'room': 'Tribunal', 'title': 'সন্ত্রাস বিরোধী বিশেষ ট্রাইব্যুনাল, ঢাকা', 'details': 'Anti-Terrorism Special Tribunal, Dhaka (এজলাস ও অফিস)', 'contact': ''},
    {'floor': '৮ম তলা', 'room': '৩৬', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট আদালত নং-৩৬ কোর্ট', 'details': 'বিচারকের খাসকামরা ও এজলাস।', 'contact': ''},
    {'floor': '৮ম তলা', 'room': 'Appeal', 'title': 'পারিবারিক আপীল আদালত নং-১, ঢাকা', 'details': 'পারিবারিক বিরোধ আপীল শুনানী আদালত।', 'contact': ''},
    {'floor': '৮ম তলা', 'room': 'Special', 'title': 'স্পেশাল জেলা জজ ও স্পেশাল দায়রা জজ আদালত', 'details': 'বিশেষ জজ আদালত, ঢাকা।', 'contact': ''},
    {'floor': '৮ম তলা', 'room': '৬০', 'title': '৩১নং আদালতের সেরেস্তা', 'details': 'সেরেস্তা ৩১ নম্বর আদালতের সেরেস্তা শাখা।', 'contact': ''},

    // ৯এম তলা
    {'floor': '৯ম তলা', 'room': '৩৩', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট আদালত নং-৩৩ কোর্ট', 'details': 'বিচারক: মহেদী হাসান (বিচারকের খাসকামরা ও এজলাস)।', 'contact': ''},
    {'floor': '৯ম তলা', 'room': '৩৪', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট ও দ্রুত বিচার আদালত (নং-০৭)', 'details': 'বিচারক: মোঃ আশরাফুল হক, সিএমএম কোর্ট, ঢাকা।', 'contact': ''},
    {'floor': '৯ম তলা', 'room': '৩৫', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট আদালত নং-৩৫ কোর্ট', 'details': 'বিচারক: মোঃ রকিবুল হাসান', 'contact': ''},
    {'floor': '৯ম তলা', 'room': 'Seresta', 'title': '৩২নং ও ৩৭নং আদালতের সেরেস্তা', 'details': '৩২ নম্বর কোর্ট সেরেস্তা ও ৩৭ নম্বর কোর্টের সেরেস্তা শাখা।', 'contact': ''},
    {'floor': '৯ম তলা', 'room': '৩৩/০৬', 'title': 'দ্রুত বিচার আদালত নং-০৬', 'details': 'স্পেশাল জেলা জজ ও স্পেশাল দায়রা জজ আদালত সংলগ্ন।', 'contact': ''},
    {'floor': '৯ম তলা', 'room': 'আপীল-৪', 'title': 'পারিবারিক আপিল আদালত নং-০৪, ঢাকা', 'details': 'বর্তমানে: জেলা ও দায়রা জজ এর কার্যালয়, ঢাকা।', 'contact': ''},
    {'floor': '৯ম তলা', 'room': 'PP', 'title': 'পাবলিক প্রসেকিউশন (পিপি)', 'details': 'রুবিনা আক্তার রুবা (অ্যাডভোকেট, সুপ্রিম কোর্ট), অতিরিক্ত পাবলিক প্রসেকিউটর, পারিবারিক আপিল আদালত-৪', 'contact': '01711224406'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredData = cjmData.where((item) {
      final matchesFloor = selectedFloor == 'সব ফ্লোর' || item['floor'] == selectedFloor;
      final matchesQuery = searchQuery.isEmpty ||
          item['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item['room']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item['details']!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFloor && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'চিফ জুডিশিয়াল ম্যাজিস্ট্রেট আদালত (CJM)',
          style: GoogleFonts.tiroBangla(color: Colors.white, fontSize: 17),
        ),
        backgroundColor: const Color(0xFF0A192F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Banner & Quick Search Area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF0A192F),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) {
                    setState(() {
                      searchQuery = val;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'CJM কোর্ট, রুম নং বা থানা খুঁজুন...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.12),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.info_outline, color: Color(0xFFD4AF37), size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'CJM ভবনের ২য় থেকে ৯table তলা পর্যন্ত সম্পূর্ণ ফ্লোর-প্ল্যান ও ডিরেক্টরি',
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Horizontal Floor Filter Chips
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            color: Colors.white,
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
                          fontSize: 13,
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

          // Items List View
          Expanded(
            child: filteredData.isEmpty
                ? Center(
                    child: Text(
                      'কোন তথ্য পাওয়া যায়নি',
                      style: GoogleFonts.tiroBangla(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      final item = filteredData[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Floor Badge
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0A192F),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item['floor']!,
                                      style: GoogleFonts.tiroBangla(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD4AF37).withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: const Color(0xFFD4AF37), width: 0.8),
                                    ),
                                    child: Text(
                                      'কক্ষ: ${item['room']}',
                                      style: GoogleFonts.tiroBangla(
                                        color: const Color(0xFF0A192F),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),

                              // Detailed Content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title']!,
                                      style: GoogleFonts.tiroBangla(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF0A192F),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item['details']!,
                                      // ✅ সঠিক কোড: style: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.black.withOpacity(0.7), // অথবা Colors.black87 ব্যবহার করতে পারেন
                                      height: 1.3,
                                    ),
                                  ),
                                    if (item['contact'] != null && item['contact']!.isNotEmpty) ...[
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.phone, size: 14, color: Color(0xFFD4AF37)),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              item['contact']!,
                                              style: GoogleFonts.tiroBangla(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF0A192F),
                                              ),
                                            ),
                                          ),
                                        ],
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
