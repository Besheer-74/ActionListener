// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:ActionListener/Screens/playlist.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '../functionality/Song_Functions.dart';
import 'package:flutter/material.dart';
import '../functionality/images.dart';
import '../functionality/progress bar.dart';
import '../model/list.dart';

class play_Screen extends StatefulWidget {
  const play_Screen({super.key});
  @override
  State<play_Screen> createState() => _play_ScreenState();
}

class _play_ScreenState extends State<play_Screen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double deviceWidth = mediaQuery.size.width;
    double deviceHeight = mediaQuery.size.height;

    void ModalBottomSheet() {
      showModalBottomSheet(
          context: context,
          backgroundColor: Color(0xFFF9BD59),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          builder: (context) {
            return SizedBox(
              height: 150,
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Color(0xff1e202c),
                      ),
                      title: Text(
                        currentSongArtist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E202C),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.playlist_add,
                        color: Color(0xff1e202c),
                      ),
                      title: TextButton(
                        onPressed: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  PlaylistScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Add To PlayList",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E202C),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    void Love() {
      setState(() {
        Loved = songs.where((file) => file.isSelected == true).toList();
      });
    }

    Widget Play_Buttons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                previousSong();
                currentSongTitle;
                currentSongArtist;
              });
            },
            child: const Icon(
              Icons.skip_previous,
              size: 50,
              color: Color(0xff1e202c),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                playPause();
                isPlaying = !isPlaying;
              });
            },
            child: Icon(
              isPlaying ? Icons.pause_circle : Icons.play_circle,
              color: const Color(0xff1e202c),
              size: 50,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                nextSong();
              });
            },
            child: const Icon(
              Icons.skip_next,
              size: 50,
              color: Color(0xff1e202c),
            ),
          ),
        ],
      );
    }

    Widget Func_Buttons() {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: () {
            setState(() {
              isShuffleEnabled = !isShuffleEnabled;
              ShuffleRepeat();
            });
          },
          child: Icon(isShuffleEnabled ? Icons.shuffle : Icons.repeat),
        ),
        InkWell(
          onTap: () {
            setState(() {
              isHeartEnabled = !isHeartEnabled;
              if (isHeartEnabled) {
                Love();
              }
            });
          },
          child: Icon(isHeartEnabled ? Icons.favorite : Icons.favorite_border),
        ),
        InkWell(
          onTap: () {},
          child: const Icon(Icons.featured_play_list_outlined),
        ),
      ]);
    }

    Widget Song_Art_name() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: deviceWidth * 0.9,
            height: deviceHeight * 0.05,
            child: Text(
              currentSongTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xff1e202c),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Container(
            width: deviceWidth * 0.9,
            height: deviceHeight * 0.04,
            child: Text(
              currentSongArtist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xff1e202c),
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
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
                  const Text(
                    "ActionListener",
                    style: TextStyle(
                      color: Color(0xffdda853),
                      fontSize: 24,
                      fontFamily: 'MetalMania',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: deviceWidth * 0.42),
                    child: Image.asset(Small_Settings_Icon),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9BD59),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.more_vert,
                                size: 40,
                              ),
                              onTap: () {
                                ModalBottomSheet();
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.13),
                        child: Image.asset(Big_music_Icon),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.04),
                        child: Song_Art_name(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceWidth * 0.2,
                          right: deviceWidth * 0.2,
                          top: deviceHeight * 0.02,
                        ),
                        child: Func_Buttons(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceWidth * 0.07,
                          right: deviceWidth * 0.07,
                          top: deviceHeight * 0.02,
                        ),

                        //Slider Progress bar
                        child: Column(
                          children: [
                            StreamBuilder<DurationState>(
                              stream: durationState,
                              builder: (context, snapshot) {
                                final durationState = snapshot.data;
                                final position =
                                    durationState?.position ?? Duration.zero;
                                final total =
                                    durationState?.total ?? Duration.zero;
                                return ProgressBar(
                                  progress: position,
                                  total: total,
                                  progressBarColor: Colors.black,
                                  thumbColor: Colors.white60.withBlue(99),
                                  barHeight: 10,
                                  onSeek: (duration) {
                                    player.seek(duration);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceWidth * 0.2,
                          right: deviceWidth * 0.2,
                          top: deviceHeight * 0.02,
                        ),
                        child: Play_Buttons(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateCurrentPlayingSongDetails(int index) {
    setState(() {
      if (songs.isNotEmpty) {
        currentSongTitle = songs[index].title;
        currentSongArtist = songs[index].Artist;
        currentIndex = index;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    player.currentIndexStream.listen((index) {
      if (index != null) {
        updateCurrentPlayingSongDetails(index);
      }
    });
  }
}
