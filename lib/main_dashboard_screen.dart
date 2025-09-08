import 'package:flutter/material.dart';
import 'package:Simpari/database/database_helper.dart';
import 'package:Simpari/models/pemungut.dart';
import 'package:Simpari/models/tagihan_masyarakat.dart';
import 'package:Simpari/utils/currency_formatter.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({Key? key}) : super(key: key);

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  Pemungut? pemungutData;
  List<TagihanMasyarakat> masyarakatList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataFromDatabase();
  }

  Future<void> _fetchDataFromDatabase() async {
    setState(() {
      isLoading = true;
    });

    try {
      final dbHelper = DatabaseHelper.instance;

      final pemungutMap = await dbHelper.getSinglePemungut();
      final pemungut = Pemungut.fromMap(pemungutMap);

      final List<Map<String, dynamic>> tagihanMaps = await dbHelper
          .getMasyarakatTagihan();
      final tagihanList = tagihanMaps
          .map((map) => TagihanMasyarakat.fromMap(map))
          .toList();

      setState(() {
        pemungutData = pemungut;
        masyarakatList = tagihanList;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (pemungutData == null) {
      return const Scaffold(
        body: Center(child: Text('Data pemungut tidak ditemukan.')),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 0, 35, 65),
              Color.fromARGB(255, 39, 116, 184), // Biru tua
              Colors.white, // Putih
            ],
          ),
        ),
        child: Column(
          children: [
            // Padding untuk seluruh konten di atas ListView
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  // Mengubah warna teks header agar kontras dengan gradien biru
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Halo, ${pemungutData!.nama}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .white, // Teks putih agar terlihat di area biru
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            onPressed: _fetchDataFromDatabase,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Bagian Pencapaian, Sisa, dan Search Bar
                  const Text(
                    'Pencapaian',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: pemungutData!.persentase / 100,
                    backgroundColor: Colors.white,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.greenAccent,
                    ),
                    minHeight: 15,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${formatCurrency(pemungutData!.targetTercapai)} / ${formatCurrency(pemungutData!.targetNominal)}',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sisa',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatCurrency(pemungutData!.sisaTagihan),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF9A825),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Cari nomor pajak',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white24,
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 234, 99, 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cari',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),

            // Daftar Tagihan Pajak (ListView)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 0.0,
                ),
                itemCount: masyarakatList.length,
                itemBuilder: (context, index) {
                  final taxpayer = masyarakatList[index];
                  final isLunas = taxpayer.statusLunas == 1;

                  // Use a regular Card for contrast with the gradient background
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                taxpayer.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'NOP: ${taxpayer.nop}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Logic for Cek/Lunas button
                              print('Button for ${taxpayer.nama} clicked.');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isLunas
                                  ? Colors.green[600]
                                  : Colors.orange[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              isLunas ? 'Lunas' : 'Cek',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
