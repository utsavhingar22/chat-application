import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_comment_model.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';
  static const String _dictionaryUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en';

  // Fetch random comments/messages from API
  static Future<String> fetchRandomMessage() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/comments?limit=10'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final comments = data['comments'] as List;
        
        if (comments.isNotEmpty) {
          // Parse comments properly
          final commentList = comments
              .map((comment) => ApiCommentModel.fromJson(comment as Map<String, dynamic>))
              .toList();
          
          // Return a random comment body
          final randomIndex = DateTime.now().millisecondsSinceEpoch % commentList.length;
          return commentList[randomIndex].body;
        }
      }
      
      // Fallback message if API fails
      return 'Hello! How are you?';
    } catch (e) {
      // Return fallback message on error
      return 'Hello! How are you?';
    }
  }

  // Fetch a random comment with user info
  static Future<ApiCommentModel?> fetchRandomComment() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/comments?limit=10'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final comments = data['comments'] as List;
        
        if (comments.isNotEmpty) {
          final commentList = comments
              .map((comment) => ApiCommentModel.fromJson(comment as Map<String, dynamic>))
              .toList();
          
          final randomIndex = DateTime.now().millisecondsSinceEpoch % commentList.length;
          return commentList[randomIndex];
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Fetch word meaning from dictionary API
  static Future<Map<String, dynamic>?> fetchWordMeaning(String word) async {
    try {
      final response = await http.get(
        Uri.parse('$_dictionaryUrl/$word'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List && data.isNotEmpty) {
          final entry = data[0];
          return {
            'word': entry['word'],
            'phonetics': entry['phonetics'],
            'meanings': entry['meanings'],
            'sourceUrls': entry['sourceUrls'],
          };
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
