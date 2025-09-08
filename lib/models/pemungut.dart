class Pemungut {
  final int id;
  final String nama;
  final int targetNominal;
  final int sisaTagihan;
  final int targetTercapai;
  final double persentase;
  final int syncStatus;

  Pemungut({
    required this.id,
    required this.nama,
    required this.targetNominal,
    required this.sisaTagihan,
    required this.targetTercapai,
    required this.persentase,
    this.syncStatus = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'targetNominal': targetNominal,
      'sisaTagihan': sisaTagihan,
      'targetTercapai': targetTercapai,
      'persentase': persentase,
      'syncStatus': syncStatus,
    };
  }

  factory Pemungut.fromMap(Map<String, dynamic> map) {
    return Pemungut(
      id: map['id'],
      nama: map['nama'],
      targetNominal: map['targetNominal'],
      sisaTagihan: map['sisaTagihan'],
      targetTercapai: map['targetTercapai'],
      persentase: map['persentase'],
      syncStatus: map['syncStatus'],
    );
  }
}