import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:Simpari/models/pemungut.dart';
import 'package:Simpari/models/tagihan_masyarakat.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pajak_pbb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const pemungutTableSql = '''
      CREATE TABLE Pemungut (
        id INTEGER PRIMARY KEY,
        nama TEXT,
        targetNominal INTEGER,
        sisaTagihan INTEGER,
        targetTercapai INTEGER,
        persentase REAL,
        syncStatus INTEGER
      )
    ''';

    const tagihanTableSql = '''
      CREATE TABLE TagihanMasyarakat (
        tagihanId INTEGER PRIMARY KEY,
        nop TEXT,
        jumlah INTEGER,
        sisaTagihan INTEGER,
        keterangan TEXT,
        tanggalTagihan TEXT,
        tanggalLunas TEXT,
        nama TEXT,
        alamat TEXT,
        statusLunas INTEGER,
        syncStatus INTEGER
      )
    ''';

    await db.execute(pemungutTableSql);
    await db.execute(tagihanTableSql);
  }

  // Fungsi untuk mengambil data Pemungut
  Future<Map<String, dynamic>> getSinglePemungut() async {
    final db = await instance.database;
    final result = await db.query('Pemungut', limit: 1);
    return result.isNotEmpty ? result.first : {};
  }

  // Fungsi untuk mengambil data TagihanMasyarakat
  Future<List<Map<String, dynamic>>> getMasyarakatTagihan() async {
    final db = await instance.database;
    return await db.query('TagihanMasyarakat');
  }
  // TODO: Tambahkan fungsi CRUD di sini
  Future<void> prepopulateDatabase() async {
    final db = await instance.database;

    // Hapus data lama (hanya untuk dev mode)
    await db.delete('Pemungut');
    await db.delete('TagihanMasyarakat');

    // Ambil data dummy dari file JSON
    final String response = await rootBundle.loadString('assets/data/dummy_data.json');
    final data = json.decode(response);

    // Masukkan data pemungut
    final pemungutData = Pemungut.fromMap({
      'id': data['pemungut']['id'],
      'nama': data['pemungut']['nama'],
      'targetNominal': data['pemungut']['target_nominal'],
      'sisaTagihan': data['pemungut']['sisa_tagihan'],
      'targetTercapai': data['pemungut']['target_tercapai'],
      'persentase': data['pemungut']['persentase'],
      'syncStatus': 0, // Awalnya sudah sinkron
    });
    await db.insert('Pemungut', pemungutData.toMap());

    // Masukkan data masyarakat
    final masyarakatList = data['masyarakat'] as List;
    for (var item in masyarakatList) {
      final tagihan = TagihanMasyarakat.fromMap({
        'tagihanId': item['tagihan_id'],
        'nop': item['nop'],
        'jumlah': item['jumlah'],
        'sisaTagihan': item['sisa_tagihan'],
        'keterangan': item['keterangan'],
        'tanggalTagihan': item['tanggal_tagihan'],
        'tanggalLunas': item['tanggal_lunas'],
        'nama': item['nama'],
        'alamat': item['alamat'],
        'statusLunas': item['status_lunas'],
        'syncStatus': 0, // Awalnya sudah sinkron
      });
      await db.insert('TagihanMasyarakat', tagihan.toMap());
    }
  }

  // TODO: Tambahkan fungsi CRUD lainnya
}