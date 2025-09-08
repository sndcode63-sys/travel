import 'package:http/http.dart' as http;
import 'dart:io';

class NetworkExceptions {
  static String fromHttpError(Object e) {
    if (e is SocketException) return "No Internet connection";
    if (e is HttpException) return "HTTP error";
    if (e is FormatException) return "Bad response format";
    return "Unexpected error";
  }

  static String handleResponse(http.Response r) {
    switch (r.statusCode) {
      case 400: return "Bad Request";
      case 401: return "Unauthorized";
      case 403: return "Forbidden";
      case 404: return "Not Found";
      case 409: return "Conflict";
      case 422: return "Unprocessable Entity";
      case 500: return "Internal Server Error";
      case 502: return "Bad Gateway";
      case 503: return "Service Unavailable";
      default: return "HTTP ${r.statusCode}";
    }
  }
}
