import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchComments() async {
  // Get a reference to the Firestore collection
  final collection = FirebaseFirestore.instance.collection('comments');

  // Fetch all comments as a QuerySnapshot
  final snapshot = await collection.get();

  // Extract comments and pre-process them (if necessary)
  final comments = snapshot.docs.map((doc) {
    final data = doc.data()!; // Assuming proper security rules are in place
    // Pre-process the comment text as needed (e.g., cleaning, tokenization)
    return {
      'userId': data['userId'],
      'commentText': data['commentText'],
    };
  }).toList();

  return comments;
}
