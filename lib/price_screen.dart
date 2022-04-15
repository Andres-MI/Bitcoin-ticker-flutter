import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  String totalExchange = '?';
  CoinData coinData = CoinData();

  CupertinoPicker iOSPicker(){
    List<Text> pickerItems = [];
    for(String currency in currenciesList){
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(itemExtent: 32.0, onSelectedItemChanged: (selectedIndex){
      selectedCurrency = currenciesList[selectedIndex];
      updateUI();
    }, children: pickerItems);
  }

  DropdownButton androidDropdown(){
    List <DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency,);
      dropdownItems.add(newItem);
    }
     return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
            updateUI();
          });
        });
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $totalExchange $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown()
          ),
        ],
      ),
    );
  }

  Future<void> updateUI() async {
    var exchangeData = await coinData.getCoinData(crypto: 'BTC', fiat: selectedCurrency);
    if(exchangeData == null){
      totalExchange = '??';
    } else {
      setState(() {
        totalExchange = exchangeData.toStringAsFixed(2);
      });
    }
  }
}
