import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'show_media_dialog.dart';

class MediasListWidget extends StatefulWidget {
  final List<String> medias;
  const MediasListWidget({super.key, required this.medias});
  @override
  State<MediasListWidget> createState() => _MediasListWidgetState();
}

class _MediasListWidgetState extends State<MediasListWidget> {
  final Map<String, VideoPlayerController> _controllers = {};
  final Map<String, bool> _initStatus = {}; // true = initialized, false = initializing

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  bool _isVideo(String media) {
    final lower = media.toLowerCase();
    return lower.endsWith('.mp4') || lower.endsWith('.mov') || lower.endsWith('.mkv') || lower.endsWith('.webm');
  }

  int _initializingCount = 0;
  static const int _maxParallelInits = 3;

  void _ensureVideoController(String url) {
    if (_controllers.containsKey(url)) return; // already created
    if (_initializingCount >= _maxParallelInits) return; // throttle
    _initializingCount++;
    // ignore: deprecated_member_use
    final controller = VideoPlayerController.network(url);
    _controllers[url] = controller;
    _initStatus[url] = false;
    controller
        .initialize()
        .then((_) async {
          await controller.setLooping(true);
          await controller.setVolume(0);
          // ignore: discarded_futures
          controller.play();
          if (mounted) setState(() => _initStatus[url] = true);
        })
        .catchError((_) {
          if (mounted) setState(() => _initStatus[url] = true);
        })
        .whenComplete(() {
          _initializingCount = (_initializingCount - 1).clamp(0, 999);
        });
  }

  @override
  Widget build(BuildContext context) {
    final medias = widget.medias;
    return Container(
      height: 101,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: medias.length,
        itemBuilder: (context, index) {
          final media = medias[index];
          final isVideo = _isVideo(media);

          if (isVideo) _ensureVideoController(media);
          final controller = _controllers[media];
          final initialized = _initStatus[media] == true && controller?.value.isInitialized == true;

          return InkWell(
            onTap: () => showMediaDialog(context, media),
            child: Container(
              width: 101,
              height: 101,
              margin: const EdgeInsets.only(right: 10),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade200,
                image: !isVideo ? DecorationImage(image: NetworkImage(media), fit: BoxFit.cover) : null,
              ),
              child:
                  isVideo
                      ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child:
                                initialized && controller != null
                                    ? FittedBox(
                                      fit: BoxFit.cover,
                                      child: SizedBox(
                                        width: controller.value.size.width,
                                        height: controller.value.size.height,
                                        child: VideoPlayer(controller),
                                      ),
                                    )
                                    : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                          ),
                          if (controller != null && !controller.value.isPlaying)
                            Container(
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(Icons.play_arrow, color: Colors.white, size: 28),
                            ),
                        ],
                      )
                      : null,
            ),
          );
        },
      ),
    );
  }
}
