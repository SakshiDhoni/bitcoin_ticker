import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/fetchcurr.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// {
// "time": "2024-06-07T17:55:28.0000000Z",
// "asset_id_base": "BTC",
// "asset_id_quote": "INR",
// "rate": 5896167.0221429035892468982285
// }

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurr = 'USD';
  String from = 'BTC';

  currModel currency = currModel();

  CupertinoPicker getDropDownInIOS(){
    List<Text> pickerItem = [];
    for(String curr in currenciesList){
        pickerItem.add(Text(curr));
    }
    return CupertinoPicker(
      itemExtent:32.0,
      onSelectedItemChanged: (selecetedIndex) {print(selecetedIndex);},
      children: pickerItem ,
      backgroundColor: Colors.black,
    );
  }

  DropdownButton2<String> getDropDownInAndroid(List<String> currencies,String select){
    List<DropdownMenuItem<String>> dropdownitem = [];
    for(int i = 0; i < currencies.length; i++){
      String currency = currencies[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownitem.add(newItem);
    }

    return DropdownButton2<String>(
      value: select,
      items: dropdownitem,
        onChanged: (value) {
          setState(() {
            select = value!;
            if (currencies == currenciesList) {
              selectedCurr = select;
            } else {
              from = select;
            }
            Value();
          });
        },
      style: TextStyle(
        color: Colors.white,
      ),

      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        offset: const Offset(-20, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(10),
        ),
      ),
    );
  }

  String finalValue = '';

  void Value() async{
    var data = await currency.getCurrentvalue(from , selectedCurr);
   setState(() {
     finalValue = data.toStringAsFixed(0);
   });
  }

  @override

  void initState(){
    super.initState();
    Value();
  }
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
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $from = $finalValue $selectedCurr',
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
                  color: Colors.black,
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100.0,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 30.0),
                        color: Colors.black,
                        child:Platform.isIOS?getDropDownInIOS():getDropDownInAndroid(cryptoList,from),
                      ),

                                Container(
                    height: 100.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 30.0),
                    color: Colors.black,
                    child:Platform.isIOS?getDropDownInIOS():getDropDownInAndroid(currenciesList , selectedCurr),
                  ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

