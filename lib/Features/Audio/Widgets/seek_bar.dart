import 'dart:math';

import 'package:flutter/material.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Features/Audio/Widgets/hidden_thumb_shape.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("${widget.position}")
                      ?.group(1) ??
                  '${widget.position}',
              style: const TextStyle(
                color: AppColors.primary,
                fontFamily: 'montserrat',
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SliderTheme(
                  data: _sliderThemeData.copyWith(
                    thumbShape: HiddenThumbShape(),
                    activeTrackColor: AppColors.primary.withOpacity(.5),
                    inactiveTrackColor: AppColors.primary.withOpacity(.25),
                  ),
                  child: ExcludeSemantics(
                    child: Slider(
                      min: 0.0,
                      max: widget.duration.inMilliseconds.toDouble(),
                      value: min(
                          widget.bufferedPosition.inMilliseconds.toDouble(),
                          widget.duration.inMilliseconds.toDouble()),
                      onChanged: (value) {
                        setState(() {
                          _dragValue = value;
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(
                              Duration(milliseconds: value.round()));
                        }
                      },
                      onChangeEnd: (value) {
                        if (widget.onChangeEnd != null) {
                          widget.onChangeEnd!(
                              Duration(milliseconds: value.round()));
                        }
                        _dragValue = null;
                      },
                    ),
                  ),
                ),
                SliderTheme(
                  data: _sliderThemeData.copyWith(
                    inactiveTrackColor: Colors.transparent,
                    thumbColor: AppColors.primary,
                    activeTrackColor: AppColors.primary,
                  ),
                  child: Slider(
                    min: 0.0,
                    max: widget.duration.inMilliseconds.toDouble(),
                    value: min(
                        _dragValue ?? widget.position.inMilliseconds.toDouble(),
                        widget.duration.inMilliseconds.toDouble()),
                    onChanged: (value) {
                      setState(() {
                        _dragValue = value;
                      });
                      if (widget.onChanged != null) {
                        widget
                            .onChanged!(Duration(milliseconds: value.round()));
                      }
                    },
                    onChangeEnd: (value) {
                      if (widget.onChangeEnd != null) {
                        widget.onChangeEnd!(
                            Duration(milliseconds: value.round()));
                      }
                      _dragValue = null;
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("${widget.duration}")
                      ?.group(1) ??
                  '${widget.duration}',
              style: const TextStyle(
                color: AppColors.primary,
                fontFamily: 'montserrat',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Duration get _remaining => widget.duration - widget.position;
}



// class PositionData {
//   final Duration position;
//   final Duration bufferedPosition;
//   final Duration duration;

//   PositionData(this.position, this.bufferedPosition, this.duration);
// }

// void showSliderDialog({
//   required BuildContext context,
//   required String title,
//   required int divisions,
//   required double min,
//   required double max,
//   String valueSuffix = '',
//   required Stream<double> stream,
//   required ValueChanged<double> onChanged,
// }) {
//   showDialog<void>(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text(title, textAlign: TextAlign.center),
//       content: StreamBuilder<double>(
//         stream: stream,
//         builder: (context, snapshot) => SizedBox(
//           height: 100.0,
//           child: Column(
//             children: [
//               Text(
//                 '${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24.0,
//                 ),
//               ),
//               Slider(
//                 divisions: divisions,
//                 min: min,
//                 max: max,
//                 value: snapshot.data ?? 1.0,
//                 onChanged: onChanged,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
