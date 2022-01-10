import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/commonWidget/commonButton.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({Key key}) : super(key: key);

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration();
  Duration position = Duration();
  int result;
  bool playingStatus = false;

  String get _durationText => duration?.toString()?.split('.')?.first ?? '';

  String get _positionText => position?.toString()?.split('.')?.first ?? '';

  initPlayer() {
    // ignore: deprecated_member_use
    audioPlayer.durationHandler = (d) => setState(() {
          duration = d;
        });
    // ignore: deprecated_member_use
    audioPlayer.positionHandler = (p) => setState(() {
          position = p;
        });
  }

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Player"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 200),
          child: Column(
            children: <Widget>[
              Text("audio Player"),
              SizedBox(
                height: 10,
              ),
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  side: BorderSide(
                    color: themeColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () => isPlaying
                              ? pause()
                              : play(
                                  'https://luan.xyz/files/audio/ambient_c_motion.mp3'),
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Text(
                                "https://luan.xyz/files/audio/ambient_c_motion.mp3",
                              ),
                            ),
                            slider(),
                            Text(
                              position != null
                                  ? '$_positionText / $_durationText'
                                  : duration != null
                                      ? _durationText
                                      : '',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.stop),
                              onPressed: stop,
                            ),
                            IconButton(
                              icon: Icon(Icons.volume_up),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text('volume_up'),
                                        content: Container(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              elevatedButton(() {
                                                audioPlayer.setVolume(0.0);
                                                Navigator.of(context).pop();
                                              }, "0.0"),
                                              elevatedButton(() {
                                                audioPlayer.setVolume(0.5);
                                                Navigator.of(context).pop();
                                              }, "0.5"),
                                              elevatedButton(() {
                                                audioPlayer.setVolume(1.0);
                                                Navigator.of(context).pop();
                                              }, "1.0"),
                                              elevatedButton(() {
                                                audioPlayer.setVolume(2.0);
                                                Navigator.of(context).pop();
                                              }, "2.0"),
                                            ],
                                          ),
                                        ));
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.speed_rounded),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text('Playback Rate'),
                                        content: Container(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              elevatedButton(() {
                                                audioPlayer.setPlaybackRate(
                                                    playbackRate: 0.5);
                                                Navigator.of(context).pop();
                                              }, "0.5"),
                                              elevatedButton(() {
                                                audioPlayer.setPlaybackRate(
                                                    playbackRate: 1.0);
                                                Navigator.of(context).pop();
                                              }, "1.0"),
                                              elevatedButton(() {
                                                audioPlayer.setPlaybackRate(
                                                    playbackRate: 1.5);
                                                Navigator.of(context).pop();
                                              }, "1.5"),
                                              elevatedButton(() {
                                                audioPlayer.setPlaybackRate(
                                                    playbackRate: 3.0);
                                                Navigator.of(context).pop();
                                              }, "3.0"),
                                            ],
                                          ),
                                        ));
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  play(String url) async {
    await audioPlayer.play(url);
    setState(() {
      isPlaying = true;
    });
  }

  stop() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  pause() async {
    await audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  seekToSecond(int time) {
    Duration newDuration = Duration(microseconds: time);
    audioPlayer.seek(newDuration);
  }

  Widget slider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          trackShape: RoundedRectSliderTrackShape(),
          trackHeight: 4.0,
          activeTrackColor: themeColor,
          inactiveTrackColor: grey,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
          thumbColor: themeColor
          //thumbColor: Colors.redAccent,
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Slider(
          value: (position.inMicroseconds.toDouble() >=
                  duration.inMicroseconds.toDouble())
              ? 0.0
              : position.inMicroseconds.toDouble(),
          min: 0.0,
          max: duration.inMicroseconds.toDouble(),
          label: '${position.inMicroseconds.toDouble()}',
          onChanged: (double value) {
            setState(() {
              print('value --> $value');
              seekToSecond(value.toInt());
              value = value;
            });
          },
        ),
      ),
    );
  }
}
