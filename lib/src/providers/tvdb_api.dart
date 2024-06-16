import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/genre.dart';

class TvdbApi {
  static const String apiKey = '12e70dcf-0c55-4542-afe4-143b402a0424';
  static const String token =
      'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZ2UiOiIiLCJhcGlrZXkiOiIxMmU3MGRjZi0wYzU1LTQ1NDItYWZlNC0xNDNiNDAyYTA0MjQiLCJjb21tdW5pdHlfc3VwcG9ydGVkIjpmYWxzZSwiZXhwIjoxNzIxMDAyNTAwLCJnZW5kZXIiOiIiLCJoaXRzX3Blcl9kYXkiOjEwMDAwMDAwMCwiaGl0c19wZXJfbW9udGgiOjEwMDAwMDAwMCwiaWQiOiIyNDY3Nzc4IiwiaXNfbW9kIjpmYWxzZSwiaXNfc3lzdGVtX2tleSI6ZmFsc2UsImlzX3RydXN0ZWQiOmZhbHNlLCJwaW4iOiJzdHJpbmciLCJyb2xlcyI6W10sInRlbmFudCI6InR2ZGIiLCJ1dWlkIjoiIn0.UAAUice4LR_MdRgoPHyZ4dOWAV-iyrg6UY8NgvN1B8G_-irHT7ge_JpJM9TYbo4ur9FpwZ3NDSSdTfuQJLWNIKbyDE9ZS_dD5ma8cSGVxLiZ6rNWGxaTseRXU2nIBFWDorB0FGi5BF90e2pimXxCn1Y4QTbKLXvah-a1iYHc-kfpfk4wKRj6R1NMmhxPRixgF-R1e4023ek7JuquuX4R8f_io1_1r3b24Zq3hc0YBw9VFiWi6qvwgZEqsSSeDERKmhatUJgahXlQWxsktoRcHhCPwysuJHHSGoz4pi7CPG_EUtOt2iKnJMsRn9T-7mHbZyLzAEHwdXG8dg-Go2lFA3ubgLbpl7Y4K7vtXUYRsYdBhtVnpwB4CEgzmtzHlkenwjqD9KEb1YJ6W8STvS-Zhzw55fFPK8tci8jJ5yMzOLNBHLLRUaxDT5LnGpCyiMYQTZ9tefiFcsar_0mbepTiQTefkv6Ae1bzZOcVB5MKHiZbf8I3dCIc5mMyAzaJHnctmtX79UTtZ3fz34XpTBfmE02cZ3-QUzv2CNsI0P9Yvfl7lzcrn3anpYOdZhnZc_ZbRYvhl_a-HF2JregwEgwnc3OHHBM_PBtjI6PnGg-VGauP81qC5bhttW2rwQaOYOSG-_OOibgG4yb8vqGN44SmZ5Y400m0sYgRLryhJFqXLnI';
  static const String baseUrl = 'https://api4.thetvdb.com/v4';

  Future<List<dynamic>> fetchGenres() async {
    final genresUrl = Uri.parse('$baseUrl/genres');

    final response = await http.get(
      genresUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      List<dynamic> genres = responseBody['data'];
      return genres;
    } else {
      throw Exception('Failed to load genres: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchMoviesByGenre(int genreId, {int page = 1, int itemsPerPage = 20}) async {
    final moviesUrl = Uri.parse('$baseUrl/movies/filter?genre=$genreId&page=$page&pageSize=$itemsPerPage');

    final response = await http.get(
      moviesUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      List<dynamic> movies = responseBody['data'];
      return movies;
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }
}
class SearchService {
  static const String apiKey = '12e70dcf-0c55-4542-afe4-143b402a0424';
  static const String token =
      'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZ2UiOiIiLCJhcGlrZXkiOiIxMmU3MGRjZi0wYzU1LTQ1NDItYWZlNC0xNDNiNDAyYTA0MjQiLCJjb21tdW5pdHlfc3VwcG9ydGVkIjpmYWxzZSwiZXhwIjoxNzIxMDAyNTAwLCJnZW5kZXIiOiIiLCJoaXRzX3Blcl9kYXkiOjEwMDAwMDAwMCwiaGl0c19wZXJfbW9udGgiOjEwMDAwMDAwMCwiaWQiOiIyNDY3Nzc4IiwiaXNfbW9kIjpmYWxzZSwiaXNfc3lzdGVtX2tleSI6ZmFsc2UsImlzX3RydXN0ZWQiOmZhbHNlLCJwaW4iOiJzdHJpbmciLCJyb2xlcyI6W10sInRlbmFudCI6InR2ZGIiLCJ1dWlkIjoiIn0.UAAUice4LR_MdRgoPHyZ4dOWAV-iyrg6UY8NgvN1B8G_-irHT7ge_JpJM9TYbo4ur9FpwZ3NDSSdTfuQJLWNIKbyDE9ZS_dD5ma8cSGVxLiZ6rNWGxaTseRXU2nIBFWDorB0FGi5BF90e2pimXxCn1Y4QTbKLXvah-a1iYHc-kfpfk4wKRj6R1NMmhxPRixgF-R1e4023ek7JuquuX4R8f_io1_1r3b24Zq3hc0YBw9VFiWi6qvwgZEqsSSeDERKmhatUJgahXlQWxsktoRcHhCPwysuJHHSGoz4pi7CPG_EUtOt2iKnJMsRn9T-7mHbZyLzAEHwdXG8dg-Go2lFA3ubgLbpl7Y4K7vtXUYRsYdBhtVnpwB4CEgzmtzHlkenwjqD9KEb1YJ6W8STvS-Zhzw55fFPK8tci8jJ5yMzOLNBHLLRUaxDT5LnGpCyiMYQTZ9tefiFcsar_0mbepTiQTefkv6Ae1bzZOcVB5MKHiZbf8I3dCIc5mMyAzaJHnctmtX79UTtZ3fz34XpTBfmE02cZ3-QUzv2CNsI0P9Yvfl7lzcrn3anpYOdZhnZc_ZbRYvhl_a-HF2JregwEgwnc3OHHBM_PBtjI6PnGg-VGauP81qC5bhttW2rwQaOYOSG-_OOibgG4yb8vqGN44SmZ5Y400m0sYgRLryhJFqXLnI';

  static const String baseUrl = 'https://api4.thetvdb.com/v4';

  Future<Map<String, dynamic>> fetchSearchResults({
    required String language,
    required String country,
    int page = 1,
    int perPage = 20,
  }) async {
    final searchUrl = Uri.parse(
        '$baseUrl/movies/filter?country=$country&lang=$language&page=$page&perPage=$perPage');

    final response = await http.get(
      searchUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'data': responseBody['data'] ?? [],
        'currentPage': page,
        'totalPages': responseBody['links']['last'] ?? 1,
      };
    } else {
      throw Exception('Failed to load search results: ${response.statusCode}');
    }
  }
}