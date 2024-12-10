import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_form.dart';  // Impor UserForm

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  List _listdata = [];

  Future<void> _getData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/Data/read.php'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _deleteData(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/Data/delete.php'),
        body: {'id': id},
      );

      if (response.statusCode == 200) {
        setState(() {
          _listdata.removeWhere((item) => item['id'] == id);
        });
        print('Data deleted successfully.');
      } else {
        print('Failed to delete data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar User",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: _listdata.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(_listdata[index]['nim'] ?? 'NIM tidak tersedia'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_listdata[index]['nama'] ?? 'Nama tidak tersedia'),
                        Text(_listdata[index]['alamat'] ?? 'Alamat tidak tersedia'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserForm(
                                  id: _listdata[index]['id'],
                                  nim: _listdata[index]['nim'],
                                  nama: _listdata[index]['nama'],
                                  alamat: _listdata[index]['alamat'],
                                  jenisKelamin: _listdata[index]['jenis_kelamin'],
                                  password: _listdata[index]['password'],
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteData(_listdata[index]['id']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserForm()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
