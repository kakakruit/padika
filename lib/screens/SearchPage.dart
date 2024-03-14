import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../widgets/Bottom_nav_bar.dart'; // Import the BottomNavBar widget

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late VideoPlayerController _controller;
  bool _isSearchBarFocused = false;

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
        title: Text('SEARCH'),
        backgroundColor: Color(0xFFacc4ac),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isSearchBarFocused = !_isSearchBarFocused;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 800),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      onTap: () {
                        setState(() {
                          _isSearchBarFocused = true;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Ingredient Name',
                        hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
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
      bottomNavigationBar: BottomNavBar(), // Add the BottomNavBar widget here
    );
  }
}
