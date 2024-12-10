class Peminjaman {
  final int id;
  final String judul;
  final String pengarang;
  final DateTime tanggalPinjam;
  final DateTime tanggalKembali;

  Peminjaman({
    required this.id,
    required this.judul,
    required this.pengarang,
    required this.tanggalPinjam,
    required this.tanggalKembali,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
      id: json['id'],
      judul: json['judul'],
      pengarang: json['pengarang'],
      tanggalPinjam: DateTime.parse(json['tanggal_pinjam']),
      tanggalKembali: DateTime.parse(json['tanggal_kembali']),
    );
  }
}
