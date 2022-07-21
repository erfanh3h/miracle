import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class VoiceRecordereCompanent {
  final recorder = Record();
  String _tempDirectory = '';
  Future<void> startRecorder() async {
    if (!kIsWeb) {
      Directory tempDir = await getTemporaryDirectory();
      // File outputFile = File('${tempDir.path}/temp-record.mp4');
      _tempDirectory = '${tempDir.path}/temp-record.mp4';
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {}
    } else {
      _tempDirectory = 'temp-record.webm';
    }
    recorder.start(
      path: _tempDirectory,
      encoder: AudioEncoder.aacLc, // by default
      bitRate: 48000, // by default
      samplingRate: 441000, // by default
    );
  }

  Future<String?> stopRecorder() async {
    return await recorder.stop();
  }

  void pauseRecorder() async {
    await recorder.pause();
  }

  Future unPauseRecorder() async {
    await recorder.resume();
  }

  release() async {
    recorder.dispose();
  }
}
