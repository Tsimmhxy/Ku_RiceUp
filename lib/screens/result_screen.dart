// ไฟล์: lib/screens/result_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';

import '../data/rice_information.dart';
import '../data/translations.dart';
import '../models/app_language.dart';
import '../models/history_model.dart';
import '../services/classifier.dart';

class ResultScreen extends StatefulWidget {
  final File image;

  const ResultScreen({
    super.key,
    required this.image,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String prediction = '';
  double confidence = 0.0;
  bool isLoading = true;
  bool hasError = false;

  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color riceGold = Color(0xFFD4AF37);
  static const Color creamBackground = Color(0xFFF8F4E9);
  static const Color cardColor = Color(0xFFFFFCF4);

  @override
  void initState() {
    super.initState();
    runClassification();
  }

  // ไม่ต้อง close() classifier เพราะใช้ร่วมกันทั้งแอป (singleton)

  Future<void> runClassification() async {
    try {
      final result = await Classifier.instance.classifyImage(widget.image);

      if (!mounted) return;

      setState(() {
        prediction = result.label;
        confidence = result.confidence;
        isLoading = false;
      });

      // ไม่ต้อง await: บันทึกประวัติเบื้องหลัง
      HistoryManager.addHistory(HistoryItem(
        image: widget.image,
        variety: prediction,
        confidence: confidence,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (!mounted) return;
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  String getConfidenceLevel(String lang) {
    if (confidence >= 90) return T.get('veryHigh', lang);
    if (confidence >= 80) return T.get('high', lang);
    if (confidence >= 70) return T.get('medium', lang);
    return T.get('retake', lang);
  }

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

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 70, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text(
            AppLanguage.isEnglish
                ? 'Unable to analyze this image.\nPlease try another photo.'
                : 'ไม่สามารถวิเคราะห์รูปภาพนี้ได้\nกรุณาลองถ่ายหรือเลือกรูปใหม่',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, height: 1.5),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back),
            label: Text(AppLanguage.isEnglish ? 'Back' : 'กลับ'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LanguageCode>(
      valueListenable: AppLanguage.current,
      builder: (context, language, _) {
        final lang = AppLanguage.code;
        final showResult = !isLoading && !hasError;

        final displayPrediction = showResult
            ? RiceInformation.name(prediction, lang)
            : T.get('analyzing', lang);
        final description =
            showResult ? RiceInformation.description(prediction, lang) : '';

        return Scaffold(
          backgroundColor: creamBackground,
          appBar: AppBar(
            title: Text(
              T.get('resultTitle', lang),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            actions: [buildLanguageButton()],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 20),
                        Text(
                          T.get('analyzingRice', lang),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : hasError
                    ? buildError()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: riceGold,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.file(
                                  widget.image,
                                  height: 260,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  cacheWidth: 1000,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Text(
                              T.get('resultHeader', lang),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: primaryGreen,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: riceGold,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    T.get('detectedVariety', lang),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    displayPrediction,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: primaryGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    T.get('confidence', lang),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${confidence.toStringAsFixed(2)}%',
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: primaryGreen,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  LinearProgressIndicator(
                                    value: confidence.clamp(0, 100) / 100,
                                    minHeight: 12,
                                    borderRadius: BorderRadius.circular(10),
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor: const AlwaysStoppedAnimation(
                                      primaryGreen,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    '${T.get('confidenceLevel', lang)} : ${getConfidenceLevel(lang)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: riceGold,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    T.get('varietyDetail', lang),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    description,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 58,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.refresh),
                                label: Text(
                                  T.get('classifyAgain', lang),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryGreen,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.popUntil(
                                    context,
                                    (route) => route.isFirst,
                                  );
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
