import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final String type; // 'deposit', 'withdraw', 'transfer', 'payment'
  final double amount;
  final String currency;
  final DateTime date;
  final String status;

  Transaction({
    required this.id,
    required this.title,
    required this.type,
    required this.amount,
    required this.currency,
    required this.date,
    this.status = 'مكتملة',
  });
}

class WalletProvider with ChangeNotifier {
  double _yerBalance = 1250000;
  double _sarBalance = 5400;
  double _usdBalance = 1200;
  final List<Transaction> _transactions = [];

  double get yerBalance => _yerBalance;
  double get sarBalance => _sarBalance;
  double get usdBalance => _usdBalance;
  List<Transaction> get transactions => _transactions;

  WalletProvider() {
    _generateMockTransactions();
  }

  void _generateMockTransactions() {
    for (int i = 1; i <= 10; i++) {
      _transactions.add(Transaction(
        id: 'TX$i',
        title: i % 2 == 0 ? 'إيداع نقدي' : 'سداد فاتورة إنترنت',
        type: i % 2 == 0 ? 'deposit' : 'payment',
        amount: (i * 2500).toDouble(),
        currency: 'YER',
        date: DateTime.now().subtract(Duration(days: i)),
      ));
    }
  }

  Future<bool> processTransaction({
    required String serviceName,
    required double amount,
    required String currency,
    required Map<String, dynamic> details,
  }) async {
    // Simulate API processing
    await Future.delayed(const Duration(seconds: 2));
    
    bool success = false;
    if (currency == 'YER' && _yerBalance >= amount) {
      _yerBalance -= amount;
      success = true;
    } else if (currency == 'SAR' && _sarBalance >= amount) {
      _sarBalance -= amount;
      success = true;
    } else if (currency == 'USD' && _usdBalance >= amount) {
      _usdBalance -= amount;
      success = true;
    }

    if (success) {
      _transactions.insert(0, Transaction(
        id: 'TX${DateTime.now().millisecondsSinceEpoch}',
        title: serviceName,
        type: 'payment',
        amount: amount,
        currency: currency,
        date: DateTime.now(),
      ));
      notifyListeners();
    }
    return success;
  }

  void deposit(double amount, String currency) {
    if (currency == 'YER') _yerBalance += amount;
    if (currency == 'SAR') _sarBalance += amount;
    if (currency == 'USD') _usdBalance += amount;
    
    _transactions.insert(0, Transaction(
      id: 'TX${DateTime.now().millisecondsSinceEpoch}',
      title: 'إيداع رصيد',
      type: 'deposit',
      amount: amount,
      currency: currency,
      date: DateTime.now(),
    ));
    notifyListeners();
  }
}
