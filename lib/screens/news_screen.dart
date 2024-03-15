import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS'),
        backgroundColor: Color(0xFF0D7207),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildNewsItem(
              title: 'New Study Reveals Benefits of Eating Berries',
              description:
              'A recent study published in the Journal of Nutrition suggests that consuming a diet rich in berries may improve cognitive function and memory in older adults.',
            ),
            _buildNewsItem(
              title: 'The Rise of Plant-Based Diets',
              description:
              'With the growing awareness of environmental sustainability and health concerns, more people are adopting plant-based diets. Learn more about the benefits and challenges of going plant-based.',
            ),
            _buildNewsItem(
              title: 'Local Farmer\'s Market Report',
              description:
              'Find out what\'s in season at your local farmer\'s market and get tips on how to incorporate fresh, seasonal produce into your meals.',
            ),
            // Add more news items as needed
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItem({required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
          Divider(), // Add a divider between news items
        ],
      ),
    );
  }
}
