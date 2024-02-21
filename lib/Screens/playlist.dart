import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functionality/Song_Functions.dart';
import '../functionality/images.dart';
import '../model/list.dart';
import 'play_Screen.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double deviceWidth = mediaQuery.size.width;
    double deviceHeight = mediaQuery.size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(
              deviceWidth * 0.05,
              deviceHeight * 0.02,
              deviceWidth * 0.05,
              deviceHeight * 0.02,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ActionListener",
                    style: TextStyle(
                      color: Color(0xffdda853),
                      fontSize: 24,
                      fontFamily: 'MetalMania',
                      fontWeight: FontWeight.w400,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: deviceWidth * 0.42),
                  child: Image.asset(Small_Settings_Icon),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: deviceWidth * 0.03),
            child: TextField(
              // onChanged: onSearch,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                hintText: "Song, artist, album",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffdda853),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: Loved.length,
                itemBuilder: (context, index) {
                  Song song = Loved[index];
                  String title = song.title;
                  String artist = song.Artist;
                  return Container(
                    height: 100,
                    width: 320,
                    child: Card(
                      color: const Color(0xff2b2f44),
                      elevation: 10,
                      margin: const EdgeInsets.fromLTRB(20, 13, 20, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        leading: Container(
                          width: 36,
                          height: 36,
                          child: QueryArtworkWidget(
                              id: song.image, type: ArtworkType.AUDIO),
                        ),
                        title: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xfff7bc59),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                        subtitle: Text(
                          artist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Color(0xfff7bc59),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            // ModalBottomSheet();
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: Color(0xfff7bc59),
                          ),
                        ),
                        onTap: () async {
                          setState(() {
                            isPlaying = true;
                          });
                          // await player.setAudioSource(playlist(items.data!),
                          //     initialIndex: index);
                          // await player.play();
                        },
                      ),
                    ),
                  );
                }),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const play_Screen(),
                ),
              );
            },
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF9BD59),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: deviceWidth * 0.05),
                child: Row(children: [
                  Image.asset(
                    mini_Icon,
                    height: 36,
                    width: 36,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: deviceWidth * 0.03,
                      top: deviceHeight * 0.025,
                    ),
                    child: Column(children: [
                      Container(
                        width: deviceWidth * 0.45,
                        height: deviceHeight * 0.024,
                        child: Text(
                          currentSongTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E202C),
                          ),
                        ),
                      ),
                      Container(
                        width: deviceWidth * 0.45,
                        height: deviceHeight * 0.024,
                        child: Text(
                          currentSongArtist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E202C),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: deviceWidth * 0.10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              previousSong();
                            });
                          },
                          child: const Icon(
                            Icons.skip_previous,
                            size: 25,
                            color: Color(0xff1e202c),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.01),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                playPause();
                                isPlaying = !isPlaying;
                              });
                            },
                            child: Icon(
                              isPlaying
                                  ? Icons.pause_circle_outline_sharp
                                  : Icons.play_circle_outline_sharp,
                              color: const Color(0xff1e202c),
                              size: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: deviceWidth * 0.01),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                nextSong();
                              });
                            },
                            child: const Icon(
                              Icons.skip_next,
                              size: 25,
                              color: Color(0xff1e202c),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
