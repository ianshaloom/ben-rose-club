class Transaction {
  final int rno;
  final String rcno;
  final double cash;
  final double bank;
  final double tcost;
  final String user;
  final DateTime sdate;
  final String stime;
  final double examount;
  final String ret;
  final String shstatus;
  final String cashier;
  final String cno;
  final String cname;
  final String ref;
  final double debit;
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
    required this.stime,
    required this.examount,
    required this.ret,
    required this.shstatus,
    required this.cashier,
    required this.cno,
    required this.cname,
    required this.ref,
    required this.debit,
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
      stime: json['stime'] ?? '',
      examount: ((json['examount'] as num?) ?? 0).toDouble(),
      ret: json['ret'] ?? '',
      shstatus: json['shstatus'] ?? '',
      cashier: json['cashier'] ?? '',
      cno: json['cno'] ?? '',
      cname: json['cname'] ?? '',
      ref: json['ref'] ?? '',
      debit: ((json['debit'] as num?) ?? 0).toDouble(),
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
      stime = '',
      examount = 0.0,
      ret = '',
      shstatus = '',
      cashier = '',
      cno = '',
      cname = '',
      ref = '',
      debit = 0.0,
      payvia = '',
      shift = '';

  /// getter
  bool get isCash => payvia == 'CASH';

  bool get isBank => payvia == 'BANK';

  bool get payViaEmpty => payvia.isEmpty;

  double get amount {
    if (cash == 0) {
      return bank;
    }

    if (bank == 0) {
      return cash;
    }

    return 0;
  }
}

/*    {
        "rno": 92034,
        "rcno": "59970",
        "cash": 0,
        "bank": 2500,
        "tcost": 1506,
        "user": "Shiku",
        "sdate": "2025-05-01",
        "stime": "00:00:50",
        "examount": 0,
        "ret": "",
        "shstatus": "closed",
        "cashier": "Ronald",
        "cno": "",
        "cname": "",
        "ref": "",
        "debit": null,
        "payvia": "BANK",
        "shift": "30/04/2025 TO 01/05/2025"
    }
*/
