import 'package:rxdart/rxdart.dart';
import 'Song_Functions.dart';

class DurationState {
  final Duration position;
  final Duration total;
  DurationState({required this.position, required this.total});
}

Stream<DurationState> get durationState =>
    Rx.combineLatest2<Duration, Duration?, DurationState>(
        player.positionStream,
        player.durationStream,
        (position, duration) => DurationState(
            position: position, total: duration ?? Duration.zero));
