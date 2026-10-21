// ไฟล์: lib/screens/knowledge_detail_screen.dart
import 'package:flutter/material.dart';

import '../data/translations.dart';
import '../models/app_language.dart';

class KnowledgeDetailScreen extends StatelessWidget {
  final String
      titleKey; // คีย์ของหัวข้อ แปลในหน้านี้เอง เพื่อให้เปลี่ยนภาษาได้ทันที
  final IconData icon;
  final String fullDescKey;

  const KnowledgeDetailScreen({
    super.key,
    required this.titleKey,
    required this.icon,
    required this.fullDescKey,
  });

  static const Color primaryGreen = Color(0xFF1B5E20);
  static const Color creamBackground = Color(0xFFF8F4E9);

  static const List<BoxShadow> _badgeShadow = [
    BoxShadow(
      color: Color(0x1A000000), // ดำ 10%
      blurRadius: 10,
      offset: Offset(0, 5),
    ),
  ];

  Widget _buildIconBadge() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: _badgeShadow,
      ),
      child: Icon(icon, size: 55, color: primaryGreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamBackground,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        // ฟังเฉพาะข้อความที่ต้องเปลี่ยนภาษา ไม่ต้องรีบิลด์ทั้งหน้า
        title: ValueListenableBuilder<LanguageCode>(
          valueListenable: AppLanguage.current,
          builder: (context, language, _) {
            return Text(
              T.get('detailsTitle', AppLanguage.code),
              style: const TextStyle(fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildIconBadge(),
              const SizedBox(height: 24),
              ValueListenableBuilder<LanguageCode>(
                valueListenable: AppLanguage.current,
                builder: (context, language, _) {
                  return Text(
                    T.get(titleKey, AppLanguage.code),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0x80D4AF37)),
                ),
                child: ValueListenableBuilder<LanguageCode>(
                  valueListenable: AppLanguage.current,
                  builder: (context, language, _) {
                    return Text(
                      T.get(fullDescKey, AppLanguage.code),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        color: Color(0xFF4E4E4E),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
