import 'package:intl/intl.dart';

import '../../exports.dart';

Widget spacerHeight() => SizedBox(
      height: AppDimensions.height10,
      width: AppDimensions.width0,
    );
Widget spacerWidth() => SizedBox(
      height: AppDimensions.height0,
      width: AppDimensions.width10,
    );

Widget customBtn({onTap, btnTxt, btnClr}) => GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(AppDimensions.margin10),
          decoration: BoxDecoration(
              color: btnClr ?? AppColors.success, borderRadius: BorderRadius.circular(AppDimensions.radius10)),
          child: Text(
            btnTxt ?? "Button Text",
            style: const TextStyle(color: AppColors.white),
          )),
    );

showInSnackbar({msg, forError = false}) => Get.snackbar(
      forError ? 'Error' : 'Success',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      colorText: AppColors.white,
      backgroundColor: forError ? AppColors.error : AppColors.success,
      margin: EdgeInsets.all(AppDimensions.margin20),
    );

String formatDate(String date) {
  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  DateTime expenseDate = DateTime.parse(date);
  DateTime today = DateTime.now();
  DateTime yesterday = today.subtract(const Duration(days: 1));

  if (isSameDate(expenseDate, today)) {
    return "Today";
  } else if (isSameDate(expenseDate, yesterday)) {
    return "Yesterday";
  } else {
    return DateFormat('dd-MMM-yyyy').format(expenseDate);
  }
}
