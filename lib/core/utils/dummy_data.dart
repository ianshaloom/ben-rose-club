import '../constants/image_path_const.dart';

final List<RecentPurchaseItem> purchases = [
  RecentPurchaseItem(
    id: '001-1',
    status: PurchaseStatus.pending,
    amount: 450,
    pieces: 2000,
    date: DateTime.now(),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Manager',
    productName: 'Nike Sandals',
  ),
  RecentPurchaseItem(
    id: '001-2',
    status: PurchaseStatus.received,
    amount: 500,
    pieces: 150,
    date: DateTime.now().subtract(const Duration(minutes: 20)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Assistant',
    productName: 'Buck 4-11',
  ),
  RecentPurchaseItem(
    id: '001-3',
    status: PurchaseStatus.cancelled,
    amount: 350,
    pieces: 30,
    date: DateTime.now().subtract(const Duration(minutes: 43)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Cashier',
    productName: 'Toughees 9-1',
  ),
  RecentPurchaseItem(
    id: '001-3',
    status: PurchaseStatus.received,
    amount: 200,
    pieces: 90,
    date: DateTime.now().subtract(const Duration(hours: 3)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'Someka Black',
  ),
  RecentPurchaseItem(
    id: '001-4',
    status: PurchaseStatus.pending,
    amount: 600,
    pieces: 42,
    date: DateTime.now().subtract(const Duration(hours: 5)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'Someka White',
  ),
  RecentPurchaseItem(
    id: '001-5',
    status: PurchaseStatus.cancelled,
    amount: 250,
    pieces: 25,
    date: DateTime.now().subtract(const Duration(days: 1)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'Umbrella Fold Flower',
  ),
  RecentPurchaseItem(
    id: '001-6',
    status: PurchaseStatus.pending,
    amount: 400,
    pieces: 100,
    date: DateTime.now().subtract(const Duration(days: 2)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'CP slippers',
  ),
  RecentPurchaseItem(
    id: '001-1',
    status: PurchaseStatus.pending,
    amount: 450,
    pieces: 200,
    date: DateTime.now(),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'CP Gumboots 5-11',
  ),
  RecentPurchaseItem(
    id: '001-2',
    status: PurchaseStatus.received,
    amount: 500,
    pieces: 150,
    date: DateTime.now().subtract(const Duration(minutes: 20)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'Sandak',
  ),
  RecentPurchaseItem(
    id: '001-3',
    status: PurchaseStatus.cancelled,
    amount: 350,
    pieces: 30,
    date: DateTime.now().subtract(const Duration(minutes: 43)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'TN Sandals 020-18',
  ),
  RecentPurchaseItem(
    id: '001-3',
    status: PurchaseStatus.received,
    amount: 200,
    pieces: 90,
    date: DateTime.now().subtract(const Duration(hours: 3)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'Football Big',
  ),
  RecentPurchaseItem(
    id: '001-4',
    status: PurchaseStatus.pending,
    amount: 600,
    pieces: 42,
    date: DateTime.now().subtract(const Duration(hours: 5)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'Someka C/d',
  ),
  RecentPurchaseItem(
    id: '001-5',
    status: PurchaseStatus.cancelled,
    amount: 250,
    pieces: 25,
    date: DateTime.now().subtract(const Duration(days: 1)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'Ngoma Bk 4-8',
  ),
  RecentPurchaseItem(
    id: '001-6',
    status: PurchaseStatus.pending,
    amount: 400,
    pieces: 100,
    date: DateTime.now().subtract(const Duration(days: 2)),
    createdBy: 'Ian Shaloom',
    updatedBy: 'Ian Shaloom',
    productName: 'Nice Nice White(B)',
  ),
];

List<RecentPurchaseItem> pendingList(){
  return purchases.where((element) => element.status == PurchaseStatus.pending).toList();

}

List<RecentPurchaseItem> receivedList(){
  return purchases.where((element) => element.status == PurchaseStatus.received).toList();

}

List<RecentPurchaseItem> cancelledList(){
  return purchases.where((element) => element.status == PurchaseStatus.cancelled).toList();

}

enum PurchaseStatus { pending, received, cancelled }

class RecentPurchaseItem {
  final String id;
  final String productName;
  final PurchaseStatus status;
  final double amount;
  final int pieces;
  final String createdBy;
  final String updatedBy;
  final DateTime date;

  double get totalAmount => amount * pieces;

  String get svgPath {
    switch (status) {
      case PurchaseStatus.pending:
        return pending;
      case PurchaseStatus.received:
        return received;
      case PurchaseStatus.cancelled:
        return cancelled;
    }
  }

  String get transactionName {
    switch (status) {
      case PurchaseStatus.pending:
        return 'Pending';
      case PurchaseStatus.received:
        return 'Received';
      case PurchaseStatus.cancelled:
        return 'Cancelled';
    }
  }

  const RecentPurchaseItem({
    required this.id,
    required this.status,
    required this.amount,
    required this.date,
    required this.pieces,
    required this.productName,
    required this.createdBy,
    required this.updatedBy,
  });
}
