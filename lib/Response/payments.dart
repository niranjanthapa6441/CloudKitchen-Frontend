class PaymentResponse {
  late String _code;
  late String _message;
  late Data _data;
  String get code => _code;
  String get message => _message;
  Data get data => _data;

  PaymentResponse({required code, required message, required data}) {
    _code = code;
    _message = message;
    _data = data;
  }

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late List<Payments> _payments;
  late int _currentPage;
  late int _totalElements;
  late int _totalPages;
  List<Payments> get payments => _payments;
  int get currentPage => _currentPage;
  int get totalElements => _totalElements;
  int get totalPages => _totalPages;
  Data(
      {required payments,
      required currentPage,
      required totalElements,
      required totalPages}) {
    _payments = payments;
    _totalElements = totalElements;
    _totalPages = totalPages;
    _currentPage = currentPage;
  }

  Data.fromJson(Map<String, dynamic> json) {
    if (json['payments'] != null) {
       _payments = <Payments>[];
      json['payments'].forEach((v) {
        _payments.add(Payments.fromJson(v));
      });
    }
    _currentPage = json['currentPage'];
    _totalElements = json['totalElements'];
    _totalPages = json['totalPages'];
  }
}

class Payments {
  late double _paidAmount;
  late String _paymentDate;
  late String _paymentTime;
  late String _paymentMethod;
  late String _paymentPartner;
  late String _status;

  double get paidAmount => _paidAmount;
  String get paymentDate => _paymentDate;
  String get paymentTime => _paymentTime;
  String get paymentMethod => _paymentMethod;
  String get paymentPartner => _paymentPartner;
  String get status => _status;

  Payments(
      {required paidAmount,
      required paymentDate,
      required paymentTime,
      required paymentMethod,
      required paymentPartner,
      required status}) {
    _paidAmount = paidAmount;
    _paymentDate = paymentDate;
    _paymentTime = paymentTime;
    _paymentMethod = paymentMethod;
    _paymentPartner = paymentPartner;
    _status = status;
  }

  Payments.fromJson(Map<String, dynamic> json) {
    _paidAmount = json['paidAmount'];
    _paymentDate = json['paymentDate'];
    _paymentTime = json['paymentTime'];
    _paymentMethod = json['paymentMethod'];
    _paymentPartner = json['paymentPartner'];
    _status = json['status'];
  }
}
