import 'package:dio/dio.dart';

abstract class QuoteService {
  Dio dio = Dio();
  String baseUrl = 'https://dummyjson.com/quotes';
  getQuotes();
}

class QuotesServiceImp extends QuoteService {
  @override
  getQuotes() async {
    try {
      Response response = await dio.get(baseUrl);
      print(response.data);
      if (response.statusCode == 200) {
        dynamic responseData = response.data['quotes'];
        return responseData;
      } else {
        return 'false';
      }
    } catch (e) {
      throw e;
    }
  }
}
