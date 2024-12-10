import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mylibrary/peminjamanlist.dart';
import 'dart:convert';
// import 'peminjaman.dart';

class PinjamForm extends StatefulWidget {
  final String bukuId;
  final String judul; // Tambahkan judul buku
  final String pengarang; // Tambahkan pengarang buku

  const PinjamForm({
    super.key,
    required this.bukuId,
    required this.judul,
    required this.pengarang,
  });

  @override
  _PinjamFormState createState() => _PinjamFormState();
}

class _PinjamFormState extends State<PinjamForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _tanggalPinjam;
  DateTime? _tanggalKembali;

  Future<void> _selectDate(BuildContext context, bool isPinjam) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isPinjam) {
          _tanggalPinjam = picked;
        } else {
          _tanggalKembali = picked;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Simpan data ke database melalui API
      final response = await http.post(
        Uri.parse('http://localhost/Data/pinjam_buku.php'),
        body: {
          'buku_id': widget.bukuId,
          'judul': widget.judul,
          'pengarang': widget.pengarang,
          'tanggal_pinjam': _tanggalPinjam.toString(),
          'tanggal_kembali': _tanggalKembali.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success']) {
          // Navigasi ke halaman detail peminjaman setelah berhasil disimpan
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PeminjamanList()
            ),
          );
        } else {
          // Tampilkan pesan kesalahan dari API
          _showErrorDialog(data['message']);
        }
      } else {
        // Tampilkan pesan kesalahan jika terjadi masalah koneksi
        _showErrorDialog('Gagal menyimpan data. Coba lagi nanti.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kesalahan'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Peminjaman Buku'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tanggal Pinjam',
                  icon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                controller: TextEditingController(
                  text: _tanggalPinjam != null
                      ? "${_tanggalPinjam!.toLocal()}".split(' ')[0]
                      : '',
                ),
                onTap: () => _selectDate(context, true),
                validator: (value) {
                  if (_tanggalPinjam == null) {
                    return 'Tanggal pinjam harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tanggal Kembali',
                  icon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                controller: TextEditingController(
                  text: _tanggalKembali != null
                      ? "${_tanggalKembali!.toLocal()}".split(' ')[0]
                      : '',
                ),
                onTap: () => _selectDate(context, false),
                validator: (value) {
                  if (_tanggalKembali == null) {
                    return 'Tanggal kembali harus diisi';
                  }
                  if (_tanggalKembali!.isBefore(_tanggalPinjam!)) {
                    return 'Tanggal kembali tidak boleh sebelum tanggal pinjam';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Pinjam Buku'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
