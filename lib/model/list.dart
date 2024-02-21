import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Song {
  String title;
  String Artist;
  String Uri;
  var image;
  var Duration;
  bool isSelected;
  String playlistId;

  Song({
    required this.title,
    required this.Artist,
    required this.Uri,
    required this.image,
    required this.Duration,
    this.isSelected = false,
    this.playlistId = '',
  });
}

List<Song> songs = [];
List<Song> Loved = [];

ConcatenatingAudioSource playlist(List<SongModel> songs) {
  return ConcatenatingAudioSource(children: Listsong);
}

final List<AudioSource> Listsong = songs.map((song) {
  return AudioSource.uri(Uri.parse(song.Uri));
}).toList();
