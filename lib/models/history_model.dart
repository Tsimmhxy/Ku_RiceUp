// ไฟล์: lib/models/history_model.dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
  static const int maxItems = 100;

  // ใช้ ValueNotifier เพื่อให้หน้าจออัปเดตอัตโนมัติเมื่อมีประวัติใหม่
  static final ValueNotifier<List<HistoryItem>> historyList = ValueNotifier([]);

  // ใช้กันบันทึกซ้ำ (รูปเดิม ภายในเวลาใกล้กัน)
  static String? _lastSourcePath;
  static DateTime? _lastTime;

  static Future<void> addHistory(HistoryItem item) async {
    final sourcePath = item.image.path;

    if (_lastSourcePath == sourcePath &&
        _lastTime != null &&
        item.timestamp.difference(_lastTime!).inSeconds.abs() < 5) {
      return;
    }
    // ตั้งค่าก่อน await เพื่อกันเรียกซ้อนกัน
    _lastSourcePath = sourcePath;
    _lastTime = item.timestamp;

    File savedImage = item.image;
    try {
      // คัดลอกรูปมาเก็บถาวร เพราะไฟล์ชั่วคราวของ image_picker อาจถูกระบบลบ
      final dir = await getApplicationDocumentsDirectory();
      savedImage = await item.image.copy(p.join(
        dir.path,
        'history_${item.timestamp.millisecondsSinceEpoch}'
        '${p.extension(sourcePath)}',
      ));
    } catch (_) {
      // ถ้าคัดลอกไม่สำเร็จ ใช้ไฟล์เดิมต่อไป
    }

    final newItem = HistoryItem(
      image: savedImage,
      variety: item.variety,
      confidence: item.confidence,
      timestamp: item.timestamp,
    );

    // เพิ่มประวัติใหม่ไว้บนสุด และจำกัดจำนวน
    historyList.value = [newItem, ...historyList.value].take(maxItems).toList();
  }
}
