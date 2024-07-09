import 'networking.dart';
import 'dart:async';

const ApiKey = 'E78CD5A3-5F71-4F40-9A70-AC258C0961D5';
const constUrl = 'https://rest.coinapi.io/v1/exchangerate';

class currModel{


  Future<dynamic> getCurrentvalue(String From ,String To) async{
    var url = ('$constUrl/$From/$To?apikey=$ApiKey');
    netWork getValue = netWork(url: url);
    var currData = await getValue.getDATA();
    return currData;
  }
}