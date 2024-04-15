import 'dart:convert';
import 'dart:io';
import 'package:dvt_interview/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('APIService', () {
    late HttpServer mockServer;
    late APIService apiService;
    setUp(() async {
      // Start a mock server
      mockServer = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      // Initialize the API service with the mock server's base URL
      apiService =
          APIService('http://${mockServer.address.host}:${mockServer.port}');
      // Define responses for the mock server
      mockServer.listen((HttpRequest request) {
        final path = request.uri.path;
        if (path == '/success') {
          request.response
            ..statusCode = HttpStatus.ok
            ..headers.contentType = ContentType.json
            ..write(jsonEncode({'status': 'success'}))
            ..close();
        } else if (path == '/client-error') {
          request.response
            ..statusCode = HttpStatus.badRequest
            ..close();
        } else if (path == '/server-error') {
          request.response
            ..statusCode = HttpStatus.internalServerError
            ..close();
        } else if (path == '/malformed') {
          request.response
            ..statusCode = HttpStatus.ok
            ..write('This is not a JSON')
            ..close();
        }
      });
    });

    tearDown(() async {
      // Shut down the mock server
      await mockServer.close();
    });

    test('get method returns data on success', () async {
      final result = await apiService.get('/success');
      expect(result, isA<Map<String, dynamic>>());
      expect(result['status'], 'success');
    });

    test('get method throws HttpException on client error', () {
      expect(apiService.get('/client-error'), throwsA(isA<HttpException>()));
    });

    test('get method throws HttpException on server error', () {
      expect(apiService.get('/server-error'), throwsA(isA<HttpException>()));
    });

    test('get method throws FormatException on malformed response', () {
      expect(apiService.get('/malformed'), throwsA(isA<FormatException>()));
    });
  });
}
