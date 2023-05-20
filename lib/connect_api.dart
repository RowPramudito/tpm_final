import 'dart:convert';
import 'package:http/http.dart' as http;

class Connect {

  static final String baseUrl = 'https://ws.audioscrobbler.com/2.0/?method=tag.';
  static const String apiKey = 'c515339931c2e59069ef8c9b1d33e0ae';

  Future<List<dynamic>> fetchTopAlbums(String tag) async {
    final String fullUrl = baseUrl + 'gettopalbums&tag=' + tag + '&api_key=$apiKey&format=json';
    final response = await http.get(Uri.parse(fullUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final albums = data['albums']['album'] as List<dynamic>;
      return albums;
    } else {
      throw Exception('Failed to fetch top albums');
    }
  }

}