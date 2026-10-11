// ไฟล์: lib/screens/knowledge_screen.dart
import 'package:flutter/material.dart';

import '../data/translations.dart';
import '../models/app_language.dart';
import 'knowledge_detail_screen.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  static const Color primaryGreen = Color(0xFF1B5E20);
  static const Color lightGreen = Color(0xFF2E7D32);
  static const Color bgColor = Color(0xFFEBEBEB);
  static const Color riceGold = Color(0xFFD4AF37);

  Widget _buildStepItem(
    BuildContext context,
    String number,
    IconData icon,
    String title,
    String desc,
    String fullDescKey,
    String lang,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KnowledgeDetailScreen(
              title: title,
              icon: icon,
              fullDescKey: fullDescKey,
            ),
          ),
        );
      },
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    // ข้อมูลหัวข้อทั้ง 9 ข้อ ผูกกับ Icon
    final List<Map<String, dynamic>> gapData = [
      {'icon': Icons.map, 'key': 'gap1'},
      {'icon': Icons.agriculture, 'key': 'gap2'},
      {'icon': Icons.eco, 'key': 'gap3'},
      {'icon': Icons.content_cut, 'key': 'gap4'},
      {'icon': Icons.fact_check, 'key': 'gap5'},
      {'icon': Icons.hardware, 'key': 'gap6'},
      {'icon': Icons.wb_sunny, 'key': 'gap7'},
      {'icon': Icons.water_drop, 'key': 'gap8'},
      {'icon': Icons.warehouse, 'key': 'gap9'},
    ];

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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ส่วนหัวข้อหลัก
                  Text(
                    T.get('knowledgeHeader', lang),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: primaryGreen,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // กล่องสรุป 3 หลักสำคัญ
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: riceGold, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8),
                      ],
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
                  const SizedBox(height: 25),

                  // วนลูปสร้างรายการ 9 ข้อ
                  ...List.generate(gapData.length, (index) {
                    final item = gapData[index];
                    final keyPrefix = item['key'];
                    return _buildStepItem(
                      context,
                      '${index + 1}',
                      item['icon'],
                      T.get('${keyPrefix}Title', lang),
                      T.get('${keyPrefix}Desc', lang),
                      '${keyPrefix}Full',
                      lang,
                    );
                  }),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
