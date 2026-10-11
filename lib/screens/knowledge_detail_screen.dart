// ไฟล์: lib/screens/knowledge_detail_screen.dart
import 'package:flutter/material.dart';

import '../data/translations.dart';
import '../models/app_language.dart';

class KnowledgeDetailScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String fullDescKey;

  const KnowledgeDetailScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.fullDescKey,
  });

  static const Color primaryGreen = Color(0xFF1B5E20);
  static const Color creamBackground = Color(0xFFF8F4E9);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LanguageCode>(
      valueListenable: AppLanguage.current,
      builder: (context, language, _) {
        final lang = AppLanguage.code;

        return Scaffold(
          backgroundColor: creamBackground,
          appBar: AppBar(
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            title: const Text('รายละเอียด',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            // อนุญาตให้เลื่อนลงได้เมื่อข้อความยาว
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(icon, size: 55, color: primaryGreen),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: const Color(0xFFD4AF37).withOpacity(0.5)),
                    ),
                    child: Text(
                      T.get(fullDescKey, lang),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.8, // เพิ่มระยะห่างบรรทัดให้อ่านง่าย
                        color: Color(0xFF4E4E4E),
                      ),
                    ),
                  ),
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
