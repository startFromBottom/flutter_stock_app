import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = "https://www.alphavantage.co/";
  static const apiKey = "NGJJN585XEER73S7";

  final http.Client _client;

  StockApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getListings({String apiKey = apiKey}) async {
    return await _client.get(
      Uri.parse(
        'https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=$apiKey',
      ),
    );
  }
}