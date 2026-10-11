import 'dart:io';

import 'package:flutter/material.dart';

import '../data/translations.dart';
import '../models/app_language.dart';
import 'result_screen.dart';

class PreviewScreen extends StatelessWidget {
  final File image;

  const PreviewScreen({
    super.key,
    required this.image,
  });

  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color riceGold = Color(0xFFD4AF37);
  static const Color creamBackground = Color(0xFFF8F4E9);
  static const Color cardColor = Color(0xFFFFFCF4);

  Widget buildLanguageButton() {
    return TextButton.icon(
      onPressed: AppLanguage.toggle,
      icon: const Icon(Icons.language, color: Colors.white),
      label: Text(
        AppLanguage.isEnglish ? 'TH' : 'EN',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
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
          backgroundColor: creamBackground,
          appBar: AppBar(
            title: Text(
              T.get('previewTitle', lang),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            actions: [buildLanguageButton()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Text(
                    T.get('selectedImage', lang),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: riceGold,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: riceGold.withOpacity(0.6),
                      ),
                    ),
                    child: Text(
                      T.get('previewTip', lang),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Color(0xFF555555),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.auto_awesome, size: 24),
                      label: Text(
                        T.get('startClassify', lang),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ResultScreen(
                              image: image,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: Text(
                        T.get('chooseAgain', lang),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryGreen,
                        side: const BorderSide(
                          color: primaryGreen,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
