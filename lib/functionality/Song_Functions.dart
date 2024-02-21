import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

String currentSongTitle = '', currentSongArtist = '';
bool isPlaying = false;
int currentIndex = 0;
bool isShuffleEnabled = false;
bool isHeartEnabled = false;
// bool isLoopEnabled = false;

final OnAudioQuery audioQuery = OnAudioQuery();

final AudioPlayer player = AudioPlayer();

void dispose() {
  player.dispose();
}

void playPause() async {
  if (isPlaying) {
    player.pause();
  } else {
    player.play();
  }
}

void nextSong() {
  // if (currentIndex < songs.length - 1) {
  //   currentIndex++;
  //   currentSongTitle = songs[currentIndex].Title;
  //   currentSongArtist = songs[currentIndex].Artist;
  // }
  if (player.hasNext) {
    player.seekToNext();
    player.play();
    isPlaying = true;
  }
}

void previousSong() {
  // if (currentIndex <= 0) {
  //   currentIndex = songs.length - 1;
  // } else if (currentIndex < songs.length - 1) {
  //   currentIndex--;
  // }
  // currentSongTitle = songs[currentIndex].Title;
  // currentSongArtist = songs[currentIndex].Artist;
  if (player.hasPrevious) {
    player.seekToPrevious();
    player.play();
    isPlaying = true;
  }
}

void ShuffleRepeat() {
  if (isShuffleEnabled == true) {
    player.setShuffleModeEnabled(true);
  } else {
    player.setShuffleModeEnabled(false);
  }
}
