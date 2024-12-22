import 'package:intl/intl.dart';

import '../../../../exports.dart';

class AddExpenseController extends GetxController {
  @override
  void onInit() {
    _getArg();
    super.onInit();
  }

  int? id;

  _getArg() {
    if (Get.arguments != null) {
      id = Get.arguments["id"];
      _getExpenseById(id);
    }
  }

  _getExpenseById(id) async {
    Expense? expense = await db.getExpenseById(id);
    amountController.text = "${expense!.amount}";
    titleController.text = expense.title ?? "";
    descriptionController.text = expense.description ?? "";
    placeController.text = expense.place ?? "";
    noteController.text = expense.note ?? "";
    timeController.text = expense.time ?? "";
    dateController.text = DateFormat("dd-MM-yyyy").format(expense.date.toLocal());
    selectedPaymentType.value = expense.paymentType ?? "";
    selectedDate.value = expense.date;
  }

  final amountController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final placeController = TextEditingController();
  final noteController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final selectedDate = Rxn<DateTime>();
  final selectedTime = Rxn<TimeOfDay>();
  final selectedPaymentType = RxnString();

  final List<String> paymentTypes = ['Cash', 'UPI', 'Wallet'];

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      dateController.text = DateFormat("dd-MM-yyyy").format(selectedDate.value!.toLocal());
    }
  }

  void pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      selectedTime.value = pickedTime;
      timeController.text = selectedTime.value!.format(context);
    }
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      addExpense().then(
        (value) => showInSnackbar(
          msg: 'Expense  ${id == null ? "added" : "updated"} successfully!',
        ),
      );
    }
  }

  Future addExpense() async {
    Expense expense = Expense(
      id: id,
      title: titleController.text.trim(),
      amount: double.parse(amountController.text.trim()),
      description: descriptionController.text.trim(),
      date: selectedDate.value!,
      time: timeController.text.trim(),
      paymentType: selectedPaymentType.value!,
      place: placeController.text.trim(),
      note: noteController.text.trim(),
    );

    if (id == null) {
      await db.insertExpense(expense).then((value) => Get.back());
    } else {
      await db.updateExpense(expense).then((value) => Get.back());
    }
  }
}
