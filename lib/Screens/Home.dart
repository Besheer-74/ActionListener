// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../functionality/images.dart';
import '../functionality/Song_Functions.dart';
import 'play_Screen.dart';
import '../model/list.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasPermission = false;
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<Song> filteredSong = [];
  String? selectedOption; // Default selected option

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
                Text(
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
          Padding(
            padding: EdgeInsets.only(left: deviceWidth * 0.03),
            child: TextField(
              style: TextStyle(
                color: Color(0xffdda853),
              ),
              onChanged: onSearch,
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
            child: CArd_List(),
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

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    hasPermission ? setState(() {}) : null;
  }

  @override
  void initState() {
    filteredSong = songs;
    super.initState();
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    audioQuery.setLogConfig(logConfig);
    checkAndRequestPermissions();
    player.currentIndexStream.listen((index) {
      if (index != null) {
        updateCurrentPlayingSongDetails(index);
      }
    });
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

  noAccessToLibraryWidget() {
    () => checkAndRequestPermissions(retry: true);
  }

  void onSearch(String searchText) {
    setState(() {
      filteredSong = songs
          .where((music) =>
              music.title.toLowerCase().contains(searchText.toLowerCase()) ||
              music.Artist.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  CArd_List() {
    return Center(
      child: !hasPermission
          ? noAccessToLibraryWidget()
          : FutureBuilder<List<SongModel>>(
              future: audioQuery.querySongs(
                sortType: SongSortType.DATE_ADDED,
                orderType: OrderType.DESC_OR_GREATER,
                uriType: UriType.EXTERNAL,
                ignoreCase: true,
              ),
              builder: (context, items) {
                if (items.data == null) {
                  return const CircularProgressIndicator();
                }
                if (items.data!.isEmpty) {
                  return const Text("Sorry you don't have songs!");
                }
                songs.clear();
                for (var songModel in items.data!) {
                  songs.add(Song(
                    title: songModel.title,
                    Artist: songModel.artist ?? "No Artist",
                    image: songModel.id,
                    Uri: songModel.uri ?? "none",
                    Duration: songModel.duration,
                  ));
                }
                return ListView.builder(
                    itemCount: filteredSong.length,
                    itemBuilder: (context, index) {
                      Song song = filteredSong[index];
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
                                ModalBottomSheet();
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
                              await player.setAudioSource(playlist(items.data!),
                                  initialIndex: index);
                              await player.play();
                            },
                          ),
                        ),
                      );
                    });
              },
            ),
    );
  }

  ModalBottomSheet() {
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
                      Icons.playlist_add,
                      color: Color(0xff1e202c),
                    ),
                    title: Text(
                      "Add To PlayList",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E202C),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.skip_next,
                      color: Color(0xff1e202c),
                    ),
                    title: Text(
                      "play Next",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E202C),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
