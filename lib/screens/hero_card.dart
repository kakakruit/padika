import 'package:flutter/material.dart';

class HeroCard extends StatefulWidget {
  const HeroCard({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final String productId;

  @override
  _HeroCardState createState() => _HeroCardState();
}

class _HeroCardState extends State<HeroCard> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];
  bool _showComments = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(fontSize: 20),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF0D7207),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top), // Add padding to accommodate the AppBar
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF0D7207),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      widget.productId.length >= 2 ? widget.productId.substring(0, 2) : 'NV', // Display first two characters of the product ID if it has at least 2 characters
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0D7207)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.productId,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    'Barcode: 123456789',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Dummy Product',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            // Comment Field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _postComment(_commentController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0D7207), // Button color
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Post', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
            // Comments Button
            Center(
              child: ElevatedButton (
                onPressed: () {
                  setState(() {
                    _showComments = !_showComments;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0D7207), // Button color
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                child: Text(
                  _showComments ? 'Hide Comments' : 'Show Comments',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            // Comments Section
            if (_showComments) ...[
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(_comments[index]),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _postComment(String comment) {
    if (comment.isNotEmpty) {
      setState(() {
        _comments.insert(0, comment); // Add new comment to the beginning of the list
        _commentController.clear();
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: HeroCard(productId: '1234567890'),
      ),
    ),
  ));
}
