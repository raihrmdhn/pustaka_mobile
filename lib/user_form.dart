import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserForm extends StatefulWidget {
  final String? id;
  final String? nim;
  final String? nama;
  final String? alamat;
  final String? jenisKelamin;
  final String? password;

  const UserForm({
    Key? key,
    this.id,
    this.nim,
    this.nama,
    this.alamat,
    this.jenisKelamin,
    this.password,
  }) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _nim, _nama, _alamat, _jenisKelamin, _password;

  @override
  void initState() {
    super.initState();
    _nim = widget.nim;
    _nama = widget.nama;
    _alamat = widget.alamat;
    _jenisKelamin = widget.jenisKelamin;
    _password = widget.password;
  }

  Map<String, String> _buildHeaders() {
    return {'Content-Type': 'application/json'};
  }

  Future<void> submitData(String url, Map<String, String> data, String method) async {
    try {
      final response = method == 'POST'
          ? await http.post(Uri.parse(url), body: json.encode(data), headers: _buildHeaders())
          : await http.put(Uri.parse(url), body: json.encode(data), headers: _buildHeaders());

      if (response.statusCode == 200) {
        print('Data berhasil dikirim');
      } else {
        print('Gagal mengirim data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteData(String url, Map<String, String> data) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: _buildHeaders(),
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['message'] != null) {
          print('Data berhasil dihapus');
          Navigator.pop(context); // Navigasi kembali setelah berhasil
        } else {
          print('Error: ${responseData['error']}');
        }
      } else {
        print('Gagal menghapus data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final url = 'http://localhost/Data/create_user.php';

      Map<String, String> data = {
        'nim': _nim!,
        'nama': _nama!,
        'alamat': _alamat!,
        'jenisKelamin': _jenisKelamin!,
        'password': _password!,
      };

      if (widget.id == null) {
        submitData(url, data, 'POST');
      } else {
        data['id'] = widget.id!;
        submitData(url, data, 'PUT');
      }

      Navigator.pop(context);
    }
  }

  void _deleteData() {
    final url = 'http://localhost/Data/delete.php';
    Map<String, String> data = {
      'id': widget.id!, // Mengirim ID untuk penghapusan
    };
    deleteData(url, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form User'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _nim,
                decoration: const InputDecoration(labelText: 'NIM'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM harus diisi';
                  }
                  return null;
                },
                onSaved: (value) => _nim = value,
              ),
              TextFormField(
                initialValue: _nama,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
                onSaved: (value) => _nama = value,
              ),
              TextFormField(
                initialValue: _alamat,
                decoration: const InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat harus diisi';
                  }
                  return null;
                },
                onSaved: (value) => _alamat = value,
              ),
              TextFormField(
                initialValue: _jenisKelamin,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis Kelamin harus diisi';
                  }
                  return null;
                },
                onSaved: (value) => _jenisKelamin = value,
              ),
              TextFormField(
                initialValue: _password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password harus diisi';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, 
                ),
              ),
              if (widget.id != null) 
                ElevatedButton(
                  onPressed: _deleteData,
                  child: const Text('Hapus'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, 
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
