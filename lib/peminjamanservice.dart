import 'dart:convert';
import 'package:http/http.dart' as http;
import 'peminjaman.dart';

class PeminjamanService {
  final String apiUrl = "http://localhost/Data/peminjaman.php";

  Future<List<Peminjaman>> fetchPeminjaman() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Peminjaman.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load peminjaman');
    }
  }
}
