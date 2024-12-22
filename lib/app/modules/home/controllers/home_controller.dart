import '../../../../exports.dart';

class HomeScreenController extends GetxController {
  var expenses = <Expense>[].obs;
  var filteredExpenses = <Expense>[].obs;

  @override
  void onInit() {
    fetchExpenses();
    super.onInit();
  }

  void fetchExpenses() async {
    List<Expense> expenseList = await DatabaseHelper.instance.getAllExpenses();
    expenses.assignAll(expenseList);
    filteredExpenses.value = expenses;
  }

  void deleteExpense(int id) async {
    await DatabaseHelper.instance.deleteExpense(id);
    fetchExpenses();
    showInSnackbar(msg: "Record Deleted Successfully!");
  }

  // Search Query
  var searchQuery = ''.obs;

  // Filter Type
  RxnInt filterType = RxnInt();

  void searchExpenses(String query) {
    searchQuery.value = query.toLowerCase();
    _applyFilters();
  }

  // Date Range for filter
  DateTime? startDate;
  DateTime? endDate;

  // Set Filter Type
  void setFilter(type, {DateTime? start, DateTime? end}) {
    filterType.value = type;
    startDate = start;
    endDate = end;
    _applyFilters();
  }

  // Apply Filters and Search
  void _applyFilters() {
    List<Expense> tempExpenses = List.from(expenses);

    // Apply Search Query
    if (searchQuery.value.isNotEmpty) {
      tempExpenses = tempExpenses.where((expense) {
        return expense.amount.toString().contains(searchQuery.value) ||
            expense.title.toLowerCase().contains(searchQuery.value) ||
            expense.description.toLowerCase().contains(searchQuery.value) ||
            expense.place!.toLowerCase().contains(searchQuery.value) ||
            expense.note!.toLowerCase().contains(searchQuery.value) ||
            expense.paymentType.toLowerCase().contains(searchQuery.value);
      }).toList();
    }

    // Apply Filter
    DateTime now = DateTime.now();
    if (filterType.value == 0) {
      tempExpenses = tempExpenses.where((expense) {
        return isSameDate(expense.date, now);
      }).toList();
    } else if (filterType.value == 1) {
      tempExpenses = tempExpenses.where((expense) {
        return isSameWeek(expense.date, now);
      }).toList();
    } else if (filterType.value == 2) {
      tempExpenses = tempExpenses.where((expense) {
        return expense.date.year == now.year && expense.date.month == now.month;
      }).toList();
    } else if (filterType.value == 3 && startDate != null && endDate != null) {
      tempExpenses = tempExpenses.where((expense) {
        return expense.date.isAfter(startDate!) && expense.date.isBefore(endDate!);
      }).toList();
    }

    filteredExpenses.value = tempExpenses;
  }

  // Helper Methods
  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  bool isSameWeek(DateTime date1, DateTime date2) {
    final weekStart = date2.subtract(Duration(days: date2.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));
    return date1.isAfter(weekStart.subtract(const Duration(seconds: 1))) &&
        date1.isBefore(weekEnd.add(const Duration(seconds: 1)));
  }
}
