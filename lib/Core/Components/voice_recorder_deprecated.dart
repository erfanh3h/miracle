// import 'dart:io';

// import 'package:audio_session/audio_session.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class VoiceRecorderComponent {
//   final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
//   final FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
//   Codec _codec = Codec.aacMP4;
//   late String _mPath;
//   // bool _mPlayerIsInited = false;
//   // bool _mRecorderIsInited = false;
//   // bool _mplaybackReady = false;
//   Future<void> openTheRecorder() async {
//     if (!kIsWeb) {
//       Directory tempDir = await getTemporaryDirectory();
//       File outputFile = File('${tempDir.path}/record-tmp.mp4');
//       _mPath = outputFile.path;
//       print(_mPath);
//       var status = await Permission.microphone.request();
//       if (status != PermissionStatus.granted) {
//         throw RecordingPermissionException('Microphone permission not granted');
//       }
//     } else {
//       _mPath = 'record-tmp.webm';
//     }
//     await _mRecorder.openRecorder();
//     if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
//       _codec = Codec.opusWebM;
//     }
//     final session = await AudioSession.instance;
//     await session.configure(AudioSessionConfiguration(
//       avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
//       avAudioSessionCategoryOptions:
//           AVAudioSessionCategoryOptions.allowBluetooth |
//               AVAudioSessionCategoryOptions.defaultToSpeaker,
//       avAudioSessionMode: AVAudioSessionMode.spokenAudio,
//       avAudioSessionRouteSharingPolicy:
//           AVAudioSessionRouteSharingPolicy.defaultPolicy,
//       avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
//       androidAudioAttributes: const AndroidAudioAttributes(
//         contentType: AndroidAudioContentType.speech,
//         flags: AndroidAudioFlags.none,
//         usage: AndroidAudioUsage.voiceCommunication,
//       ),
//       androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
//       androidWillPauseWhenDucked: true,
//     ));
//   }

//   startRecorder() async {
//     await openTheRecorder();
//     _mRecorder.startRecorder(toFile: _mPath, codec: _codec);
//   }

//   pauseRecorder() async {
//     try {
//       await _mRecorder.pauseRecorder();
//     } catch (_) {}
//   }

//   resumeRecorder() async {
//     try {
//       await _mRecorder.resumeRecorder();
//     } catch (_) {}
//   }

//   Future<String> stopRecorder() async {
//     await _mRecorder.stopRecorder();
//     return _mPath;
//   }

//   void dispose() {
//     _mPlayer.closePlayer();
//     _mRecorder.closeRecorder();
//   }
// }
