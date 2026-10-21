// ไฟล์: lib/screens/main_screen.dart
import 'package:flutter/material.dart';

import '../data/translations.dart';
import '../models/app_language.dart';
import '../services/classifier.dart';
import 'history_screen.dart';
import 'home_screen.dart';
import 'knowledge_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const Color primaryGreen = Color(0xFF1B5E20);

  final List<Widget> _pages = const [
    HomeScreen(),
    HistoryScreen(),
    KnowledgeScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // โหลดโมเดลรอไว้ล่วงหน้า (ไม่ต้อง await) เข้าหน้าผลลัพธ์แล้วไม่ต้องรอโหลด
    Classifier.instance.loadModel().catchError((_) {});
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LanguageCode>(
      valueListenable: AppLanguage.current,
      builder: (context, language, _) {
        final lang = AppLanguage.code;

        return Scaffold(
          // IndexedStack เก็บสถานะของแต่ละแท็บไว้ ไม่สร้างหน้าใหม่ทุกครั้งที่สลับ
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: const Color(0xFFF2F2F2),
              selectedItemColor: primaryGreen,
              unselectedItemColor: Colors.grey.shade600,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  activeIcon: const Icon(Icons.home),
                  label: T.get('navHome', lang),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.pie_chart_outline),
                  activeIcon: const Icon(Icons.pie_chart),
                  label: T.get('navHistory', lang),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.book_outlined),
                  activeIcon: const Icon(Icons.book),
                  label: T.get('navKnowledge', lang),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
