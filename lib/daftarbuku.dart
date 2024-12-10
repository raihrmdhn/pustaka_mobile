import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'PinjamForm.dart';  // Import halaman PinjamForm.dart

class Buku extends StatefulWidget {
  const Buku({Key? key}) : super(key: key);

  @override
  State<Buku> createState() => _BukuState();
}

class _BukuState extends State<Buku> {
  List _listdata = [];

  // Fungsi untuk mengambil data buku
  Future<void> _getdata() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/Data/readbuku.php'),
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

  // Fungsi untuk menambahkan buku baru
  void _createItem() async {
    final newData = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => _BukuDialog(),
    );
    if (newData != null) {
      // Simpan data baru ke server
      try {
        final response = await http.post(
          Uri.parse('http://localhost/Data/createbuku.php'),
          body: newData,
        );
        if (response.statusCode == 200) {
          _getdata();
        } else {
          print('Failed to create data. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error creating data: $e');
      }
    }
  }

  // Fungsi untuk memperbarui data buku
  void _updateItem(int index) async {
    final updatedData = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => _BukuDialog(buku: _listdata[index]),
    );
    if (updatedData != null) {
      // Update data di server
      try {
        final response = await http.post(
          Uri.parse('http://localhost/Data/updatebuku.php'),
          body: {
            'id': _listdata[index]['id'], // Mengirim id untuk update
            'judul': updatedData['judul']!,
            'pengarang': updatedData['pengarang']!,
            'penerbit': updatedData['penerbit']!,
            'tahun_terbit': updatedData['tahun_terbit']!,
            'gambar': updatedData['gambar']!,
          },
        );
        if (response.statusCode == 200) {
          _getdata();
        } else {
          print('Failed to update data. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error updating data: $e');
      }
    }
  }

  // Fungsi untuk menghapus data buku
  void _deleteItem(int index) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/Data/deletebuku.php'),
        body: {'id': _listdata[index]['id']},
      );
      if (response.statusCode == 200) {
        _getdata();
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
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Buku",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: _listdata.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Colors.black,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          _listdata[index]['gambar'] != null
                              ? Image.network(
                                  _listdata[index]['gambar'],
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                )
                              : const Text('Gambar tidak tersedia', style: TextStyle(color: Colors.white)),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              _listdata[index]['judul'] ?? 'Judul tidak tersedia',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _listdata[index]['pengarang'] ?? 'Pengarang tidak tersedia',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            _listdata[index]['penerbit'] ?? 'Penerbit tidak tersedia',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () => _updateItem(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteItem(index),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Arahkan ke halaman PinjamForm dengan passing judul buku
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PinjamForm(
                                  bukuId: _listdata[index]['id'],
                                  judul: _listdata[index]['judul'],
                                  pengarang: _listdata[index][['pengarang']]
                                  ,

                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Tombol berwarna hijau
                          ),
                          child: const Text('Pinjam', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createItem,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _BukuDialog extends StatelessWidget {
  final Map<String, dynamic>? buku;
  const _BukuDialog({Key? key, this.buku}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _judulController =
        TextEditingController(text: buku?['judul'] ?? '');
    final TextEditingController _pengarangController =
        TextEditingController(text: buku?['pengarang'] ?? '');
    final TextEditingController _penerbitController =
        TextEditingController(text: buku?['penerbit'] ?? '');
    final TextEditingController _tahunController =
        TextEditingController(text: buku?['tahun_terbit'] ?? '');
    final TextEditingController _gambarController =
        TextEditingController(text: buku?['gambar'] ?? '');

    return AlertDialog(
      title: Text(buku == null ? 'Tambah Buku' : 'Edit Buku'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _pengarangController,
              decoration: const InputDecoration(labelText: 'Pengarang'),
            ),
            TextField(
              controller: _penerbitController,
              decoration: const InputDecoration(labelText: 'Penerbit'),
            ),
            TextField(
              controller: _tahunController,
              decoration: const InputDecoration(labelText: 'Tahun Terbit'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _gambarController,
              decoration: const InputDecoration(labelText: 'URL Gambar'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'judul': _judulController.text,
              'pengarang': _pengarangController.text,
              'penerbit': _penerbitController.text,
              'tahun_terbit': _tahunController.text,
              'gambar': _gambarController.text,
            });
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
