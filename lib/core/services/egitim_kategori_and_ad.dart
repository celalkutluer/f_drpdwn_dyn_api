import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../modal/egitim_kategori_and_ad_model.dart';
import '../constants/app_constants.dart';

Future<List<EgitimKategoriAndAdModel>> getEgitimKategori() async {
  var _url = '$BASE_URL';
  final _response = await http.get(Uri.parse(_url));
  print(_url);
  List<EgitimKategoriAndAdModel> _list = <EgitimKategoriAndAdModel>[];
  if (_response.statusCode == 200) {
    print(_response);
    final _mapJson = json.decode(_response.body);
    for (var _mapJson in _mapJson) {
      _list.add(EgitimKategoriAndAdModel.fromJson(_mapJson));
    }
    return _list;
  } else {
    throw Exception('Failed to load jobs from API');
  }
}
