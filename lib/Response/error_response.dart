class ErrorResponse {
  late String _code;
  late String _message;
  late String _errorData;

  String get message => _message;
  String get code => _code;
  String get errorData => _errorData;

  ErrorResponse({required code, required message, required errorData}) {
    _code = code;
    _message = message;
    _errorData = errorData;
  }

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _errorData = json['errorData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] =code;
    data['message'] = message;
    data['errorData'] =errorData;
    return data;
  }
}
