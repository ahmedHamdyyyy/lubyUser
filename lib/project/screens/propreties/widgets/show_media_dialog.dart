import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

// Determine if a url/path looks like a video based on extension
bool _isVideo(String media) {
  final lower = media.toLowerCase();
  return lower.endsWith('.mp4') || lower.endsWith('.mov') || lower.endsWith('.mkv') || lower.endsWith('.webm');
}

Future<void> showMediaDialog(BuildContext context, String mediaUrl) async {
  if (_isVideo(mediaUrl)) {
    await showDialog(context: context, barrierDismissible: true, builder: (context) => _VideoDialog(mediaUrl: mediaUrl));
  } else {
    await showDialog(context: context, barrierDismissible: true, builder: (context) => _ImageDialog(imageUrl: mediaUrl));
  }
}

class _ImageDialog extends StatelessWidget {
  final String imageUrl;
  const _ImageDialog({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 1, // keep square similar to original height 335
              child: InteractiveViewer(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stack) => const Center(child: Icon(Icons.broken_image, size: 60)),
                ),
              ),
            ),
          ),
          _CloseButton(),
        ],
      ),
    );
  }
}

class _VideoDialog extends StatefulWidget {
  final String mediaUrl;
  const _VideoDialog({required this.mediaUrl});

  @override
  State<_VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<_VideoDialog> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      _controller = VideoPlayerController.network(widget.mediaUrl);
      await _controller.initialize();
      await _controller.setLooping(true);
      setState(() => _initialized = true);
      // Fire and forget playback start
      // ignore: discarded_futures
      _controller.play();
    } catch (e) {
      if (mounted) setState(() => _error = true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: _initialized ? _controller.value.aspectRatio : 16 / 9,
              child:
                  _error
                      ? const Center(child: Icon(Icons.error, size: 48))
                      : !_initialized
                      ? const Center(child: CircularProgressIndicator())
                      : GestureDetector(
                        onTap: () {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                          setState(() {});
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            VideoPlayer(_controller),
                            if (!_controller.value.isPlaying)
                              Container(
                                decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(60)),
                                padding: const EdgeInsets.all(16),
                                child: const Icon(Icons.play_arrow, color: Colors.white, size: 48),
                              ),
                          ],
                        ),
                      ),
            ),
          ),
          _CloseButton(),
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        // ignore: deprecated_member_use
        child: SvgPicture.asset('assets/images/close-square.svg', color: const Color(0xFF414141), height: 24),
      ),
    );
  }
}
