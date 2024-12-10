import 'package:flutter/material.dart';

class FormBuku extends StatefulWidget {
  final Map<String, dynamic>? buku; // Untuk update data
  const FormBuku({Key? key, this.buku}) : super(key: key);

  @override
  State<FormBuku> createState() => _FormBukuState();
}

class _FormBukuState extends State<FormBuku> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _pengarangController = TextEditingController();
  final TextEditingController _penerbitController = TextEditingController();
  final TextEditingController _tahunTerbitController = TextEditingController();
  final TextEditingController _gambarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.buku != null) {
      _judulController.text = widget.buku!['judul'] ?? '';
      _pengarangController.text = widget.buku!['pengarang'] ?? '';
      _penerbitController.text = widget.buku!['penerbit'] ?? '';
      _tahunTerbitController.text = widget.buku!['tahun_terbit'] ?? '';
      _gambarController.text = widget.buku!['gambar'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.buku == null ? "Tambah Buku" : "Edit Buku"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(labelText: "Judul"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Judul wajib diisi" : null,
              ),
              TextFormField(
                controller: _pengarangController,
                decoration: const InputDecoration(labelText: "Pengarang"),
              ),
              TextFormField(
                controller: _penerbitController,
                decoration: const InputDecoration(labelText: "Penerbit"),
              ),
              TextFormField(
                controller: _tahunTerbitController,
                decoration: const InputDecoration(labelText: "Tahun Terbit"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _gambarController,
                decoration: const InputDecoration(labelText: "URL Gambar"),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final data = {
                      "judul": _judulController.text,
                      "pengarang": _pengarangController.text,
                      "penerbit": _penerbitController.text,
                      "tahun_terbit": _tahunTerbitController.text,
                      "gambar": _gambarController.text,
                    };
                    Navigator.pop(context, data);
                  }
                },
                child: Text(widget.buku == null ? "Simpan" : "Update"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
