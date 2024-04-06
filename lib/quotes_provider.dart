import 'package:flutter/material.dart';

class QuotesProvider extends ChangeNotifier {
  List<String> _quotes = [];
  List<String> get quotes => _quotes;
  void addQuotes(String quote) {
    final isExist = _quotes.contains(quote);
    if (isExist) {
      _quotes.remove(quote);
    } else {
      _quotes.add(quote);
      print('fjf');
    }
    notifyListeners();
  }

  bool isExist(String quote) {
    final isExist = _quotes.contains(quote);
    return isExist;
  }

  void clearFavoite() {
    _quotes = [];
    notifyListeners();
  }
}
