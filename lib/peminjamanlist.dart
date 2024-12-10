import 'package:flutter/material.dart';
import 'peminjamanservice.dart';
import 'peminjaman.dart';

class PeminjamanList extends StatelessWidget {
  const PeminjamanList({super.key});

  @override
  Widget build(BuildContext context) {
    final PeminjamanService service = PeminjamanService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Peminjaman'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Peminjaman>>(
        future: service.fetchPeminjaman(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final peminjamanList = snapshot.data!;
            return ListView.builder(
              itemCount: peminjamanList.length,
              itemBuilder: (context, index) {
                final peminjaman = peminjamanList[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(peminjaman.judul),
                    subtitle: Text('Pengarang: ${peminjaman.pengarang}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pinjam: ${peminjaman.tanggalPinjam.toLocal()}'.split(' ')[0],
                        ),
                        Text(
                          'Kembali: ${peminjaman.tanggalKembali.toLocal()}'.split(' ')[0],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Tidak ada data.'));
          }
        },
      ),
    );
  }
}
