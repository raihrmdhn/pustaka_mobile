import 'package:flutter/material.dart';
import 'package:mylibrary/user.dart';
import 'package:mylibrary/daftarbuku.dart';
import 'peminjamanlist.dart';
import 'package:mylibrary/pengembalian.dart';
//mport 'PinjamForm.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tombol User
              MenuButton(
                label: 'User',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const User()),
                  );
                },
              ),
              const SizedBox(height: 30.0),

              // Tombol Daftar Buku
              MenuButton(
                label: 'Daftar Buku',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Buku()),
                  );
                },
              ),
              const SizedBox(height: 30.0),

              // Tombol Peminjaman Buku
              MenuButton(
              label: 'Peminjaman',
              onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PeminjamanList()),
                   );
                 },
               ),
              const SizedBox(height: 30.0),

              // Tombol Pengembalian Buku
              MenuButton(
                label: 'Pengembalian Buku',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Pengembalian()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        child: Text(label),
      ),
    );
  }
}
