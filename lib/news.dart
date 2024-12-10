import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'News',
     // Menentukan halaman awal
  ));
}

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<Widget> daftarnews = [];

  var berita = [
    {"nama": "BRAWL START", "gambar": "assets/news/brawl.jpeg"},
    {"nama": "COUNTER STRIKE", "gambar": "assets/news/cs.jpeg"},
    {"nama": "MINECRAFT", "gambar": "assets/news/minecraft.jpeg"},
    {"nama": "FREE FIRE", "gambar": "assets/news/ff.jpg"},
    {"nama": "PUBG", "gambar": "assets/news/pubg.jpg"},
    {"nama": "STUMBLE GUYS", "gambar": "assets/news/stumble.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    _buatlist();
  }

  // Membuat daftar widget berita
  _buatlist() {
    for (var i = 0; i < berita.length; i++) {
      final beritanya = berita[i];
      daftarnews.add(
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Hero(
                tag: beritanya['nama']!, // Tag harus unik dan tidak null
                child: Material(
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Detail(
                          nama: beritanya["nama"] ?? 'Nama tidak tersedia',
                          gambar:
                              beritanya["gambar"] ?? 'assets/news/default.jpeg',
                        ),
                      ),
                    ),
                    child: Image.asset(
                      beritanya['gambar'] ?? 'assets/news/default.jpeg',
                      fit: BoxFit.cover,
                      width: 200.0, // Menentukan ukuran gambar
                      height: 147.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5.0), // Spasi antara gambar dan teks
              // Teks nama berita
              Text(
                beritanya['nama'] ?? 'Nama tidak tersedia',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }
    setState(() {}); // Memperbarui UI setelah widget dibuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('News', style: TextStyle(color: Colors.white)),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Dua kolom dalam grid
        children: daftarnews, // Menampilkan daftar berita
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail({super.key, required this.nama, required this.gambar});

  final String nama;
  final String gambar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(nama, style: const TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          Container(
            height: 240,
            child: Image.asset(
              gambar,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              nama,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Info(),
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
            style: const TextStyle(fontSize: 18.0),
            textAlign: TextAlign.justify, // Merapikan teks dengan justify
          ),
        ),
      ),
    );
  }
}
