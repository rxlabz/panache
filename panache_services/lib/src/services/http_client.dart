// import 'package:http/http.dart' as http;

// class GoogleHttpClient extends http.BaseClient {
//   GoogleHttpClient(this._headers) : super();
//   final Map<String, String> _headers;
//   http.Client _inner = new http.Client();

//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) =>
//       _inner.send(request..headers.addAll(_headers));

//   @override
//   Future<http.Response> head(Object url, {Map<String, String> headers}) =>
//       _inner.head(url, headers: headers..addAll(_headers));
// }
