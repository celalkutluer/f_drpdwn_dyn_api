class EgitimKategoriAndAdModel {
  int egitimKategoriId;
  String egitimKategoriAd;
  List<Egitimler> egitimler;

  EgitimKategoriAndAdModel({this.egitimKategoriId, this.egitimKategoriAd, this.egitimler});

  EgitimKategoriAndAdModel.fromJson(Map<String, dynamic> json) {
    egitimKategoriId = int.parse(json['egitim_kategori_id']);
    egitimKategoriAd = json['egitim_kategori_ad'];
    if (json['egitimler'] != null) {
      egitimler = <Egitimler>[];
      json['egitimler'].forEach((v) {
        egitimler.add(new Egitimler.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['egitim_kategori_id'] = this.egitimKategoriId;
    data['egitim_kategori_ad'] = this.egitimKategoriAd;
    if (this.egitimler != null) {
      data['egitimler'] = this.egitimler.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Egitimler {
  int egitimId;
  String egitimAd;

  Egitimler({this.egitimId, this.egitimAd});

  Egitimler.fromJson(Map<String, dynamic> json) {
    egitimId = int.parse(json['egitim_id']);
    egitimAd = json['egitim_ad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['egitim_id'] = this.egitimId;
    data['egitim_ad'] = this.egitimAd;
    return data;
  }
}
