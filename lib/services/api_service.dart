import 'dart:convert';
import 'dart:io';

class APIService {
  final String _baseUrl;

  APIService(this._baseUrl);

  Future<dynamic> get(String endpoint,
      [Map<String, dynamic>? queryParams]) async {
    final uri =
        Uri.parse('$_baseUrl$endpoint').replace(queryParameters: queryParams);
    final response =
        await HttpClient().getUrl(uri).then((request) => request.close());
    return _parseResponse(response);
  }

  Future<dynamic> _parseResponse(HttpClientResponse response) async {
    final statusCode = response.statusCode;
    final responseBody = await response.transform(utf8.decoder).join();

    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(responseBody);
    } else {
      throw HttpException(
          'HTTP request failed with status code $statusCode: $responseBody');
    }
  }
}
