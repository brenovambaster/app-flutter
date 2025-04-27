import 'dart:math';

int generateShortId() {
  final now = DateTime.now().millisecondsSinceEpoch;
  final random = Random().nextInt(1000); // número aleatório de 0 a 999

  // Soma o timestamp com número aleatório e pega os 5 últimos dígitos
  final combined = now + random;
  final idStr = combined.toString();
  final shortId = int.parse(idStr.substring(idStr.length - 5));

  return shortId;
}
