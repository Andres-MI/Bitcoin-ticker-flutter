import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String cryptoCoinUrl = "https://rest.coinapi.io/v1/exchangerate";
const String apiKey = "14595F6C-A0B3-47FA-8722-1323882FD32E";

class CoinData {

  Future<dynamic> getCoinData({required String crypto, required String fiat}) async {
    Uri url = Uri.parse("$cryptoCoinUrl/$crypto/$fiat?apikey=$apiKey");
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      var decodedData = jsonDecode(response.body);
      return decodedData;
    } else{
      print(response.statusCode);
    }
  }
}
