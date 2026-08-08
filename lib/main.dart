import 'dart:async';
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
      title: 'Biplob Dhaka Court',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF031327),
        scaffoldBackgroundColor: const Color(0xFF031327),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF031327),
          primary: const Color(0xFF031327),
          secondary: const Color(0xFF5CE1E6),
        ),
        textTheme: GoogleFonts.tiroBanglaTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashScreen(),
    );
  }
}

// ------------------- SPLASH SCREEN WITH 3D TICKER -------------------

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ScrollController _scrollController;
  Timer? _timer;
  Timer? _navigateTimer;

  final String tickerText =
      "This App is designed by Biplob Hossen for the people, by the people, to the people  @ Apprentice Lawyer, Dhaka Judge Court, Dhaka. WhatsApp: 01757700054          ";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // ব্রেকিং নিউজ স্ক্রোলিং অ্যানিমেশন
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startNewsTicker();
    });

    // ৩ সেকেন্ড পর হোমপেজে নেভিগেট করবে
    _navigateTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainHomeScreen()),
        );
      }
    });
  }

  void _startNewsTicker() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;
        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            currentScroll + 3.0,
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _navigateTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031327),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: CircuitBackgroundPainter(),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ৩ডি ফ্রেম সহ প্রোফাইল পিকচার
                    Container(
                      width: 170,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF5CE1E6), width: 2.5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5CE1E6).withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 3,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    // টেলিভিশন ব্রেকিং নিউজ স্টাইলের ৩ডি ব্যানার ও টেক্সট স্ক্রোলার
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8B0000), Color(0xFFD32F2F), Color(0xFF8B0000)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // ৩ডি ব্রেকিং ব্যাজ (এখানে ফিক্স করা হয়েছে)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFD700),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'BREAKING',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                letterSpacing: 1.1,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // ৩ডি টেক্সট মার্কি / ব্রেকিং নিউজ টেক্সট
                          Expanded(
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              child: Center(
                                child: Text(
                                  tickerText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(1.5, 1.5),
                                        blurRadius: 3.0,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
      backgroundColor: const Color(0xFF031327),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: CircuitBackgroundPainter(),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 90),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildProfileHeader(),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 40),
                      Text(
                        'Biplob Dhaka Court',
                        style: GoogleFonts.cinzel(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(width: 15),
                      IconButton(
                        icon: const Icon(Icons.psychology, color: Color(0xFFD4AF37), size: 30),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GeminiAIScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF132A4A).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF1D4D75), width: 1),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'কোর্ট বা রুম নম্বর খুঁজুন...',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                          prefixIcon: Icon(Icons.search, color: Color(0xFFC29B38), size: 26),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CyberBorderContainer(
                      borderColor: const Color(0xFFC29B38),
                      fillColor: const Color(0xFF031327),
                      strokeWidth: 1.5,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Icon(Icons.gavel_rounded, color: Color(0xFFC29B38), size: 24),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'আইনজীবী ও বিচারপ্রার্থীদের জন্য দ্রুত কোর্ট ট্র্যাকিং সমাধান',
                                style: TextStyle(
                                  color: Color(0xFFE0C872),
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _buildCategoryCard(
                          title: 'ম্যাজিস্ট্রেট কোর্ট',
                          subtitle: 'CMM, CJM এবং নির্বাহী ম্যাজিস্ট্রেট কোর্টের তালিকা',
                          icon: Icons.gavel,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MagistrateCourtMenuScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCategoryCard(
                          title: 'মহানগর দায়রা জজ আদালত',
                          subtitle: 'ভবন ও টিন শেড-এর ফ্লোর ভিত্তিক সকল কোর্ট',
                          icon: Icons.gavel,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MetropolitanSessionsCourtScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCategoryCard(
                          title: 'জেলা ও দায়রা জজ আদালত',
                          subtitle: 'নতুন ও পুরাতন বিল্ডিং ভবন',
                          icon: Icons.apartment,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const DistrictCourtMenuScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCategoryCard(
                          title: 'রেবতী ম্যানশন, জেলা জজ আদালত',
                          subtitle: 'রেবতী ম্যানশনের সংশ্লিষ্ট সকল কোর্টসমূহ',
                          icon: Icons.apartment,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RebotiMansionScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CyberBorderContainer(
                  borderColor: const Color(0xFF5CE1E6),
                  fillColor: const Color(0xFFC29B38),
                  cutSize: 10,
                  strokeWidth: 2,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GeminiAIScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_awesome, color: Colors.black, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Need any Help',
                              style: GoogleFonts.cinzel(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CyberBorderContainer(
        borderColor: const Color(0xFF5CE1E6),
        fillColor: const Color(0xFF051D38).withOpacity(0.6),
        strokeWidth: 1.5,
        cutSize: 12,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 110,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF5CE1E6), width: 1.5),
                  borderRadius: BorderRadius.circular(4),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Biplob Hossen',
                      style: GoogleFonts.cinzel(
                        color: const Color(0xFFE0C872),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      'LL.B (Hon\'s), LL.M\nApprentice Lawyer,\nDhaka Judge Court.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11.5,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Email: biplobdiu67@gmail.com\nWhatsApp: 01757700054',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 10,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return CyberBorderContainer(
      borderColor: const Color(0xFF5CE1E6),
      fillColor: const Color(0xFF051E3C).withOpacity(0.85),
      cutSize: 12,
      strokeWidth: 1.5,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              CyberBorderContainer(
                borderColor: const Color(0xFF5CE1E6),
                fillColor: Colors.transparent,
                cutSize: 6,
                strokeWidth: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.tiroBangla(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFFC29B38),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- CUSTOM CYBER SHAPE CONTAINER -------------------

class CyberBorderContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final Color fillColor;
  final double cutSize;
  final double strokeWidth;

  const CyberBorderContainer({
    super.key,
    required this.child,
    this.borderColor = const Color(0xFF5CE1E6),
    this.fillColor = const Color(0xFF031327),
    this.cutSize = 10,
    this.strokeWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CyberBorderPainter(
        borderColor: borderColor,
        fillColor: fillColor,
        cutSize: cutSize,
        strokeWidth: strokeWidth,
      ),
      child: child,
    );
  }
}

class _CyberBorderPainter extends CustomPainter {
  final Color borderColor;
  final Color fillColor;
  final double cutSize;
  final double strokeWidth;

  _CyberBorderPainter({
    required this.borderColor,
    required this.fillColor,
    required this.cutSize,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    path.moveTo(cutSize, 0);
    path.lineTo(size.width - cutSize, 0);
    path.lineTo(size.width, cutSize);
    path.lineTo(size.width, size.height - cutSize);
    path.lineTo(size.width - cutSize, size.height);
    path.lineTo(cutSize, size.height);
    path.lineTo(0, size.height - cutSize);
    path.lineTo(0, cutSize);
    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ------------------- BACKGROUND CIRCUIT DESIGN -------------------

class CircuitBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0E385D).withOpacity(0.4)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF5CE1E6).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(10, 80);
    path.lineTo(50, 80);
    path.lineTo(80, 110);

    path.moveTo(size.width - 10, 80);
    path.lineTo(size.width - 50, 80);
    path.lineTo(size.width - 80, 110);

    path.moveTo(0, 300);
    path.lineTo(30, 300);
    path.lineTo(50, 320);
    path.lineTo(50, 400);

    path.moveTo(size.width, 450);
    path.lineTo(size.width - 30, 450);
    path.lineTo(size.width - 50, 470);

    canvas.drawPath(path, paint);

    canvas.drawCircle(const Offset(80, 110), 3, dotPaint);
    canvas.drawCircle(Offset(size.width - 80, 110), 3, dotPaint);
    canvas.drawCircle(const Offset(50, 400), 3, dotPaint);
    canvas.drawCircle(Offset(size.width - 50, 470), 3, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ------------------- MAGISTRATE COURT MENU SCREEN -------------------

class MagistrateCourtMenuScreen extends StatelessWidget {
  const MagistrateCourtMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ম্যাজিস্ট্রেট কোর্ট',
          style: GoogleFonts.tiroBangla(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color(0xFF031327),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuOptionCard(
            title: 'চিফ মেট্রোপলিটন ম্যাজিস্ট্রেট কোর্ট\n(CMM)',
            subtitle: 'তলার তালিকা দেখতে ক্লিক করুন',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CMMCourtScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildMenuOptionCard(
            title: 'চিফ জুডিশিয়াল ম্যাজিস্ট্রেট কোর্ট\n(CJM)',
            subtitle: 'তলার তালিকা দেখতে ক্লিক করুন',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CJMCourtScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildMenuOptionCard(
            title: 'নির্বাহী ম্যাজিস্ট্রেট কোর্ট',
            subtitle: 'তলার তালিকা দেখতে ক্লিক করুন',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CourtDetailsScreen(
                    courtName: 'নির্বাহী ম্যাজিস্ট্রেট কোর্ট',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOptionCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return CyberBorderContainer(
      borderColor: const Color(0xFF5CE1E6),
      fillColor: const Color(0xFF051E3C),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFC29B38),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.stairs_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.tiroBangla(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.white60),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 18),
        onTap: onTap,
      ),
    );
  }
}

// ------------------- CMM COURT SCREEN -------------------

class CMMCourtScreen extends StatefulWidget {
  const CMMCourtScreen({super.key});

  @override
  State<CMMCourtScreen> createState() => _CMMCourtScreenState();
}

class _CMMCourtScreenState extends State<CMMCourtScreen> {
  String selectedFloor = 'সব ফ্লোর';

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

  final List<Map<String, dynamic>> cmmData = [
    {'floor': '২য় তলা', 'title': 'জি. আর শাখা এবং কোর্ট নং-২৭, ২৮', 'sub': 'চিফ মেট্রোপলিটন ম্যাজিস্ট্রেট কোর্ট (CMM), ঢাকা'},
    {'floor': '২য় তলা', 'title': 'জিআর শাখা (GR Section)', 'sub': 'ঢাকা মেট্রোপলিটন পুলিশ (DMP)'},
    {'floor': '২য় তলা', 'title': 'নারী ও শিশু জি. আর শাখা', 'sub': 'সি.এম.এম কোর্ট, ঢাকা'},
    {'floor': '২য় তলা', 'title': 'পি.আর শাখা', 'sub': 'সি.এম.এম কোর্ট, ঢাকা'},
    {'floor': '২য় তলা', 'title': 'অতিরিক্ত পুলিশ কমিশনারের কার্যালয়', 'sub': 'ঢাকা মেট্রোপলিটন পুলিশ'},
    {'floor': '৩য় তলা', 'title': 'কোর্ট নং-০১, ০২ এবং নেজারত শাখা', 'sub': 'সি.এম.এম কোর্ট, ঢাকা'},
    {'floor': '৪র্থ তলা', 'title': 'কোর্ট নং-৩, ৪, ৫, ৬', 'sub': 'সি.এম.এম কোর্ট, ঢাকা'},
    {'floor': '৫ম তলা', 'title': 'কোর্ট নং-৭, ৮, ৯, ১০', 'sub': 'সি.এম.এম কোর্ট, ঢাকা'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'কোর্ট নং-১১, ১২, ১৩, ১৪', 'sub': 'সি.এম.এম কোর্ট, ঢাকা'},
    {'floor': '৭ম তলা', 'title': 'কোর্ট নং-১৫, ১৬, ১৭, ১৮', 'sub': 'সি.এম.এম কোর্ট, ঢাকা'},
    {'floor': '৮ম তলা', 'title': 'কোর্ট নং-১৯, ২০, ২১, ২২', 'sub': 'সি.এম.এম কোর্ট, ঢাকা'},
    {'floor': '৯ম তলা', 'title': 'কোর্ট নং-২৩, ২৪, ২৫, ২৬', 'sub': 'সি.এম.এম কোর্ট, ঢাকা'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCourts = selectedFloor == 'সব ফ্লোর'
        ? cmmData
        : cmmData.where((item) => item['floor'] == selectedFloor).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'চিফ মেট্রোপলিটন ম্যাজিস্ট্রেট কোর্ট (CMM)',
          style: GoogleFonts.tiroBangla(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: const Color(0xFF031327),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: const BoxDecoration(color: Color(0xFF051E3C)),
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
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFFC29B38),
                      backgroundColor: const Color(0xFF031327),
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
          Expanded(
            child: filteredCourts.isEmpty
                ? const Center(child: Text('কোন তথ্য পাওয়া যায়নি', style: TextStyle(color: Colors.white)))
                : ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: filteredCourts.length,
                    itemBuilder: (context, index) {
                      final court = filteredCourts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: CyberBorderContainer(
                          borderColor: const Color(0xFF5CE1E6),
                          fillColor: const Color(0xFF051E3C),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC29B38),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    court['floor'],
                                    style: GoogleFonts.tiroBangla(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        court['title'],
                                        style: GoogleFonts.tiroBangla(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (court.containsKey('sub')) ...[
                                        const SizedBox(height: 6),
                                        Text(
                                          court['sub'],
                                          style: GoogleFonts.tiroBangla(
                                            fontSize: 12,
                                            color: Colors.white70,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
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

// ------------------- CJM COURT SCREEN -------------------

class CJMCourtScreen extends StatefulWidget {
  const CJMCourtScreen({super.key});

  @override
  State<CJMCourtScreen> createState() => _CJMCourtScreenState();
}

class _CJMCourtScreenState extends State<CJMCourtScreen> {
  String selectedFloor = 'সব ফ্লোর';

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

  final List<Map<String, dynamic>> cjmData = [
    {'floor': '২য় তলা', 'room': 'কক্ষ ২০১', 'title': 'রেকর্ড শাখা', 'sub': 'রেকর্ড কর্মকর্তা: আব্দুল্লাহ-আল-মাহমুদ\nমোবাইল: ০১৬৮৫২১৬৬৮১, ০১৭৩৪২৯৯৯৫৫\nহেল্পলাইন: ০১৩৩৫-১৪৫০০১'},
    {'floor': '২য় তলা', 'room': 'কক্ষ ২০২', 'title': 'প্রশাসনিক কর্মকর্তা শাখা', 'sub': 'প্রশাসনিক জামানত ও হাইকোর্ট বিভাগ সংক্রান্ত আপীল আদালত বিষয়ক শাখা।'},
    {'floor': '২য় তলা', 'room': 'কক্ষ ২০৩', 'title': 'নেজারত শাখা', 'sub': 'নেজারত হেল্পলাইন: ০১৩৩৫-১৪৫০০১'},
    {'floor': '২য় তলা', 'room': 'কক্ষ ২০৪', 'title': 'জুডিশিয়াল মুন্সীখানা অফিস', 'sub': 'হেল্পলাইন: ০১৩৩৫-১৪৫০০১'},
    {'floor': '২য় তলা', 'room': 'হাজতখানা', 'title': 'CJM কোর্ট হাজতখানা', 'sub': 'বিশেষ নির্দেশিকা: বিনা অনুমতিতে প্রবেশ সম্পূর্ণ নিষেধ।'},
    {'floor': '৩য় তলা', 'room': 'কক্ষ ৩০১', 'title': 'চীফ জুডিশিয়াল ম্যাজিস্ট্রেট আদালত', 'sub': 'প্রধান আদালত - চীফ জুডিশিয়াল ম্যাজিস্ট্রেট, ঢাকা।'},
    {'floor': '৩য় তলা', 'room': 'কক্ষ ৩০২', 'title': 'অতিরিক্ত চীফ জুডিশিয়াল ম্যাজিস্ট্রেট আদালত', 'sub': 'অতিরিক্ত চীফ জুডিশিয়াল ম্যাজিস্ট্রেট, ঢাকা।'},
    {'floor': '৩য় তলা', 'room': 'কক্ষ ৩০৩', 'title': 'সম্মেলন ও মিলনায়তন', 'sub': 'কনফারেন্স ও মিটিং রুম।'},
    {'floor': '৩য় তলা', 'room': 'কক্ষ ৩০৪', 'title': 'স্টেনোগ্রাফার শাখা (CJM)', 'sub': 'চীফ জুডিশিয়াল ম্যাজিস্ট্রেট স্টেনোগ্রাফার কক্ষ।'},
    {'floor': '৩য় তলা', 'room': 'কক্ষ ৩০৫', 'title': 'অতিথি কক্ষ (Guest Room)', 'sub': 'দর্শনার্থী ও অতিথি বিশ্রামাগার।'},
    {'floor': '৩য় তলা', 'room': 'কক্ষ ৩০৬', 'title': 'হিসাব শাখা', 'sub': 'অর্থ শাখা - জেলা ও দায়রা জজ এবং সিজেএম আদালত, ঢাকা\nহেল্পলাইন: ০১৩৩৫-১৪৫০০১'},
    {'floor': '৩য় তলা', 'room': 'কক্ষ ৩০৭', 'title': 'স্টেনোগ্রাফার (ACJM) ও শাখা', 'sub': 'অতিরিক্ত চীফ জুডিশিয়াল ম্যাজিস্ট্রেট শাখা ও স্টেনো কক্ষ।'},
    {'floor': '৩য় তলা', 'room': 'কক্ষ ৩০৮', 'title': 'আদালত লাইব্রেরী', 'sub': 'আইন গ্রন্থ ও নথিপত্র পাঠাগার।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'মোহাম্মদপুর ও আদাবর থানা G.R.', 'sub': 'অপরাধ তথ্য ও প্রসিকিউশন বিভাগ, ডিএমপি।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'রামপুরা ও সবুজবাগ থানা G.R.', 'sub': 'অপরাধ তথ্য ও প্রসিকিউশন বিভাগ।'},
    {'floor': '৪র্থ তলা', 'room': 'কক্ষ ৪১১', 'title': 'মিরপুর, শেরেবাংলা নগর, শাহআলী ও দারুস-সালাম থানা G.R.', 'sub': 'জি.আর. সেকশন।'},
    {'floor': '৪র্থ তলা', 'room': 'কক্ষ ৪১২', 'title': 'বাড্ডা ও ভাটারা থানা G.R.', 'sub': 'জি.আর. সেকশন।'},
    {'floor': '৪র্থ তলা', 'room': 'কক্ষ ৪১৩', 'title': 'লালবাগ, চকবাজার, কামরাঙ্গীরচর, কোতোয়ালী ও বংশাল থানা G.R.', 'sub': 'জি.আর. শাখা ও প্রসিকিউশন বিভাগ।'},
    {'floor': '৪র্থ তলা', 'room': 'কক্ষ ৪০৬', 'title': 'মতিঝিল, পল্টন ও শাহজাহানপুর থানা G.R.', 'sub': 'জি.আর. শাখা, প্রসিকিউশন বিভাগ।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'রমনা ও শাহবাগ থানা G.R.', 'sub': 'প্যারাফ্যাসিলিটি পরামর্শ: ০১৬৪৭১৩০৩৩৯'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'মিরপুর, পল্লবী, রূপনগর, কাফরুল ও ভাসানটেক থানা G.R.', 'sub': 'প্যারাফ্যাসিলিটি পরামর্শ: ০১৬৪৭১৩০৩৩৯'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'নিউমার্কেট ও কলাবাগান থানা G.R.', 'sub': 'প্রসিকিউশন বিভাগ, ডিএমপি।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'খিলক্ষেত ও ক্যান্টনমেন্ট থানা G.R.', 'sub': 'প্রসিকিউশন বিভাগ, ডিএমপি।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'সূত্রাপুর, গণ্ডারিয়া ও ওয়ারী থানা G.R.', 'sub': 'প্রসিকিউশন বিভাগ, ডিএমপি।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'তেজগাঁও, তেজগাঁও শিল্পাঞ্চল ও হাতিরঝিল থানা G.R.', 'sub': 'জি.আর. শাখা ও প্রসিকিউশন।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'গুলশান ও বনানী থানা G.R.', 'sub': 'জি.আর. শাখা।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'কদমতলী ও শ্যামপুর থানা G.R.', 'sub': 'জি.আর. শাখা।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'যাত্রাবাড়ী, ডেমরা, খিলগাঁও ও মুগদা থানা G.R.', 'sub': 'জি.আর. শাখা।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'বিমানবন্দর, উত্তরখান ও দক্ষিণখান থানা G.R.', 'sub': 'জি.আর. শাখা।'},
    {'floor': '৪র্থ তলা', 'room': 'জি.আর. শাখা', 'title': 'ধানমণ্ডি ও হাজারীবাগ থানা G.R.', 'sub': 'জি.আর. শাখা।'},
    {'floor': '৪র্থ তলা', 'room': 'শাখা রিসিভ', 'title': 'রিসিভ ও ডিসপ্যাচ শাখা', 'sub': 'ডিএমপি, ঢাকা শাখা রিসিভ-ডিসপ্যাচ।'},
    {'floor': '৫ম তলা', 'room': 'জি.আর. শাখা', 'title': 'উপজেলা জি.আর. শাখাসমূহ', 'sub': 'দোহার, নবাবগঞ্জ, ধামরাই, আশুলিয়া ও সাভার থানা।'},
    {'floor': '৫ম তলা', 'room': 'জি.আর. শাখা', 'title': 'কেরানীগঞ্জ ও দক্ষিণ কেরানীগঞ্জ থানা', 'sub': 'জি.আর. শাখা।'},
    {'floor': '৫ম তলা', 'room': 'নন-জি.আর. শাখা', 'title': 'নন-জি.আর. মামলা শাখা', 'sub': 'সাভার, আশুলিয়া, ধামরাই ও রেলওয়ে থানা।'},
    {'floor': '৫ম তলা', 'room': 'আদালত ২৯', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট কোর্ট', 'sub': 'বিচারের দায়িত্বে: আলবীরুনী মীর।'},
    {'floor': '৫ম তলা', 'room': 'লিগ্যাল এইড', 'title': 'জেলা লিগ্যাল এইড অফিসারের কার্যালয়', 'sub': 'বিনামূল্যে সরকারি আইনি সহায়তা কেন্দ্র।'},
    {'floor': '৫ম তলা', 'room': 'রেকর্ড রুম', 'title': 'পুলিশ রেকর্ড রুম (সিডি শাখা)', 'sub': 'গোপনীয় শাখা / কেস ডায়েরি (CD) শাখা।'},
    {'floor': '৫ম তলা', 'room': 'মাদক সেকশন', 'title': 'মাদকদ্রব্য নিয়ন্ত্রণ প্রসিকিউশন সেকশন', 'sub': 'ঢাকা মেট্রো (উত্তর), ঢাকা মেট্রো (দক্ষিণ) ও ঢাকা জেলা কার্যালয়।'},
    {'floor': '৫ম তলা', 'room': 'ডিজিটাল রুম', 'title': 'ডিজিটাল ডাটা ম্যানেজমেন্ট রুম', 'sub': 'কোঅর্ডিনেশন ও তথ্য ব্যবস্থাপনা রুম (কোর্ট পুলিশ, ঢাকা জেলা)।'},
    {'floor': '৬ষ্ঠ তলা', 'room': 'কক্ষ ৬০১', 'title': 'জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-৩, ঢাকা কোর্ট', 'sub': 'সংশ্লিষ্ট স্টেনো টাইপিস্ট: কক্ষ নং-৬০৫'},
    {'floor': '৬ষ্ঠ তলা', 'room': 'কক্ষ ৬০২', 'title': 'সিনিয়র জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-১, ঢাকা কোর্ট', 'sub': 'সংশ্লিষ্ট স্টেনো টাইপিস্ট: কক্ষ নং-৬০৬'},
    {'floor': '৬ষ্ঠ তলা', 'room': 'কক্ষ ৬০৩', 'title': 'সিনিয়র জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-২, ঢাকা কোর্ট', 'sub': 'সংশ্লিষ্ট স্টেনো টাইপিস্ট: কক্ষ নং-৬০৭'},
    {'floor': '৬ষ্ঠ তলা', 'room': 'কক্ষ ৬০৪', 'title': 'জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-২, ঢাকা কোর্ট', 'sub': 'সংশ্লিষ্ট স্টেনো টাইপিস্ট: কক্ষ নং-৬০৮'},
    {'floor': '৭ম তলা', 'room': 'কক্ষ ৭০১', 'title': 'জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-৫, ঢাকা কোর্ট', 'sub': 'সংশ্লিষ্ট স্টেনো টাইপিস্ট: কক্ষ নং-৭০৫'},
    {'floor': '৭ম তলা', 'room': 'কক্ষ ৭০২', 'title': 'সিনিয়র জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-৩, ঢাকা কোর্ট', 'sub': 'সংশ্লিষ্ট স্টেনো টাইপিস্ট: কক্ষ নং-৭০৬'},
    {'floor': '৭ম তলা', 'room': 'কক্ষ ৭০৩', 'title': 'জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-১, ঢাকা কোর্ট', 'sub': 'সংশ্লিষ্ট স্টেনো টাইপিস্ট: কক্ষ নং-৭০৭'},
    {'floor': '৭ম তলা', 'room': 'কক্ষ ৭০৪', 'title': 'জুডিশিয়াল ম্যাজিস্ট্রেট আদালত নং-৪, ঢাকা কোর্ট', 'sub': 'সংশ্লিষ্ট স্টেনো টাইপিস্ট: কক্ষ নং-৭০৮'},
    {'floor': '৭ম তলা', 'room': 'কক্ষ ৭০০', 'title': 'ফর্মস এন্ড স্টেশনারী শাখা', 'sub': 'সরকারি ফর্ম ও প্রয়োজনীয় স্টেশনারী সরবরাহ শাখা।'},
    {'floor': '৮ম তলা', 'room': 'আদালত ৩০', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট আদালত নং-৩০', 'sub': 'বিচারক: মোঃ ছিদ্দিক আজাদ (এজলাস)'},
    {'floor': '৮ম তলা', 'room': 'ট্রাইব্যুনাল', 'title': 'সন্ত্রাস বিরোধী বিশেষ ট্রাইব্যুনাল, ঢাকা', 'sub': 'Anti-Terrorism Special Tribunal, Dhaka (এজলাস ও অফিস)'},
    {'floor': '৮ম তলা', 'room': 'আদালত ৩৬', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট আদালত নং-৩৬', 'sub': 'বিচারকের খাসকামরা ও এজলাস।'},
    {'floor': '৮ম তলা', 'room': 'আপীল আদালত', 'title': 'পারিবারিক আপিল আদালত নং-১, ঢাকা', 'sub': 'পারিবারিক বিরোধ আপীল শুনানি আদালত।'},
    {'floor': '৮ম তলা', 'room': 'বিশেষ আদালত', 'title': 'স্পেশাল জেলা জজ ও স্পেশাল দায়রা জজ', 'sub': 'বিশেষ জজ আদালত, ঢাকা।'},
    {'floor': '৮ম তলা', 'room': 'কক্ষ ৬০', 'title': '৩১নং আদালতের সেরেস্তা', 'sub': '৩১ নম্বর আদালতের সেরেস্তা শাখা।'},
    {'floor': '৯ম তলা', 'room': 'আদালত ৩৩', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট আদালত নং-৩৩', 'sub': 'বিচারক: মহদেী হাসান (বিচারকের খাসকামরা ও এজলাস)।'},
    {'floor': '৯ম তলা', 'room': 'আদালত ৩৪', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট ও দ্রুত বিচার আদালত (নং-০৭)', 'sub': 'বিচারক: মোঃ আশরাফুল হক, সিএমএম কোর্ট, ঢাকা।'},
    {'floor': '৯ম তলা', 'room': 'আদালত ৩৫', 'title': 'মেট্রোপলিটন ম্যাজিস্ট্রেট আদালত নং-৩৫', 'sub': 'বিচারক: মোঃ রকিবুল হাসান।'},
    {'floor': '৯ম তলা', 'room': 'সেরেস্তা', 'title': '৩২নং ও ৩৭নং আদালতের সেরেস্তা', 'sub': '৩২ নম্বর কোর্ট সেরেস্তা ও ৩৭ নম্বর কোর্টের সেরেস্তা শাখা।'},
    {'floor': '৯ম তলা', 'room': 'কোর্ট ৩৩/০৬', 'title': 'দ্রুত বিচার আদালত নং-০৬', 'sub': 'স্পেশাল জেলা জজ ও স্পেশাল দায়রা জজ আদালত সংলগ্ন।'},
    {'floor': '৯ম তলা', 'room': 'আপীল আদালত-৪', 'title': 'পারিবারিক আপিল আদালত নং-০৪, ঢাকা', 'sub': 'বর্তমানে: জেলা ও দায়রা জজ এর কার্যালয়, ঢাকা।\nপাবলিক প্রসিকিউশন/পিপি: রুবিনা আক্তার রুবা (০১৭১১২২৪৪০৬)'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCourts = selectedFloor == 'সব ফ্লোর'
        ? cjmData
        : cjmData.where((item) => item['floor'] == selectedFloor).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'চিফ জুডিশিয়াল ম্যাজিস্ট্রেট আদালত (CJM)',
          style: GoogleFonts.tiroBangla(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF031327),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: const BoxDecoration(color: Color(0xFF051E3C)),
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
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFFC29B38),
                      backgroundColor: const Color(0xFF031327),
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
          Expanded(
            child: filteredCourts.isEmpty
                ? const Center(child: Text('কোন তথ্য পাওয়া যায়নি', style: TextStyle(color: Colors.white)))
                : ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: filteredCourts.length,
                    itemBuilder: (context, index) {
                      final court = filteredCourts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: CyberBorderContainer(
                          borderColor: const Color(0xFF5CE1E6),
                          fillColor: const Color(0xFF051E3C),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFC29B38),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        court['floor'],
                                        style: GoogleFonts.tiroBangla(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (court.containsKey('room')) ...[
                                      const SizedBox(height: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF5CE1E6).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          court['room'],
                                          style: GoogleFonts.tiroBangla(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        court['title'],
                                        style: GoogleFonts.tiroBangla(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (court.containsKey('sub')) ...[
                                        const SizedBox(height: 6),
                                        Text(
                                          court['sub'],
                                          style: GoogleFonts.tiroBangla(
                                            fontSize: 12,
                                            color: Colors.white70,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
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

// ------------------- DISTRICT COURT MENU SCREEN -------------------

class DistrictCourtMenuScreen extends StatelessWidget {
  const DistrictCourtMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'জেলা ও দায়রা জজ আদালত',
          style: GoogleFonts.tiroBangla(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF031327),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuOptionCard(
            title: 'জেলা ও দায়রা জজ আদালত (নতুন বিল্ডিং)',
            subtitle: 'তলার তালিকা দেখতে ক্লিক করুন',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DistrictCourtNewBuildingScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildMenuOptionCard(
            title: 'জেলা ও দায়রা জজ আদালত (পুরাতন বিল্ডিং)',
            subtitle: 'তলার তালিকা দেখতে ক্লিক করুন',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DistrictCourtOldBuildingScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOptionCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return CyberBorderContainer(
      borderColor: const Color(0xFF5CE1E6),
      fillColor: const Color(0xFF051E3C),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFC29B38),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.stairs_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.tiroBangla(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.white60),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 18),
        onTap: onTap,
      ),
    );
  }
}

// ------------------- DISTRICT COURT NEW BUILDING -------------------

class DistrictCourtNewBuildingScreen extends StatefulWidget {
  const DistrictCourtNewBuildingScreen({super.key});

  @override
  State<DistrictCourtNewBuildingScreen> createState() => _DistrictCourtNewBuildingScreenState();
}

class _DistrictCourtNewBuildingScreenState extends State<DistrictCourtNewBuildingScreen> {
  String selectedFloor = 'সব ফ্লোর';

  final List<String> floorList = [
    'সব ফ্লোর',
    'নিচ তলা',
    '২য় তলা',
    '৩য় তলা',
    '৪র্থ তলা',
    '৫ম তলা',
    '৬ষ্ঠ তলা',
    '৭ম তলা',
    '৮ম তলা',
  ];

  final List<Map<String, dynamic>> courtData = [
    {'floor': 'নিচ তলা', 'title': 'পারিবারিক আপিল আদালত- ৫, ঢাকা', 'sub': 'শাখা / ধরন: বিচারিক আদালত'},
    {'floor': 'নিচ তলা', 'title': 'অর্থঋণ আদালত নং- ৭ (সেরেস্তা শাখা)', 'sub': 'শাখা / ধরন: সেরেস্তা শাখা'},
    {'floor': 'নিচ তলা', 'title': '৫ম অতিরিক্ত সিভিল জজ আদালত, ঢাকা', 'sub': 'শাখা / ধরন: বিচারিক আদালত'},
    {'floor': 'নিচ তলা', 'title': 'পারিবারিক আদালত নং- ০৭, ঢাকা', 'sub': 'শাখা / ধরন: সেরেস্তা শাখা'},
    {'floor': 'নিচ তলা', 'title': 'পারিবারিক আদালত নং- ১১, ঢাকা', 'sub': 'শাখা / ধরন: সেরেস্তা শাখা'},
    {'floor': 'নিচ তলা', 'title': 'সিভিল জজ আদালত- ১০, ঢাকা (বিমানবন্দর, ক্যান্টনমেন্ট ও শেরেবাংলা নগর)', 'sub': 'শাখা / ধরন: সেরেস্তা শাখা'},
    {'floor': 'নিচ তলা', 'title': 'সিনিয়র সিভিল জজ আদালত- ১০, ঢাকা (বিমানবন্দর, ক্যান্টনমেন্ট ও শেরেবাংলা নগর)', 'sub': 'শাখা / ধরন: সেরেস্তা শাখা'},
    {'floor': 'নিচ তলা', 'title': '৫ম অতিরিক্ত সহকারী জজ ও পারিবারিক আদালত, ঢাকা (পারিবারিক আদালত: ৩, ৮, ১৪)', 'sub': 'শাখা / ধরন: বিচারিক / পারিবারিক'},
    {'floor': 'নিচ তলা', 'title': 'সিনিয়র সিভিল জজ, ২য় অতিরিক্ত আদালত, ঢাকা', 'sub': 'শাখা / ধরন: বিচারিক আদালত'},
    {'floor': 'নিচ তলা', 'title': 'পারিবারিক আদালত- ৬, ঢাকা (শাহ আলী, মিরপুর মডেল, পল্লবী, দারুস সালাম ও রূপনগর)', 'sub': 'শাখা / ধরন: পারিবারিক আদালত'},
    {'floor': 'নিচ তলা', 'title': 'সিনিয়র সিভিল জজ আদালত- ৭, ঢাকা', 'sub': 'শাখা / ধরন: বিচারিক আদালত'},
    {'floor': 'নিচ তলা', 'title': 'সিভিল জজ আদালত- ৭, ঢাকা (ওয়ারী, গেন্ডারিয়া ও সূত্রাপুর থানা)', 'sub': 'শাখা / ধরন: বিচারিক আদালত'},
    {'floor': '২য় তলা', 'title': 'অতিরিক্ত জেলা ও দায়রা জজ ১ম আদালত, ঢাকা', 'sub': 'শাখা / ধরন: বিচারিক আদালত'},
    {'floor': '২য় তলা', 'title': 'বিশেষ ট্রাইব্যুনাল নং- ২, ঢাকা', 'sub': 'শাখা / ধরন: বিশেষ ট্রাইব্যুনাল'},
    {'floor': '২য় তলা', 'title': 'অনুলিপি বিভাগ, জেলা জজ আদালত, ঢাকা', 'sub': 'শাখা / ধরন: প্রশাসনিক শাখা'},
    {'floor': '২য় তলা', 'title': 'সমন শাখা, জজ কোর্ট, ঢাকা', 'sub': 'শাখা / ধরন: প্রশাসনিক শাখা'},
    {'floor': '৩য় তলা', 'title': 'সম্মেলন কক্ষ: জেলা ও দায়রা জজ আদালত, ঢাকা', 'sub': 'সম্মেলন ও সভা ঘর'},
    {'floor': '৩য় তলা', 'title': 'নামাজ পড়ার স্থান', 'sub': 'পুরুষ ও নারী পরীক্ষার্থীদের/আইনজীবীদের পৃথক সুব্যবস্থা'},
    {'floor': '৩য় তলা', 'title': 'নোটিশ বোর্ড', 'sub': '১২ দফা আচরণবিধি ও সেবা প্রদান সংক্রান্ত নোটিশ বোর্ড'},
    {'floor': '৪র্থ তলা', 'title': 'প্রশাসনিক কর্মকর্তা (এ.ও.) সেরেস্তা', 'sub': 'জেলা ও দায়রা জজ আদালত, ঢাকা (প্রশাসনিক বিভাগ)'},
    {'floor': '৪র্থ তলা', 'title': 'দেউলিয়া বিষয়ক আদালত, ঢাকা (বিচারকক্ষ ও সেরেস্তা)', 'sub': 'দেউলিয়া বিচার শাখা'},
    {'floor': '৪র্থ তলা', 'title': 'সম্মেলন ও সেবা শাখা, দেউলিয়া ও ট্রাইব্যুনাল', 'sub': 'সেরেস্তা ও স্টেনোগ্রাফারের রুম'},
    {'floor': '৪র্থ তলা', 'title': 'অতিরিক্ত জেলা ও দায়রা জজ ২য় আদালত, ঢাকা', 'sub': 'বিশেষ ট্রাইব্যুনাল নং-০৩, ঢাকা'},
    {'floor': '৪র্থ তলা', 'title': 'অতিরিক্ত জেলা ও দায়রা জজ আদালত, ঢাকা', 'sub': 'বিশেষ ট্রাইব্যুনাল নং-০৬, ঢাকা'},
    {'floor': '৫ম তলা', 'title': 'অতিরিক্ত জেলা ও দায়রা জজ ৬ষ্ঠ আদালত, ঢাকা', 'sub': 'বিশেষ ট্রাইব্যুনাল নং-০৭, ঢাকা (বিচারকক্ষ / এজলাস)'},
    {'floor': '৫ম তলা', 'title': 'অতিরিক্ত জেলা ও দায়রা জজ ৭ম আদালত, ঢাকা', 'sub': 'বিশেষ ট্রাইব্যুনাল নং-১৮, ঢাকা / গোপনীয় শাখা / স্টেনোগ্রাফার রুম'},
    {'floor': '৫ম তলা', 'title': 'অতিরিক্ত জেলা ও দায়রা জজ ৮ম আদালত, ঢাকা', 'sub': 'বিশেষ ট্রাইব্যুনাল নং-০৮, ঢাকা / বাণিজ্যিক আদালত-০৩, ঢাকা মহানগর'},
    {'floor': '৫ম তলা', 'title': 'অর্থঋণ আদালত নং-১, ঢাকা', 'sub': 'বিশেষ ট্রাইব্যুনাল নং-০৯, ঢাকা / এজলাস জজ অর্থঋণ আদালত নং-১'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'অর্থঋণ আদালতসমূহ (নং-১ সেরেস্তা, নং-৫ এজলাস ও সেরেস্তা, নং-৬ এজলাস)', 'sub': 'অর্থঋণ শাখা'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'কেরানীগঞ্জ অঞ্চল আদালতসমূহ (এজলাস সিভিল জজ, এজলাস সিনিয়র সিভিল জজ ও সেরেস্তা)', 'sub': 'সিনিয়র সহকারী জজ, কেরানীগঞ্জ থানা (ঢাকা সদর)'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'ল্যান্ড সার্ভে আপীল ট্রাইব্যুনাল, ঢাকা (এজলাস)', 'sub': 'ল্যান্ড সার্ভে শাখা'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'সহকারী জজ আদালত (৬ষ্ঠ সহকারী জজ, রুম নং-৬৩৭)', 'sub': 'সেরেস্তা সহকারী জজ / সিনিয়র সিভিল জজ / সিভিল জজ আদালত নং-৬'},
    {'floor': '৭ম তলা', 'title': 'যুগ্ম জেলা জজ অতিরিক্ত আদালত (সাবেক ৮ম ও ৬ষ্ঠ যুগ্ম জেলা জজ)', 'sub': 'এজলাস ও সেরেস্তা'},
    {'floor': '৭ম তলা', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল (সংযুক্ত: দোহার এজলাস)', 'sub': 'বিচারিক ট্রাইব্যুনাল'},
    {'floor': '৭ম তলা', 'title': 'সিনিয়র সিভিল জজ আদালত-১, ঢাকা', 'sub': 'সিনিয়র সিভিল জজ ১ম আদালত এজলাস ও সেরেস্তা'},
    {'floor': '৭ম তলা', 'title': 'সিনিয়র সহকারী জজ, দোহার (সাবেক ৮) আদালত', 'sub': 'সেরেস্তা শাখা'},
    {'floor': '৭ম তলা', 'title': 'পারিবারিক আদালত নং ২, ঢাকা', 'sub': 'ফাইলিং ও এফিডেভিট স্থান (ধামরাই, সাভার ও আশুলিয়া অঞ্চল)'},
    {'floor': '৭ম তলা', 'title': 'সিনিয়র সহকারী জজ ধামরাই আদালত', 'sub': 'বেঞ্চের কার্যক্রম ও সেরেস্তা'},
    {'floor': '৮ম তলা', 'title': 'সিনিয়র সহকারী জজ, ২য় আদালত, ঢাকা', 'sub': 'এজলাস শাখা'},
    {'floor': '৮ম তলা', 'title': 'সিনিয়র সিভিল জজ ৩য় ও ৪র্থ আদালত, ঢাকা', 'sub': 'এজলাস ও সেরেস্তা'},
    {'floor': '৮ম তলা', 'title': 'সিনিয়র সিভিল জজ ২য় আদালত, ঢাকা', 'sub': 'সেরেস্তা শাখা'},
    {'floor': '৮ম তলা', 'title': 'পারিবারিক আদালত-৯, ঢাকা', 'sub': 'পারিবারিক শাখা'},
    {'floor': '৮ম তলা', 'title': 'পারিবারিক আপীল আদালত নং-২, ঢাকা', 'sub': 'পারিবারিক আপীল শাখা'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCourts = selectedFloor == 'সব ফ্লোর'
        ? courtData
        : courtData.where((item) => item['floor'] == selectedFloor).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ঢাকা জেলা ও দায়রা জজ আদালত (নতুন ভবন)',
          style: GoogleFonts.tiroBangla(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: const Color(0xFF031327),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: const BoxDecoration(color: Color(0xFF051E3C)),
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
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFFC29B38),
                      backgroundColor: const Color(0xFF031327),
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
          Expanded(
            child: filteredCourts.isEmpty
                ? const Center(child: Text('কোন তথ্য পাওয়া যায়নি', style: TextStyle(color: Colors.white)))
                : ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: filteredCourts.length,
                    itemBuilder: (context, index) {
                      final court = filteredCourts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: CyberBorderContainer(
                          borderColor: const Color(0xFF5CE1E6),
                          fillColor: const Color(0xFF051E3C),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC29B38),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    court['floor'],
                                    style: GoogleFonts.tiroBangla(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        court['title'],
                                        style: GoogleFonts.tiroBangla(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (court.containsKey('sub')) ...[
                                        const SizedBox(height: 6),
                                        Text(
                                          court['sub'],
                                          style: GoogleFonts.tiroBangla(
                                            fontSize: 12,
                                            color: Colors.white70,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
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

// ------------------- DISTRICT COURT OLD BUILDING -------------------

class DistrictCourtOldBuildingScreen extends StatefulWidget {
  const DistrictCourtOldBuildingScreen({super.key});

  @override
  State<DistrictCourtOldBuildingScreen> createState() => _DistrictCourtOldBuildingScreenState();
}

class _DistrictCourtOldBuildingScreenState extends State<DistrictCourtOldBuildingScreen> {
  String selectedFloor = 'সব ফ্লোর';

  final List<String> floorList = [
    'সব ফ্লোর',
    '১ম তলা',
    '২য় তলা',
    '৩য় তলা',
    '৪র্থ তলা',
    '৫ম তলা',
    '৬ষ্ঠ তলা',
  ];

  final List<Map<String, dynamic>> courtData = [
    {'floor': '১ম তলা', 'title': 'সিনিয়র সিভিল জজ ৪র্থ অতিরিক্ত আদালত, ঢাকা', 'sub': 'ধরন: দেওয়ানি আদালত'},
    {'floor': '১ম তলা', 'title': 'সিনিয়র সিভিল জজ আদালত-১৪, ঢাকা / সিনিয়র সহকারী জজ ৭ম আদালত (নবাবগঞ্জ), ঢাকা (পারিবারিক আদালত নং-০১)', 'sub': 'ধরন: দেওয়ানি ও পারিবারিক আদালত'},
    {'floor': '১ম তলা', 'title': 'নেজারত বিভাগ, জেলা জজ আদালত, ঢাকা', 'sub': 'ধরন: প্রশাসনিক শাখা দপ্তর'},
    {'floor': '১ম তলা', 'title': 'বিচার সেবা প্রাপ্তি সংক্রান্ত হেল্পলাইন, জেলা ও দায়রা জজ আদালত এবং চীফ জুডিসিয়াল ম্যাজিস্ট্রেট আদালত, ঢাকা', 'sub': 'ধরন: বিচার সেবা কেন্দ্র'},
    {'floor': '১ম তলা', 'title': 'মোঃ নাসির উদ্দীন (এডভোকেট), সরকারী কৌশুলী (জি.পি), জেলা ও দায়রা জজ আদালত, ঢাকা', 'sub': 'ধরন: জি.পি কার্যালয়'},
    {'floor': '১ম তলা', 'title': 'হিসাব রক্ষণ বিভাগ, জেলা জজ আদালত, ঢাকা', 'sub': 'ধরন: প্রশাসনিক শাখা দপ্তর'},
    {'floor': '২য় তলা', 'title': 'অতিরিক্ত জেলা ও দায়রা জজ, ৪র্থ আদালত, ঢাকা এবং বিশেষ ট্রাইব্যুনাল কোর্ট নং-৫, ঢাকা (কক্ষ নং- ২৫)', 'sub': 'ধরন: ফৌজদারি ও বিশেষ এজলাস'},
    {'floor': '২য় তলা', 'title': 'বিশেষ জজ আদালত নং-৬, ঢাকা', 'sub': 'ধরন: বিশেষ জজ আদালত'},
    {'floor': '২য় তলা', 'title': 'এজলাস, দ্রুত বিচার ট্রাইব্যুনাল নং-৪, ঢাকা', 'sub': 'ধরন: দ্রুত বিচার ট্রাইব্যুনাল এজলাস'},
    {'floor': '২য় তলা', 'title': 'জননিরাপত্তা বিঘ্নকারী অপরাধ দমন ট্রাইব্যুনাল, ঢাকা', 'sub': 'ধরন: বিশেষ ট্রাইব্যুনাল'},
    {'floor': '২য় তলা', 'title': 'এজলাস, পরিবেশ আদালত, ঢাকা (কক্ষ নং- ৩১)', 'sub': 'ধরন: পরিবেশ আদালত এজলাস'},
    {'floor': '২য় তলা', 'title': 'পারিবারিক আদালত-৫, ঢাকা / ই-পারিবারিক আদালত', 'sub': 'ধরন: পারিবারিক আদালত এজলাস'},
    {'floor': '৩য় তলা', 'title': 'যুগ্ম জেলা জজ ১ম আদালত, ঢাকা', 'sub': 'ধরন: দেওয়ানি আদালত সেরেস্তা'},
    {'floor': '৩য় তলা', 'title': 'যুগ্ম জেলা জজ ১ম আদালত ও বিশেষ ট্রাইব্যুনাল নং-১৫, ঢাকা', 'sub': 'ধরন: দেওয়ানি ও বিশেষ এজলাস'},
    {'floor': '৩য় তলা', 'title': 'যুগ্ম জেলা জজ ২য় আদালত, ঢাকা', 'sub': 'ধরন: দেওয়ানি আদালত সেরেস্তা'},
    {'floor': '৩য় তলা', 'title': 'যুগ্ম জেলা জজ ২য় আদালত ও যুগ্ম দায়রা জজ ২য় আদালত এবং বিশেষ ট্রাইব্যুনাল নং-৮, ঢাকা', 'sub': 'ধরন: দেওয়ানি, দায়রা ও বিশেষ এজলাস'},
    {'floor': '৩য় তলা', 'title': 'অতিরিক্ত জেলা ও দায়রা জজ ৩য় আদালত ও বিশেষ ট্রাইব্যুনাল নং-৪, ঢাকা', 'sub': 'ধরন: ফৌজদারি ও দায়রা এজলাস'},
    {'floor': '৩য় তলা', 'title': 'যুগ্ম জেলা ও দায়রা জজ ৪র্থ আদালত / আরবিট্রেশন আদালত ও বিশেষ ট্রাইব্যুনাল নং-২১, ঢাকা', 'sub': 'ধরন: দেওয়ানি, আর্বিট্রেশন ও ট্রাইব্যুনাল এজলাস'},
    {'floor': '৩য় তলা', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল নং-৪, ঢাকা', 'sub': 'ধরন: নারী ও শিশু ট্রাইব্যুনাল'},
    {'floor': '৪র্থ তলা', 'title': 'যুগ্ম জেলা জজ ৩য় আদালত, ঢাকা', 'sub': 'ধরন: দেওয়ানি আদালত সেরেস্তা'},
    {'floor': '৪র্থ তলা', 'title': 'যুগ্ম জেলা জজ ৩য় আদালত ও বিশেষ ট্রাইব্যুনাল নং-১৭, ঢাকা', 'sub': 'ধরন: দেওয়ানি ও বিশেষ এজলাস'},
    {'floor': '৪র্থ তলা', 'title': 'যুগ্ম জেলা জজ ৪র্থ আদালত, ঢাকা', 'sub': 'ধরন: দেওয়ানি আদালত সেরেস্তা'},
    {'floor': '৪র্থ তলা', 'title': 'যুগ্ম জেলা জজ ৫ম আদালত, ঢাকা', 'sub': 'ধরন: দেওয়ানি আদালত সেরেস্তা'},
    {'floor': '৪র্থ তলা', 'title': 'যুগ্ম জেলা জজ ৫ম আদালত ও বিশেষ ট্রাইব্যুনাল নং-১১, ঢাকা', 'sub': 'ধরন: দেওয়ানি ও বিশেষ এজলাস'},
    {'floor': '৪র্থ তলা', 'title': 'যুগ্ম জেলা জজ ও অর্থঋণ আদালত নং-২, ঢাকা', 'sub': 'ধরন: অর্থঋণ আদালত সেরেস্তা'},
    {'floor': '৪র্থ তলা', 'title': 'যুগ্ম জেলা জজ ও অর্থঋণ আদালত নং-২ ও বিশেষ ট্রাইব্যুনাল নং-১৮, ঢাকা', 'sub': 'ধরন: অর্থঋণ ও বিশেষ এজলাস'},
    {'floor': '৫ম তলা', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল নং-০২, ঢাকা', 'sub': 'ধরন: এজলাস ও সেরেস্তা'},
    {'floor': '৫ম তলা', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল-৩, ঢাকা ও শিশু আদালত-৩, ঢাকা', 'sub': 'ধরন: এজলাস ও সেরেস্তা'},
    {'floor': '৫ম তলা', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল নং-৮, ঢাকা', 'sub': 'ধরন: এজলাস ও সেরেস্তা'},
    {'floor': '৫ম তলা', 'title': 'যুগ্ম জেলা জজ ও অর্থঋণ আদালত নং-৩, ঢাকা', 'sub': 'ধরন: অর্থঋণ আদালত সেরেস্তা'},
    {'floor': '৫ম তলা', 'title': 'যুগ্ম জেলা জজ, অর্থঋণ আদালত নং-৩, ঢাকা', 'sub': 'ধরন: অর্থঋণ আদালত এজলাস'},
    {'floor': '৫ম তলা', 'title': 'ল্যান্ড সার্ভে ট্রাইব্যুনাল, ঢাকা মহানগর, ঢাকা (বিচারক)', 'sub': 'ধরন: ল্যান্ড সার্ভে এজলাস'},
    {'floor': '৫ম তলা', 'title': 'ল্যান্ড সার্ভে ট্রাইব্যুনাল, ঢাকা', 'sub': 'ধরন: ল্যান্ড সার্ভে সেরেস্তা'},
    {'floor': '৬ষ্ঠ তলা', 'title': '১ম অতিরিক্ত সিভিল জজ আদালত, ঢাকা', 'sub': 'ধরন: দেওয়ানি আদালত এজলাস'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল ও শিশু আদালত-৬, ঢাকা', 'sub': 'ধরন: এজলাস ও সেরেস্তা'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল-৭, ঢাকা', 'sub': 'ধরন: এজলাস ও সেরেস্তা'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'অর্থঋণ আদালত নং-৪, ঢাকা (এজলাস)', 'sub': 'ধরন: অর্থঋণ আদালত এজলাস'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'অর্থঋণ আদালত নং-৪, ঢাকা (সেরেস্তা)', 'sub': 'ধরন: অর্থঋণ আদালত সেরেস্তা'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'সাইবার ট্রাইব্যুনাল, ঢাকা (Cyber Tribunal, Dhaka) - সেরেস্তা', 'sub': 'ধরন: সাইবার ট্রাইব্যুনাল সেরেস্তা'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'সাইবার ট্রাইব্যুনাল, ঢাকা (Cyber Tribunal, Dhaka) - এজলাস', 'sub': 'ধরন: সাইবার ট্রাইব্যুনাল এজলাস'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCourts = selectedFloor == 'সব ফ্লোর'
        ? courtData
        : courtData.where((item) => item['floor'] == selectedFloor).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'জেলা ও দায়রা জজ আদালত (পুরাতন বিল্ডিং)',
          style: GoogleFonts.tiroBangla(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: const Color(0xFF031327),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: const BoxDecoration(color: Color(0xFF051E3C)),
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
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFFC29B38),
                      backgroundColor: const Color(0xFF031327),
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
          Expanded(
            child: filteredCourts.isEmpty
                ? const Center(child: Text('কোন তথ্য পাওয়া যায়নি', style: TextStyle(color: Colors.white)))
                : ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: filteredCourts.length,
                    itemBuilder: (context, index) {
                      final court = filteredCourts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: CyberBorderContainer(
                          borderColor: const Color(0xFF5CE1E6),
                          fillColor: const Color(0xFF051E3C),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC29B38),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    court['floor'],
                                    style: GoogleFonts.tiroBangla(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        court['title'],
                                        style: GoogleFonts.tiroBangla(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (court.containsKey('sub')) ...[
                                        const SizedBox(height: 6),
                                        Text(
                                          court['sub'],
                                          style: GoogleFonts.tiroBangla(
                                            fontSize: 12,
                                            color: Colors.white70,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
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

// ------------------- REBOTI MANSION SCREEN -------------------

class RebotiMansionScreen extends StatefulWidget {
  const RebotiMansionScreen({super.key});

  @override
  State<RebotiMansionScreen> createState() => _RebotiMansionScreenState();
}

class _RebotiMansionScreenState extends State<RebotiMansionScreen> {
  String selectedFloor = 'সব ফ্লোর';

  final List<String> floorList = [
    'সব ফ্লোর',
    'নিচ তলা',
    '২য় তলা',
    '৩য় তলা',
  ];

  final List<Map<String, dynamic>> courtData = [
    {'floor': 'নিচ তলা', 'title': 'বিচারপ্রার্থী নারী ও শিশু বিশ্রামাগার, ঢাকা', 'sub': 'বিভাগ / ধরন: বিশ্রামাগার ও সেবা (নাগরিক সেবা)'},
    {'floor': 'নিচ তলা', 'title': 'পাবলিক প্রসিকিউটর এর কার্যালয়, দুর্নীতি দমন কমিশন (দুদক)', 'sub': 'বিভাগ / ধরন: বিশেষায়িত কার্যালয় (দুদক প্রসিকিউশন)'},
    {'floor': 'নিচ তলা', 'title': 'পিপি অফিস (পাবলিক প্রসিকিউটর অফিস), ঢাকা', 'sub': 'বিভাগ / ধরন: সরকারি কার্যালয় (জেলা প্রসিকিউশন)'},
    {'floor': 'নিচ তলা', 'title': 'মেট্রোপলিটন পাবলিক প্রসিকিউটর (পি.পি) কার্যালয়, ঢাকা', 'sub': 'বিভাগ / ধরন: সরকারি কার্যালয় (মহানগর প্রসিকিউশন)'},
    {'floor': '২য় তলা', 'title': 'সিনিয়র সিভিল জজ আদালত, সাভার, ঢাকা', 'sub': 'বিভাগ / অবস্থান: এজলাস ও সেরেস্তা (এজলাস + সেরেস্তা)'},
    {'floor': '২য় তলা', 'title': 'বিশেষ জজ আদালত নং-৮, ঢাকা', 'sub': 'বিভাগ / অবস্থান: এজলাস ও সেরেস্তা (এজলাস + সেরেস্তা)'},
    {'floor': '২য় তলা', 'title': 'বিশেষ জজ আদালত নং-০৯, ঢাকা', 'sub': 'বিভাগ / অবস্থান: এজলাস ও সেরেস্তা (এজলাস + সেরেস্তা)'},
    {'floor': '২য় তলা', 'title': 'বিশেষ জজ আদালত নং-১০, ঢাকা', 'sub': 'বিভাগ / অবস্থান: এজলাস ও সেরেস্তা (এজলাস + সেরেস্তা)'},
    {'floor': '৩য় তলা', 'title': 'বিশেষ জজ আদালত নং-৭, ঢাকা', 'sub': 'বিভাগ / অবস্থান: এজলাস ও সেরেস্তা (এজলাস + সেরেস্তা)'},
    {'floor': '৩য় তলা', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল-১, ঢাকা', 'sub': 'বিভাগ / অবস্থান: ট্রাইব্যুনাল এজলাস (বিচারিক এজলাস)'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCourts = selectedFloor == 'সব ফ্লোর'
        ? courtData
        : courtData.where((item) => item['floor'] == selectedFloor).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'রেবতী ম্যানশন (জেলা ও দায়রা জজ আদালত)',
          style: GoogleFonts.tiroBangla(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: const Color(0xFF031327),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: const BoxDecoration(color: Color(0xFF051E3C)),
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
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFFC29B38),
                      backgroundColor: const Color(0xFF031327),
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
          Expanded(
            child: filteredCourts.isEmpty
                ? const Center(child: Text('কোন তথ্য পাওয়া যায়নি', style: TextStyle(color: Colors.white)))
                : ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: filteredCourts.length,
                    itemBuilder: (context, index) {
                      final court = filteredCourts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: CyberBorderContainer(
                          borderColor: const Color(0xFF5CE1E6),
                          fillColor: const Color(0xFF051E3C),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC29B38),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    court['floor'],
                                    style: GoogleFonts.tiroBangla(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        court['title'],
                                        style: GoogleFonts.tiroBangla(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (court.containsKey('sub')) ...[
                                        const SizedBox(height: 6),
                                        Text(
                                          court['sub'],
                                          style: GoogleFonts.tiroBangla(
                                            fontSize: 12,
                                            color: Colors.white70,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
    {'floor': '৬ষ্ঠ তলা', 'title': 'বিশেষ জজ আদালত নং- ১, ঢাকা।'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'বিশেষ জজ আদালত নং- ২, ঢাকা।'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'বিশেষ জজ আদালত নং- ৩, ঢাকা।'},
    {'floor': '৬ষ্ঠ তলা', 'title': 'বিশেষ জজ আদালত নং- ৪, ঢাকা।'},
    {'floor': '৫ম তলা', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল নং- ৫, ঢাকা।'},
    {'floor': '৫ম তলা', 'title': 'বিশেষ জজ আদালত নং- ৫, ঢাকা।'},
    {'floor': '৫ম তলা', 'title': 'দ্রুত বিচার ট্রাইব্যুনাল নং- ৩, ঢাকা।'},
    {'floor': '৫ম তলা', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ৮মে আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৬, ঢাকা'},
    {'floor': '৫ম তলা', 'title': 'পরিবেশ আপীল আদালত, ঢাকা।'},
    {'floor': '৪র্থ তলা', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ৫মে আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৬, ঢাকা'},
    {'floor': '৪র্থ তলা', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ৭ম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৫, ঢাকা'},
    {'floor': '৪র্থ তলা', 'title': 'যুগ্ম মহানগর দায়রা জজ ১ম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১১, ঢাকা'},
    {'floor': '৪র্থ তলা', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ৬ষ্ঠ আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৪, ঢাকা'},
    {'floor': '৪র্থ তলা', 'title': 'যুগ্ম মহানগর দায়রা জজ ৫ম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১০, ঢাকা'},
    {'floor': '৩য় তলা', 'title': 'বিভাগীয় স্পেশাল জজ আদালত, ঢাকা।'},
    {'floor': '৩য় তলা', 'title': 'দ্রুত বিচার ট্রাইব্যুনাল নং- ১, ঢাকা।'},
    {'floor': '৩য় তলা', 'title': 'অনুলিপি শাখা, মহানগর দায়রা জজ আদালত, ঢাকা।'},
    {'floor': '৩য় তলা', 'title': 'যুগ্ম মহানগর দায়রা জজ ৪র্থ আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৯, ঢাকা'},
    {'floor': '৩য় তলা', 'title': 'দ্রুত বিচার ট্রাইব্যুনাল নং- ২, ঢাকা।'},
    {'floor': '২য় তলা', 'title': 'মহানগর দায়রা জজ আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১, ঢাকা'},
    {'floor': '২য় তলা', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ১ম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২, ঢাকা'},
    {'floor': '২য় তলা', 'title': 'নেজারত ও সেরেস্তা এবং প্রশাসনিক কর্মকর্তা মহানগর দায়রা জজ।'},
    {'floor': '২য় তলা', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ৪র্থ আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৫, ঢাকা'},
    {'floor': '২য় তলা', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ৩য় আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৪, ঢাকা'},
    {'floor': '২য় তলা', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ২য় আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৩, ঢাকা'},
    {'floor': 'নীচ তলা', 'title': 'যুগ্ম মহানগর দায়রা জজ ২য় আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৭, ঢাকা'},
    {'floor': 'নীচ তলা', 'title': 'যুগ্ম মহানগর দায়রা জজ ৬ষ্ঠ আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১২, ঢাকা'},
    {'floor': 'নীচ তলা', 'title': 'যুগ্ম মহানগর দায়রা জজ ৩য় আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ৮, ঢাকা'},
    {'floor': 'নীচ তলা', 'title': 'যুগ্ম মহানগর দায়রা জজ ৭ম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৩, ঢাকা'},
    {'floor': 'টিন শেড', 'title': 'মানব পাচার ট্রাইব্যুনাল, ঢাকা।'},
    {'floor': 'টিন শেড', 'title': 'নারী ও শিশু নির্যাতন দমন ট্রাইব্যুনাল নং- ৯, ঢাকা।'},
    {'floor': 'টিন শেড', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ৯ম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৭, ঢাকা'},
    {'floor': 'টিন শেড', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ১০ম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৮, ঢাকা'},
    {'floor': 'টিন শেড', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ১১ তম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ১৯, ঢাকা'},
    {'floor': 'টিন শেড', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ১২ তম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২০, ঢাকা'},
    {'floor': 'টিন শেড', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ১৩তম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২১, ঢাকা'},
    {'floor': 'টিন শেড', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ১৪ তম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২২, ঢাকা'},
    {'floor': 'টিন শেড', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ১৫ তম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২৩, ঢাকা'},
    {'floor': 'টিন শেড', 'title': 'অতিরিক্ত মহানগর দায়রা জজ ১৬ তম আদালত, ঢাকা', 'sub': 'মেট্রো বিশেষ ট্রাইব্যুনাল নং- ২৪, ঢাকা'},
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
        backgroundColor: const Color(0xFF031327),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: const BoxDecoration(color: Color(0xFF051E3C)),
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
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFFC29B38),
                      backgroundColor: const Color(0xFF031327),
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
          Expanded(
            child: filteredCourts.isEmpty
                ? const Center(child: Text('কোন তথ্য পাওয়া যায়নি', style: TextStyle(color: Colors.white)))
                : ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: filteredCourts.length,
                    itemBuilder: (context, index) {
                      final court = filteredCourts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: CyberBorderContainer(
                          borderColor: const Color(0xFF5CE1E6),
                          fillColor: const Color(0xFF051E3C),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: court['floor'] == 'টিন শেড'
                                        ? Colors.orange.shade800
                                        : const Color(0xFFC29B38),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    court['floor'],
                                    style: GoogleFonts.tiroBangla(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        court['title'],
                                        style: GoogleFonts.tiroBangla(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (court.containsKey('sub')) ...[
                                        const SizedBox(height: 6),
                                        Text(
                                          court['sub'],
                                          style: GoogleFonts.tiroBangla(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
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

// ------------------- DETAILS SCREEN -------------------

class CourtDetailsScreen extends StatelessWidget {
  final String courtName;

  const CourtDetailsScreen({super.key, required this.courtName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courtName, style: GoogleFonts.tiroBangla(color: Colors.white, fontSize: 16)),
        backgroundColor: const Color(0xFF031327),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 80, color: Color(0xFFC29B38)),
            const SizedBox(height: 20),
            Text(
              courtName,
              textAlign: TextAlign.center,
              style: GoogleFonts.tiroBangla(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            CyberBorderContainer(
              borderColor: const Color(0xFF5CE1E6),
              fillColor: const Color(0xFF051E3C),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'এই বিল্ডিংয়ের রুম এবং তলা সংক্রান্ত বিস্তারিত ডাটা শীঘ্রই যুক্ত করা হবে।',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(0xDDFFFFFF), height: 1.5),
                ),
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
          "text": "ত্রুটি ঘটেছে: Gemini API Key পাওয়া যায়নি।"
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
          'তুমি বিপ্লব ঢাকা কোর্ট (Biplob Dhaka Court) অ্যাপের একজন পেশাদার বাংলা আইনি সহকারী। সংক্ষেপে উত্তর দাও: $text',
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
        _messages.add({"role": "ai", "text": "ত্রুটি ঘটেছে: $e"});
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
        backgroundColor: const Color(0xFF031327),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
               return SizedBox(); // অথবা আপনার কাঙ্ক্ষিত উইজেট
              }
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: LinearProgressIndicator(color: Color(0xFF5CE1E6)),
            ),
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF051E3C),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promptController,
                    style: const TextStyle(color: Colors.white),
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: 'আইন বা কোর্ট বিষয়ক যেকোনো প্রশ্ন লিখুন...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF5CE1E6)),
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
