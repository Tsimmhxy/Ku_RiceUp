import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  Interpreter? _interpreter;

  // ลำดับป้ายชื่อคลาส (ต้องเรียงตรงกับตอนรัน train_ds.class_names ใน Python เป๊ะๆ)
  final List<String> _labels = [
    'กข6',
    'ขี้ตมหางนาค',
    'นางสวน',
    'สันป่าตอง',
    'อีขาวน้อย',
    'อีขาวใหญ่',
  ];

  Future<void> loadModel() async {
    // 💡 ปรับชื่อไฟล์ให้ตรงกับที่เซฟมาจาก Python (เช่น EfficientNetB0_best_fp16.tflite)
    _interpreter = await Interpreter.fromAsset(
      'assets/models/Custom_CNN_best_fp16.tflite',
    );

    print('=================================');
    print('Model loaded successfully');
    print('Labels: $_labels');
    print(
        'Input shape: ${_interpreter!.getInputTensor(0).shape}'); // ควรจะได้ [1, 224, 224, 3]
    print(
        'Output shape: ${_interpreter!.getOutputTensor(0).shape}'); // ควรจะได้ [1, 6]
    print('Input type: ${_interpreter!.getInputTensor(0).type}');
    print('Output type: ${_interpreter!.getOutputTensor(0).type}');
    print('=================================');
  }

  Future<Map<String, dynamic>> classifyImage(File imageFile) async {
    if (_interpreter == null) {
      await loadModel();
    }

    final imageBytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);

    if (image == null) {
      return {
        'label': 'ไม่สามารถอ่านรูปภาพได้',
        'confidence': 0.0,
        'scores': <double>[],
      };
    }

    // แก้ภาพจากมือถือที่อาจหมุนผิดทิศทางให้อัตโนมัติ
    image = img.bakeOrientation(image);

    // ดึง Input Shape จากโมเดลโดยอัตโนมัติ (จะได้ height = 224, width = 224)
    final inputShape = _interpreter!.getInputTensor(0).shape;
    int height = inputShape[1];
    int width = inputShape[2];

    // Resize ภาพให้ตรงกับขนาด 224x224 ที่ EfficientNetB0 ต้องการ
    image = img.copyResize(
      image,
      width: width,
      height: height,
    );

    // สร้าง Input List แบบ Float32 โดยส่งค่าพิกเซลช่วง 0-255 เข้าไปโดยตรง
    final input = List.generate(
      1,
      (_) => List.generate(
        height,
        (y) => List.generate(
          width,
          (x) {
            final pixel = image!.getPixel(x, y);
            return [
              pixel.r.toDouble(),
              pixel.g.toDouble(),
              pixel.b.toDouble(),
            ];
          },
        ),
      ),
    );

    // ดึง Output Shape จากโมเดลอัตโนมัติ (6 คลาส)
    final outputShape = _interpreter!.getOutputTensor(0).shape;
    int numClasses = outputShape[1];
    final output = List.generate(
      1,
      (_) => List.filled(numClasses, 0.0),
    );

    // รันการทำนายผล (Inference)
    _interpreter!.run(input, output);

    final scores = output[0];
    print('Raw output: $scores');

    int maxIndex = 0;
    double maxScore = scores[0];

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > maxScore) {
        maxScore = scores[i];
        maxIndex = i;
      }
    }

    final confidence = maxScore * 100;

    print('Prediction index: $maxIndex');
    print('Prediction label: ${_labels[maxIndex]}');
    print('Confidence: ${confidence.toStringAsFixed(2)}%');

    for (int i = 0; i < _labels.length; i++) {
      print('${_labels[i]} = ${(scores[i] * 100).toStringAsFixed(2)}%');
    }

    return {
      'label': _labels[maxIndex],
      'confidence': confidence,
      'scores': scores,
    };
  }

  void close() {
    _interpreter?.close();
    _interpreter = null;
  }
}
