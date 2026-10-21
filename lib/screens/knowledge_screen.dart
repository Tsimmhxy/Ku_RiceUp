// ไฟล์: lib/screens/knowledge_screen.dart
import 'package:flutter/material.dart';

import '../data/translations.dart';
import '../models/app_language.dart';
import 'knowledge_detail_screen.dart';

class _GapItem {
  final IconData icon;
  final String key;
  const _GapItem(this.icon, this.key);
}

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  static const Color primaryGreen = Color(0xFF1B5E20);
  static const Color lightGreen = Color(0xFF2E7D32);
  static const Color bgColor = Color(0xFFEBEBEB);
  static const Color riceGold = Color(0xFFD4AF37);

  // หัวข้อทั้ง 9 ข้อ ผูกกับ Icon (const ไม่สร้างใหม่ทุกครั้งที่ build)
  static const List<_GapItem> _items = [
    _GapItem(Icons.map, 'gap1'),
    _GapItem(Icons.agriculture, 'gap2'),
    _GapItem(Icons.eco, 'gap3'),
    _GapItem(Icons.content_cut, 'gap4'),
    _GapItem(Icons.fact_check, 'gap5'),
    _GapItem(Icons.hardware, 'gap6'),
    _GapItem(Icons.wb_sunny, 'gap7'),
    _GapItem(Icons.water_drop, 'gap8'),
    _GapItem(Icons.warehouse, 'gap9'),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LanguageCode>(
      valueListenable: AppLanguage.current,
      builder: (context, language, _) {
        final lang = AppLanguage.code;

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: primaryGreen,
            elevation: 0,
            title: Text(T.get('navKnowledge', lang),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          // ใช้ ListView.builder สร้างเฉพาะรายการที่มองเห็น
          // index 0 = หัวข้อ, 1 = กล่องสรุป, 2..n = รายการ, สุดท้าย = ช่องว่าง
          body: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: _items.length + 3,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    T.get('knowledgeHeader', lang),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: primaryGreen,
                      height: 1.4,
                    ),
                  ),
                );
              }

              if (index == 1) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: riceGold, width: 1.5),
                    ),
                    child: Text(
                      T.get('corePrinciples', lang),
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                );
              }

              if (index == _items.length + 2) {
                return const SizedBox(height: 30);
              }

              final itemIndex = index - 2;
              final item = _items[itemIndex];

              return _StepItem(
                number: '${itemIndex + 1}',
                icon: item.icon,
                titleKey: '${item.key}Title',
                title: T.get('${item.key}Title', lang),
                desc: T.get('${item.key}Desc', lang),
                fullDescKey: '${item.key}Full',
              );
            },
          ),
        );
      },
    );
  }
}

class _StepItem extends StatelessWidget {
  final String number;
  final IconData icon;
  final String titleKey;
  final String title;
  final String desc;
  final String fullDescKey;

  const _StepItem({
    required this.number,
    required this.icon,
    required this.titleKey,
    required this.title,
    required this.desc,
    required this.fullDescKey,
  });

  static const Color primaryGreen = Color(0xFF1B5E20);
  static const Color lightGreen = Color(0xFF2E7D32);

  // แยกเป็น const เพื่อไม่ต้องคำนวณ withOpacity ทุกครั้งที่ build
  static const List<BoxShadow> _badgeShadow = [
    BoxShadow(
      color: Color(0x0D000000), // ดำ 5%
      blurRadius: 5,
      offset: Offset(0, 3),
    ),
  ];

  void _open(BuildContext context) {
    Navigator.push(
      context,
      // เปลี่ยนหน้าทันที ไม่มีแอนิเมชัน จึงไม่มีช่วงที่สองหน้าซ้อนกัน (ทั้งตอนเข้าและตอนกลับ)
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => KnowledgeDetailScreen(
          titleKey: titleKey,
          icon: icon,
          fullDescKey: fullDescKey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // RepaintBoundary แยกชั้นวาดของแต่ละรายการ เวลาเปลี่ยนหน้า/เลื่อน
    // จะไม่ต้องวาดเงาใหม่ทุกรายการ
    return RepaintBoundary(
      child: InkWell(
        onTap: () => _open(context),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: _badgeShadow,
                    ),
                    child: Icon(icon, color: lightGreen, size: 26),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    number,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: lightGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Icon(Icons.chevron_right, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
