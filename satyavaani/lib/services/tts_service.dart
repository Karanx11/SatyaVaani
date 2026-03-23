import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  static final FlutterTts _tts = FlutterTts();

  static Future speak(String text, {String lang = "hi-IN"}) async {
    await _tts.setLanguage("hi-IN");
    await _tts.setSpeechRate(0.4); // slower for seniors
    await _tts.setPitch(1.0);
    await _tts.speak(text);
  }

  static Future stop() async {
    await _tts.stop();
  }
}
