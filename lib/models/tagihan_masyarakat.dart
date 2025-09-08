class TagihanMasyarakat {
  final int? tagihanId; // tagihanId bisa null untuk data baru
  final String nop;
  final int jumlah;
  final int sisaTagihan;
  final String keterangan;
  final String tanggalTagihan;
  final String? tanggalLunas;
  final String nama;
  final String alamat;
  final int statusLunas;
  final int syncStatus;

  TagihanMasyarakat({
    this.tagihanId,
    required this.nop,
    required this.jumlah,
    required this.sisaTagihan,
    required this.keterangan,
    required this.tanggalTagihan,
    this.tanggalLunas,
    required this.nama,
    required this.alamat,
    required this.statusLunas,
    this.syncStatus = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'tagihanId': tagihanId,
      'nop': nop,
      'jumlah': jumlah,
      'sisaTagihan': sisaTagihan,
      'keterangan': keterangan,
      'tanggalTagihan': tanggalTagihan,
      'tanggalLunas': tanggalLunas,
      'nama': nama,
      'alamat': alamat,
      'statusLunas': statusLunas,
      'syncStatus': syncStatus,
    };
  }

  factory TagihanMasyarakat.fromMap(Map<String, dynamic> map) {
    return TagihanMasyarakat(
      tagihanId: map['tagihanId'],
      nop: map['nop'],
      jumlah: map['jumlah'],
      sisaTagihan: map['sisaTagihan'],
      keterangan: map['keterangan'],
      tanggalTagihan: map['tanggalTagihan'],
      tanggalLunas: map['tanggalLunas'],
      nama: map['nama'],
      alamat: map['alamat'],
      statusLunas: map['statusLunas'],
      syncStatus: map['syncStatus'],
    );
  }
}