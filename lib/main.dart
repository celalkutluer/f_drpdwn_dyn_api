import 'package:flutter/material.dart';

import 'core/services/egitim_kategori_and_ad.dart';
import 'modal/egitim_kategori_and_ad_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Dynamic DropDown Service HTTP request example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///   JSON TEXT FOR MODAL
  ///   [{"egitim_kategori_id":"1","egitim_kategori_ad":"GENEL KONULAR","egitimler":[{"egitim_id":"1","egitim_ad":"GENEL KONULAR - TEMEL İSG EĞİTİMİ"}]},{"egitim_kategori_id":"2","egitim_kategori_ad":"SAĞLIK KONULARI","egitimler":[{"egitim_id":"4","egitim_ad":"SAĞLIK KONULARI VE İLKYARDIM EĞİTİMİ"}]},{"egitim_kategori_id":"3","egitim_kategori_ad":"TEKNİK KONULAR","egitimler":[{"egitim_id":"3","egitim_ad":"TEKNİK KONULAR TEMEL İSG"}]},{"egitim_kategori_id":"4","egitim_kategori_ad":"DİĞER KONULAR","egitimler":[{"egitim_id":"2","egitim_ad":"ACİL DURUM VE İŞ KAZALARI EĞİTİMİ"},{"egitim_id":"10","egitim_ad":"BAKIM ONARIM EĞİTİMİ"},{"egitim_id":"9","egitim_ad":"ELEKTRİK İŞLERİ EĞİTİMİ"},{"egitim_id":"7","egitim_ad":"HİJYEN EĞİTİMİ"},{"egitim_id":"5","egitim_ad":"İŞ MAKİNASI İLE GÜVENLİ ÇALIŞMA EĞİTİMİ"},{"egitim_id":"8","egitim_ad":"KAZI VE TOPRAK İŞLERİ EĞİTİMİ"},{"egitim_id":"12","egitim_ad":"PATLAMADAN KORUNMA DOKÜMANI EĞİTİMİ"},{"egitim_id":"11","egitim_ad":"RİSK ANALİZİ BİLGİLENDİRME EĞİTİMİ"},{"egitim_id":"13","egitim_ad":"TMGD EĞİTİMİ"},{"egitim_id":"6","egitim_ad":"YOL YAPIM ÇALIŞMALARI BİLGİLENDİRME EĞİTİMİ VE ASFALT Ç"},{"egitim_id":"14","egitim_ad":"YÜKSEKTE ÇALIŞMA EĞİTİMİ"}]}]
  ///   PHP BACKEND CODE
  ///   <?php
  // include "./settings/connection.php";
  //
  // date_default_timezone_set('Europe/Istanbul');
  // header("Content-Type: application/json; charset=utf-8");
  // header("Access-Control-Allow-Origin: *");
  // header("Access-Control-Allow-Methods: GET, POST, DELETE, PUT, PATCH, OPTIONS");
  // header("Access-Control-Allow-Headers: *");
  //
  // $Json = array();
  // $egitim_kategori_array = array();
  // $egitim_ad = array();
  // $veri = $db->prepare('SELECT * FROM egitim_kategori ');
  // $veri->execute(array());
  // $gelenveri = $veri->fetchAll(PDO::FETCH_ASSOC);
  // foreach ($gelenveri as $veriMap) {
  //     $egitim_kategori_array['egitim_kategori_id'] = ($veriMap['id']);
  //     $egitim_kategori_array['egitim_kategori_ad'] = ($veriMap['kategori_ad']);
  //     $egitim_kategori_array['egitimler']=array();
  //     /////////////////////////////////////////////////////////////////
  //     $veri2 = $db->prepare('SELECT * FROM egitim_ad WHERE egitim_kategori_id=?  ORDER BY egitim_ad ASC');
  //     $veri2->execute(array($veriMap['id']));
  //     $gelenveri2 = $veri2->fetchAll(PDO::FETCH_ASSOC);
  //     foreach ($gelenveri2 as $veriMap2) {
  //         $egitim_ad['egitim_id'] = ($veriMap2['id']);
  //         $egitim_ad['egitim_ad'] = ($veriMap2['egitim_ad']);
  //         array_push($egitim_kategori_array['egitimler'] ,$egitim_ad);
  //     }
  //     array_push($Json, $egitim_kategori_array);
  // }
  // echo json_encode($Json, JSON_UNESCAPED_UNICODE);
  ///
  List<EgitimKategoriAndAdModel> list = <EgitimKategoriAndAdModel>[];
  int selectedKategoriId;
  int selectedAdId;
  bool isBlock = false;
  @override
  void initState() {
    getEgitimKategori().then((value) {
      setState(() {
        list.addAll(value);
        selectedKategoriId = list[0].egitimKategoriId; //default val
        selectedAdId = list[0].egitimler[0].egitimId; //default val
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Eğitim Kategorileri'),
                value: selectedKategoriId,
                items: list.map((list) {
                      return DropdownMenuItem<int>(
                        value: list.egitimKategoriId,
                        child: Text(list.egitimKategoriAd),
                      );
                    }).toList() ??
                    [],
                onChanged: (stateId) {
                  setState(() {
                    selectedAdId = list.singleWhere((x) => x.egitimKategoriId == stateId).egitimler[0].egitimId;
                    selectedKategoriId = stateId;
                    isBlock = true;
                  });
                },
              ),
              isBlock
                  ? DropdownButtonFormField<int>(
                      key: UniqueKey(),
                      decoration: InputDecoration(labelText: 'Eğitim Adları'),
                      value: selectedAdId ?? 0,
                      items: list.singleWhere((x) => x.egitimKategoriId == selectedKategoriId).egitimler.map((ad) {
                            return DropdownMenuItem<int>(
                              value: ad.egitimId,
                              child: Text(list
                                  .singleWhere((x) => x.egitimKategoriId == selectedKategoriId)
                                  .egitimler
                                  .singleWhere((x) => x.egitimId == ad.egitimId)
                                  .egitimAd),
                            );
                          }).toList() ??
                          [],
                      onChanged: (ad) {
                        setState(() {
                          selectedAdId = ad;
                        });
                      },
                    )
                  : DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Eğitim Adları'),
                      value: 'Eğitim Adı Seçiniz',
                      items: [],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
