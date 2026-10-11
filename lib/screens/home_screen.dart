// ไฟล์: lib/screens/home_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/translations.dart';
import '../models/app_language.dart';
import 'preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker picker = ImagePicker();

  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color darkGreen = Color(0xFF1B5E20);
  static const Color riceGold = Color(0xFFD4AF37);
  static const Color cardColor = Color(0xFFFDF9EE);

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image == null) return;
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          image: File(image.path),
        ),
      ),
    );
  }

  Widget buildLanguageButton() {
    return Container(
      margin: const EdgeInsets.only(right: 16, top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: AppLanguage.toggle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, color: Colors.white, size: 20),
            const SizedBox(width: 6),
            Text(
              AppLanguage.isEnglish ? 'TH' : 'EN',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActionButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    bool isOutlined = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: isOutlined
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 24, color: darkGreen),
              label: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: darkGreen, width: 2),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 24, color: Colors.white),
              label: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LanguageCode>(
      valueListenable: AppLanguage.current,
      builder: (context, language, _) {
        final lang = AppLanguage.code;

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [buildLanguageButton()],
          ),
          body: Stack(
            children: [
              // 1. พื้นหลังสีเขียว Gradient
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF388E3C), Color(0xFF1B5E20)],
                  ),
                ),
              ),

              // 2. ลูกเล่นกราฟิกวงกลมสีอ่อนบนพื้นหลัง
              Positioned(
                top: -80,
                left: -60,
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                right: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.04),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                left: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.03),
                  ),
                ),
              ),

              // 3. กราฟิกตกแต่งรวงข้าวซ้ายบน
              Positioned(
                top: -8,
                left: -8,
                child: Image.asset(
                  'assets/images/ruang_rice.png',
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),

              // 4. เนื้อหาหลัก
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // ส่วนโลโก้และข้อความ
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ขยายขนาดโลโก้ข้าว
                              Image.asset(
                                'assets/images/rice.png',
                                height: 95, // เดิม 75 ปรับให้ใหญ่ขึ้น
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.grass,
                                        size: 50, color: Colors.white),
                                  );
                                },
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ขยายฟอนต์และเพิ่มเงา
                                  Text(
                                    'KU',
                                    style: TextStyle(
                                      fontSize: 48, // เดิม 40
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      height: 1.0,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(0, 3),
                                          blurRadius: 6.0,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // ขยายฟอนต์และเพิ่มเงา
                                  Text(
                                    'RiceUp',
                                    style: TextStyle(
                                      fontSize: 36, // เดิม 30
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      height: 1.1,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(0, 3),
                                          blurRadius: 6.0,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 24), // เพิ่มระยะห่างให้โลโก้ดูเด่นขึ้น

                          // ข้อความ Subtitle พร้อมเส้นแสงข้างใต้
                          Column(
                            children: [
                              Text(
                                T.get('homeSubtitle', lang),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 250,
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.0),
                                      riceGold, // สีเส้นขีดทอง
                                      Colors.white.withOpacity(0.0),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ส่วนแผงควบคุมด้านล่าง (สีขาวขอบมน)
                    Expanded(
                      flex: 6,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        // ใช้ ClipRRect เพื่อไม่ให้รูปรวงข้าวล้นขอบโค้งสีขาวออกมา
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Stack(
                            children: [
                              // 1. รวงข้าวฝั่งซ้าย (rice_left.png)
                              Positioned(
                                top: 10,
                                left: -40,
                                child: Opacity(
                                  opacity: 0.7,
                                  child: Image.asset(
                                    'assets/images/rice_left.png',
                                    width: 220,
                                  ),
                                ),
                              ),

                              // 2. รวงข้าวฝั่งขวา (rice_right.png)
                              Positioned(
                                top: 0,
                                right: -40,
                                child: Opacity(
                                  opacity: 0.7,
                                  child: Image.asset(
                                    'assets/images/rice_right.png',
                                    width: 250,
                                  ),
                                ),
                              ),

                              // 3. เนื้อหาปุ่มต่างๆ
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 40),
                                child: Column(
                                  children: [
                                    buildActionButton(
                                      icon: Icons.camera_alt,
                                      text: T.get('camera', lang),
                                      onPressed: () =>
                                          pickImage(ImageSource.camera),
                                    ),
                                    const SizedBox(height: 16),
                                    buildActionButton(
                                      icon: Icons.photo_library,
                                      text: T.get('gallery', lang),
                                      onPressed: () =>
                                          pickImage(ImageSource.gallery),
                                      isOutlined: true,
                                    ),
                                    const Spacer(),

                                    // กล่องคำแนะนำ
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: cardColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Icon(Icons.lightbulb,
                                                color: riceGold, size: 22),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              T.get('homeTip', lang),
                                              style: TextStyle(
                                                fontSize: 13,
                                                height: 1.5,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
