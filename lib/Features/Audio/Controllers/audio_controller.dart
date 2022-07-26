import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miracle/Features/Audio/Models/button_state.dart';
import 'package:miracle/Features/Audio/Models/position_data.dart';
import 'package:miracle/Features/Audio/Models/progressbar_state.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart' as musicrx;
import 'dart:typed_data';

class AudioController extends GetxController {
  var isLoading = false.obs;

  var hasValue = false.obs;

  var progressState = ProgressBarState(
    current: const Duration(seconds: 0),
    buffered: const Duration(seconds: 0),
    total: const Duration(seconds: 0),
  ).obs;
  var buttonState = ButtonState.idle.obs;

  AudioPlayer audioPlayer = AudioPlayer();
  late StreamSubscription
      changeIndexStream; //this use to detect change in current playing music to get new index datas
  final playlist = ConcatenatingAudioSource(children: []);

  Stream<PositionData> get positionDataStream =>
      musicrx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );
  // @override
  // void onInit() async {
  //   super.onInit();
  // }

  Future setSource({String? path, String? url}) async {
    if (url != null) {
      await audioPlayer.setUrl(url);
    } else {
      await audioPlayer.setFilePath(path!);
    }
    // final session = await AudioSession.instance;
    // await session.configure(const AudioSessionConfiguration.music());
    // Listen to errors during playback.
    // audioPlayer.playbackEventStream
    //     .listen((event) {}, onError: (Object e, StackTrace stackTrace) {});
    // try {
    //   await audioPlayer.setAudioSource(playlist);
    // } catch (_, __) {}
  }

  void play() {
    audioPlayer.play();
    buttonState.value = ButtonState.playing;
  }

  void pause() {
    try {
      audioPlayer.pause();
      buttonState.value = ButtonState.paused;
    } catch (_) {}
  }

  void unPause() {
    try {
      audioPlayer.play();
      buttonState.value = ButtonState.playing;
    } catch (_) {}
  }

  Future<void> stop() async {
    try {
      await audioPlayer.stop();
      buttonState.value = ButtonState.idle;
    } catch (_) {}
  }
}

class BytesSource extends StreamAudioSource {
  final Uint8List _buffer;

  BytesSource(this._buffer) : super(tag: 'MyAudioSource');

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    // Returning the stream audio response with the parameters
    return StreamAudioResponse(
      sourceLength: _buffer.length,
      contentLength: (start ?? 0) - (end ?? _buffer.length),
      offset: start ?? 0,
      stream: Stream.fromIterable([_buffer.sublist(start ?? 0, end)]),
      contentType: 'audio/wav',
    );
  }
}
