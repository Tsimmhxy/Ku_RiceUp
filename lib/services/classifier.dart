// ไฟล์: lib/services/classifier.dart
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class ClassificationResult {
  final String label;
  final double confidence; // เปอร์เซ็นต์ 0-100
  final List<double> scores;

  const ClassificationResult(this.label, this.confidence, this.scores);
}

// ต้องเป็น top-level function เพื่อใช้กับ compute() (รันใน isolate แยก ไม่บล็อก UI)
Float32List _preprocess(List<Object> args) {
  final path = args[0] as String;
  final w = args[1] as int;
  final h = args[2] as int;

  var image = img.decodeImage(File(path).readAsBytesSync());
  if (image == null) {
    throw const FormatException('ไม่สามารถอ่านรูปภาพได้');
  }

  // แก้ภาพจากมือถือที่อาจหมุนผิดทิศทาง
  image = img.bakeOrientation(image);

  // ใช้ linear (bilinear) ให้ใกล้เคียงกับตอนเทรนด้วย image_dataset_from_directory
  image = img.copyResize(
    image,
    width: w,
    height: h,
    interpolation: img.Interpolation.linear,
  );

  // โมเดล Custom CNN มี Rescaling(1/255) อยู่ในตัวแล้ว จึงส่งค่า 0-255 ตรงๆ (ห้ามหาร 255 ซ้ำ)
  final out = Float32List(w * h * 3);
  var i = 0;
  for (final p in image) {
    out[i++] = p.r.toDouble();
    out[i++] = p.g.toDouble();
    out[i++] = p.b.toDouble();
  }
  return out;
}

class Classifier {
  Classifier._();
  static final Classifier instance = Classifier._();

  // ลำดับต้องตรงกับ train_ds.class_names ตอนเทรนเป๊ะๆ
  static const List<String> _labels = [
    'กข6',
    'ขี้ตมหางนาค',
    'นางสวน',
    'สันป่าตอง',
    'อีขาวน้อย',
    'อีขาวใหญ่',
  ];

  Interpreter? _interpreter;
  Future<void>? _loading;

  /// โหลดโมเดลครั้งเดียว เรียกซ้ำกี่ครั้งก็ได้ (ใช้ Future เดิม)
  Future<void> loadModel() {
    return _loading ??= () async {
      try {
        _interpreter = await Interpreter.fromAsset(
          'assets/models/Custom_CNN_best_fp16.tflite',
        );
        if (kDebugMode) {
          debugPrint('Model loaded');
          debugPrint('Input: ${_interpreter!.getInputTensor(0).shape} '
              '${_interpreter!.getInputTensor(0).type}');
          debugPrint('Output: ${_interpreter!.getOutputTensor(0).shape} '
              '${_interpreter!.getOutputTensor(0).type}');
        }
      } catch (e) {
        _loading = null; // เปิดโอกาสให้ลองโหลดใหม่
        rethrow;
      }
    }();
  }

  Future<ClassificationResult> classifyImage(File imageFile) async {
    await loadModel();
    final interpreter = _interpreter!;

    final inShape = interpreter.getInputTensor(0).shape; // [1, h, w, 3]
    final h = inShape[1];
    final w = inShape[2];
    final numClasses = interpreter.getOutputTensor(0).shape[1];

    // งานหนัก (decode / resize / แปลงพิกเซล) ทำใน isolate
    final pixels = await compute(_preprocess, <Object>[imageFile.path, w, h]);

    final input = pixels.reshape([1, h, w, 3]);
    final output = List.filled(numClasses, 0.0).reshape([1, numClasses]);
    interpreter.run(input, output);

    final scores = (output[0] as List).cast<double>();

    var maxIndex = 0;
    for (var i = 1; i < scores.length; i++) {
      if (scores[i] > scores[maxIndex]) maxIndex = i;
    }

    if (kDebugMode) {
      final sum = scores.reduce((a, b) => a + b);
      debugPrint('sum=${sum.toStringAsFixed(4)} scores=$scores');
      debugPrint('Prediction: ${_labels[maxIndex]} '
          '${(scores[maxIndex] * 100).toStringAsFixed(2)}%');
    }

    return ClassificationResult(
      _labels[maxIndex],
      scores[maxIndex] * 100,
      scores,
    );
  }

  /// เรียกเฉพาะตอนต้องการคืนหน่วยความจำจริงๆ (ปกติไม่ต้องเรียก)
  void close() {
    _interpreter?.close();
    _interpreter = null;
    _loading = null;
  }
}
