import 'package:fl_chart/fl_chart.dart';
import '../../exports.dart';

class PieChartWidget extends StatelessWidget {
  PieChartWidget({super.key});
  final HomeScreenController controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.filteredExpenses.isEmpty) {
        return const SizedBox();
      }
      Map<String, double> paymentTypeData = {};
      for (var expense in controller.filteredExpenses) {
        paymentTypeData.update(
          expense.paymentType,
          (value) => value + expense.amount,
          ifAbsent: () => expense.amount,
        );
      }

      List<PieChartSectionData> sections = paymentTypeData.entries
          .map((entry) => PieChartSectionData(
                title: entry.key,
                value: entry.value,
                color: _getColor(entry.key),
                radius: AppDimensions.radius50 + AppDimensions.radius10,
                titleStyle: TextStyle(fontSize: AppDimensions.font12, fontWeight: FontWeight.bold),
              ))
          .toList();

      return Column(
        children: [
          Text(
            'Expenses by Payment Type',
            style: TextStyle(fontSize: AppDimensions.font18, fontWeight: FontWeight.bold),
          ),
          spacerHeight(),
          SizedBox(
            height: AppDimensions.height50 * 4,
            child: PieChart(
              PieChartData(
                sections: sections,
                centerSpaceRadius: AppDimensions.radius50,
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      );
    });
  }

  // Helper method to assign colors
  Color _getColor(String paymentType) {
    switch (paymentType.toLowerCase()) {
      case 'cash':
        return Colors.blue;
      case 'upi':
        return Colors.green;
      case 'wallet':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
