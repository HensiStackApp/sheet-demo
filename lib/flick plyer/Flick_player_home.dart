import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FlickPlayerHome extends StatefulWidget {
  const FlickPlayerHome({Key key}) : super(key: key);

  @override
  _FlickPlayerHomeState createState() => _FlickPlayerHomeState();
}

class _FlickPlayerHomeState extends State<FlickPlayerHome> {
  FlickManager flickManager;

  @override
  void initState() {
    // TODO: implement initState
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        'https://media.vidyasaar.com/premium/class-10/maths/videos/en/arithmetic-progression/5ffb0a4d756fd50031ed896a/mpl.m3u8',
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VisibilityDetector(
              key: ObjectKey(flickManager),
              child: flickManager != null
                  ? Expanded(
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          bool isFullscreen =
                              orientation == Orientation.landscape;
                          print('isFullscreen-->$isFullscreen');
                          return isFullscreen
                              ? Container(
                                  child: FlickVideoPlayer(
                                    flickManager: flickManager,
                                    preferredDeviceOrientationFullscreen: [
                                      DeviceOrientation.landscapeRight,
                                      DeviceOrientation.landscapeLeft,
                                      DeviceOrientation.portraitDown,
                                      DeviceOrientation.portraitUp,
                                    ],
                                    preferredDeviceOrientation: [
                                      DeviceOrientation.landscapeRight,
                                      DeviceOrientation.landscapeLeft,
                                      DeviceOrientation.portraitDown,
                                      DeviceOrientation.portraitUp,
                                    ],
                                  ),
                                )
                              : Container(
                                  child: FlickVideoPlayer(
                                    flickManager: flickManager,
                                    preferredDeviceOrientationFullscreen: [
                                      DeviceOrientation.portraitDown,
                                      DeviceOrientation.portraitUp,
                                    ],
                                    preferredDeviceOrientation: [
                                      DeviceOrientation.landscapeRight,
                                      DeviceOrientation.landscapeLeft,
                                    ],
                                  ),
                                );
                        },
                      ),
                    )
                  : Container(),
              onVisibilityChanged: (visibility) {
                if (visibility.visibleFraction == 0 && this.mounted) {
                  flickManager.flickControlManager?.autoPause();
                } else if (visibility.visibleFraction == 1) {
                  flickManager.flickControlManager?.autoResume();
                }
              })
        ],
      ),
    );
  }
}
