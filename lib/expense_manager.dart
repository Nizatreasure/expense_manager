class ExpenseManager {
  DateTime date;
  String merchant;
  double total;
  String status;
  String comment;

  ExpenseManager(
      {required this.date,
      required this.merchant,
      required this.total,
      required this.status,
      required this.comment});
}
