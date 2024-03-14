import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    _controller = VideoPlayerController.asset('assets/video/bg_search_i.mp4');
    await _controller.initialize();
    if (mounted) {
      setState(() {});
    }
    _controller.setLooping(true);
    _controller.play();
    _controller.addListener(() {
      if (_controller.value.hasError) {
        print('Error: ${_controller.value.errorDescription}');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Search bar with icon
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Add your search functionality here
                        },
                        icon: Icon(Icons.search),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add other search-related widgets/components here
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
