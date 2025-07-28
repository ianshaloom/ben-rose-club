class Transaction {
  final int rno;
  final String rcno;
  final double cash;
  final double bank;
  final double tcost;
  final String user;
  final DateTime sdate;
  // final String stime;
  final double examount;
  final String shstatus;
  final String cashier;
  final String payvia;
  final String shift;

  Transaction({
    required this.rno,
    required this.rcno,
    required this.cash,
    required this.bank,
    required this.tcost,
    required this.user,
    required this.sdate,
    // required this.stime,
    required this.examount,
    required this.shstatus,
    required this.cashier,
    required this.payvia,
    required this.shift,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Transaction.empty();

    return Transaction(
      rno: json['rno'] ?? 0,
      rcno: json['rcno'] ?? '',
      cash: ((json['cash'] as num?) ?? 0).toDouble(),
      bank: ((json['bank'] as num?) ?? 0).toDouble(),
      tcost: ((json['tcost'] as num?) ?? 0).toDouble(),
      user: json['user'] ?? '',
      sdate: DateTime.parse(json['sdate'] ?? DateTime.now().toIso8601String()),
      // stime: json['stime'] ?? '',
      examount: ((json['examount'] as num?) ?? 0).toDouble(),
      shstatus: json['shstatus'] ?? '',
      cashier: json['cashier'] ?? '',
      payvia: json['payvia'] ?? '',
      shift: json['shift'] ?? '',
    );
  }

  /// empty constructor
  Transaction.empty()
    : rno = 0,
      rcno = '',
      cash = 0.0,
      bank = 0.0,
      tcost = 0.0,
      user = '',
      sdate = DateTime.now(),
      // stime = '',
      examount = 0.0,
      shstatus = '',
      cashier = '',
      payvia = '',
      shift = '';

  /// getter
  bool get isCash => payvia == 'CASH';

  bool get isBank => payvia == 'BANK';

  bool get isCashNBank => payvia == 'CASH AND BANK';

  bool get isCashNBankOrEmpty => payvia == 'CASH AND BANK' || payvia.isEmpty;

  bool get payViaEmpty => payvia.isEmpty;

  double get amount {
    if (isCashNBankOrEmpty) {
      return cash + bank;
    }

    if (cash == 0) {
      return bank;
    }

    if (bank == 0) {
      return cash;
    }

    return 0;
  }

  /// DateTime Object from [sdate] and [stime]. [sdate] is in this format
  /// 2025-05-01 format while [stime] is in this format 12:00 in 24 hour format
  DateTime get dateTime {
    final date = DateTime.parse(sdate.toString());

    return date;
  }

  String  get stime {
    final date = DateTime.parse(sdate.toString());
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  /// toString
  @override
  String toString() {
    return 'Transaction{rno: $rno, rcno: $rcno, cash: $cash, bank: $bank, '
    'tcost: $tcost, user: $user, sdate: $sdate,'
    'examount: $examount, shstatus: $shstatus, cashier: $cashier, '
    'payvia: $payvia}';
  }
}
