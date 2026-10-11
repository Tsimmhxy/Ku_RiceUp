// ไฟล์: lib/models/history_model.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class HistoryItem {
  final File image;
  final String variety;
  final double confidence;
  final DateTime timestamp;

  HistoryItem({
    required this.image,
    required this.variety,
    required this.confidence,
    required this.timestamp,
  });
}

class HistoryManager {
  // ใช้ ValueNotifier เพื่อให้หน้าจออัปเดตอัตโนมัติเมื่อมีประวัติใหม่
  static final ValueNotifier<List<HistoryItem>> historyList = ValueNotifier([]);

  static void addHistory(HistoryItem item) {
    // เพิ่มประวัติใหม่ไว้บนสุด
    historyList.value = [item, ...historyList.value];
  }
}
