import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miracle/Core/Global/Widgets/global_loading_widget.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Features/Audio/Controllers/audio_controller.dart';
import 'package:miracle/Features/Audio/Models/position_data.dart';

import 'seek_bar.dart';

class AudioControllCard extends StatelessWidget {
  final AudioController controller;

  const AudioControllCard({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // StreamBuilder<LoopMode>(
          //   stream: controller.audioPlayer.loopModeStream,
          //   builder: (context, snapshot) {
          //     final loopMode = snapshot.data ?? LoopMode.off;
          //     var icons = [
          //       Icon(
          //         Icons.repeat,
          //         color: AppColors.primary.withOpacity(.5),
          //         size: 25,
          //       ),
          //       const Icon(
          //         Icons.repeat,
          //         color: AppColors.primary,
          //         size: 25,
          //       ),
          //       // const Icon(
          //       //   Icons.repeat_one,
          //       //   color: AppColors.primary,
          //       //   size: 25,
          //       // ),
          //     ];
          //     const cycleModes = [
          //       LoopMode.off,
          //       // LoopMode.all,
          //       LoopMode.one,
          //     ];
          //     final index = cycleModes.indexOf(loopMode);
          //     return IconButton(
          //       icon: icons[index],
          //       onPressed: () {
          //         controller.audioPlayer.setLoopMode(cycleModes[
          //             (cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
          //       },
          //     );
          //   },
          // ),
          // StreamBuilder<SequenceState?>(
          //   stream: controller.audioPlayer.sequenceStateStream,
          //   builder: (context, snapshot) => IconButton(
          //     icon: Icon(
          //       FlutterIcons.fast_bw,
          //       color: AppColors.primary
          //           .withOpacity(controller.audioPlayer.hasPrevious ? 1 : 0),
          //     ),
          //     onPressed: () => controller.getPreviousMusic(),
          //     iconSize: 25.0,
          //   ),
          // ),
          Expanded(
            child: StreamBuilder<PositionData>(
              stream: controller.positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                      positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: (newPosition) {
                    controller.audioPlayer.seek(newPosition);
                  },
                );
              },
            ),
          ),
          SizedBox(width: 5.r),
          StreamBuilder<PlayerState>(
            stream: controller.audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading) {
                return const GlobalLoadingWidget();
              } else if (playing != true) {
                return IconButton(
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.primary,
                  ),
                  iconSize: 35.0,
                  onPressed: () => controller.play(),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: const Icon(
                    Icons.pause_rounded,
                    color: AppColors.primary,
                  ),
                  iconSize: 35.0,
                  onPressed: () => controller.pause(),
                );
              } else {
                return IconButton(
                  icon: const Icon(
                    Icons.replay,
                    color: AppColors.primary,
                  ),
                  iconSize: 35.0,
                  onPressed: () => controller.audioPlayer.seek(Duration.zero,
                      index: controller.audioPlayer.effectiveIndices!.first),
                );
              }
            },
          ),
          // StreamBuilder<SequenceState?>(
          //   stream: controller.audioPlayer.sequenceStateStream,
          //   builder: (context, snapshot) => IconButton(
          //     icon: Icon(
          //       FlutterIcons.fast_fw,
          //       color: AppColors.primary.withOpacity(
          //         controller.audioPlayer.hasNext ? 1 : 0,
          //       ),
          //     ),
          //     iconSize: 25.0,
          //     onPressed: () => controller.getNextMusic(),
          //   ),
          // ),
          // StreamBuilder<bool>(
          //   stream: controller.audioPlayer.shuffleModeEnabledStream,
          //   builder: (context, snapshot) {
          //     final shuffleModeEnabled = snapshot.data ?? false;
          //     return IconButton(
          //       icon: Icon(
          //         FlutterIcons.shuffle,
          //         color: shuffleModeEnabled
          //             ? AppColors.primary
          //             : AppColors.primary.withOpacity(.5),
          //       ),
          //       iconSize: 25.0,
          //       onPressed: () async {
          //         final enable = !shuffleModeEnabled;
          //         if (enable) {
          //           await controller.audioPlayer.shuffle();
          //         }
          //         await controller.audioPlayer.setShuffleModeEnabled(enable);
          //         // controller.changeletShuffle();
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
