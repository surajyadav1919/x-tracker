class Expense {
  final int? id;
  final String title;
  final double amount;
  final String description;
  final DateTime date;
  final String time;
  final String paymentType;
  final String? place;
  final String? note;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.description,
    required this.date,
    required this.time,
    required this.paymentType,
    this.place,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'time': time,
      'payment_type': paymentType,
      'place': place,
      'note': note,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      time: map['time'],
      paymentType: map['payment_type'],
      place: map['place'],
      note: map['note'],
    );
  }
}
