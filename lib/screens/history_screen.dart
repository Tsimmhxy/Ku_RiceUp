// ไฟล์: lib/screens/history_screen.dart
import 'package:flutter/material.dart';

import '../data/rice_information.dart';
import '../data/translations.dart';
import '../models/app_language.dart';
import '../models/history_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const Color primaryGreen = Color(0xFF1B5E20);

  // ฟังก์ชันแปลงเวลาแบบง่ายๆ
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year + 543} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LanguageCode>(
      valueListenable: AppLanguage.current,
      builder: (context, language, _) {
        final lang = AppLanguage.code;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F4E9),
          appBar: AppBar(
            title: Text(T.get('historyTitle', lang),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
          ),
          body: ValueListenableBuilder<List<HistoryItem>>(
            valueListenable: HistoryManager.historyList,
            builder: (context, history, _) {
              if (history.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history,
                          size: 80, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        T.get('historyEmpty', lang),
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final item = history[index];
                  final displayName = RiceInformation.name(item.variety, lang);

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              item.image,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                              cacheWidth:
                                  200, // thumbnail ไม่ต้อง decode เต็มขนาด
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 70,
                                  height: 70,
                                  color: Colors.grey.shade300,
                                  child: Icon(Icons.broken_image,
                                      color: Colors.grey.shade500),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayName,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryGreen),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${T.get('confidence', lang)}: ${item.confidence.toStringAsFixed(1)}%',
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatDate(item.timestamp),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
