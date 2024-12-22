import '../../../../exports.dart';

class HomeScreen extends GetView<HomeScreenController> {
  HomeScreen({super.key});

  @override
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: assetImgWidget(img: AppAssets.appLogo, radius: AppDimensions.radius50),
          centerTitle: true,
          title: const Text(AppStrings.appName)),
      floatingActionButton: GestureDetector(
          onTap: () {
            Get.to(() => const AddExpenseScreen())?.then((value) => controller.fetchExpenses());
          },
          child: CircleAvatar(
            radius: AppDimensions.radius25,
            backgroundColor: AppColors.info,
            child: const Icon(
              Icons.add,
              color: AppColors.white,
            ),
          )).paddingOnly(bottom: AppDimensions.margin20),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
                      hintText: 'Search here...',
                      onChanged: (val) => controller.searchExpenses(val)).paddingAll(AppDimensions.margin10)),
              Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        _showFilterBottomSheet(context);
                      },
                      icon: const Icon(Icons.tune)),
                  Positioned(
                    top: AppDimensions.margin8,
                    right: AppDimensions.margin8,
                    child: Obx(
                      () => Visibility(
                        visible: controller.filterType.value != null,
                        child: CircleAvatar(radius: AppDimensions.radius5),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: Obx(() {
              if (controller.filteredExpenses.isEmpty) {
                return Center(
                  child: Obx(
                    () => Text(
                      controller.searchQuery.value.isNotEmpty
                          ? "No Search Found!"
                          : controller.filterType.value != null
                              ? "No Data Found for this filter!"
                              : 'No expenses available.\nPlease add you daily expense',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: AppDimensions.font18, color: Colors.grey),
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      PieChartWidget(),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: AppDimensions.margin40),
                        itemCount: controller.filteredExpenses.length,
                        itemBuilder: (context, index) {
                          final expense = controller.filteredExpenses[index];

                          return TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: Duration(milliseconds: 500 + (index * 50)),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0.0, (1 - value) * 50),
                                  child: child,
                                ),
                              );
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(
                                vertical: AppDimensions.margin8,
                                horizontal: AppDimensions.margin20,
                              ),
                              elevation: 0.8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppDimensions.radius15),
                              ),
                              child: ListTile(
                                contentPadding:
                                    EdgeInsets.only(left: AppDimensions.margin15, bottom: AppDimensions.margin15),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.teal,
                                  child: Text(
                                    expense.title[0].toUpperCase(),
                                    style: TextStyle(color: Colors.white, fontSize: AppDimensions.font25),
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    buildHighlightedText(
                                      expense.title,
                                      fontSize: AppDimensions.font18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const Spacer(),
                                    PopupMenuButton<String>(
                                      elevation: 0,
                                      padding: EdgeInsets.zero,
                                      offset: Offset(-AppDimensions.margin35, AppDimensions.margin35),
                                      onSelected: (value) {
                                        if (value == 'Edit') {
                                          Get.to(() => const AddExpenseScreen(), arguments: {"id": expense.id})
                                              ?.then((value) => controller.fetchExpenses());
                                        } else if (value == 'Delete') {
                                          _showDeleteConfirmationDialog(context, expense.id!);
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          height: AppDimensions.height30,
                                          value: 'Edit',
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Colors.orange,
                                                size: AppDimensions.height15,
                                              ),
                                              SizedBox(width: AppDimensions.width8),
                                              const Text('Edit'),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          height: AppDimensions.height30,
                                          value: 'Delete',
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: AppDimensions.height15,
                                              ),
                                              SizedBox(width: AppDimensions.width8),
                                              const Text('Delete'),
                                            ],
                                          ),
                                        ),
                                      ],
                                      icon: const Icon(Icons.more_vert),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildHighlightedText('Amount: \$${expense.amount}',
                                        fontSize: AppDimensions.font16, color: Colors.green),
                                    buildHighlightedText(
                                        '${formatDate(expense.date.toLocal().toString().split(' ')[0])} at ${expense.time}',
                                        fontSize: AppDimensions.font14,
                                        color: Colors.grey),
                                    buildHighlightedText('Payment: ${expense.paymentType}',
                                        fontSize: AppDimensions.font16, color: Colors.blue),
                                    if (expense.place!.isNotEmpty)
                                      buildHighlightedText('Place: ${expense.place}',
                                          fontSize: AppDimensions.font12, color: Colors.grey),
                                    if (expense.note!.isNotEmpty)
                                      buildHighlightedText('Note: ${expense.note}',
                                          fontSize: AppDimensions.font12, color: Colors.grey),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  _showDeleteConfirmationDialog(BuildContext context, int expenseId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: AppDimensions.margin15),
          elevation: 0,
          actionsPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.all(AppDimensions.margin10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radius10)),
          title: const Text("Delete"),
          content: const Text("Are you sure to delete this record?"),
          actions: [
            // "No" button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("No"),
            ),
            // "Yes" button
            TextButton(
              onPressed: () {
                controller.deleteExpense(expenseId); // Perform delete operation
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Widget buildHighlightedText(String text, {color, fontSize, fontWeight}) {
    var textStyle = TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
    var query = controller.searchQuery.value;

    if (query.isEmpty || !text.toLowerCase().contains(query.toLowerCase())) {
      return Text(
        text,
        style: textStyle,
      );
    }

    final queryStart = text.toLowerCase().indexOf(query.toLowerCase());
    final queryEnd = queryStart + query.length;

    return RichText(
      text: TextSpan(
        text: text.substring(0, queryStart),
        style: textStyle,
        children: [
          TextSpan(
            text: text.substring(queryStart, queryEnd),
            style: TextStyle(
              color: AppColors.black,
              fontWeight: fontWeight,
              fontSize: fontSize,
              backgroundColor: Colors.yellow,
            ),
          ),
          TextSpan(
            text: text.substring(queryEnd),
            style: textStyle,
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Filter",
                    style: TextStyle(fontSize: AppDimensions.font20),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      controller.setFilter(null);
                      Navigator.pop(context);
                    },
                    child: const Text("Clear"))
              ],
            ).paddingOnly(left: AppDimensions.margin15, right: AppDimensions.margin15, top: AppDimensions.margin15),
            Divider(height: AppDimensions.height0),
            ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: controller.filterType.value == index
                        ? const Icon(Icons.radio_button_on, color: AppColors.info)
                        : const Icon(Icons.radio_button_off, color: Colors.grey),
                    title: Text(['Today', 'This Week', 'This Month', 'Custom Date Range'][index]),
                    onTap: () async {
                      if (index == 3) {
                        final DateTimeRange? range = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (range != null) {
                          controller.setFilter(index, start: range.start, end: range.end);
                        }
                      } else {
                        controller.setFilter(index);
                      }
                      Navigator.pop(context);
                    },
                  );
                }),
            spacerHeight(),
          ],
        );
      },
    );
  }
}
