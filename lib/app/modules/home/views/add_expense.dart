import '../../../../exports.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> with TickerProviderStateMixin {
  final AddExpenseController controller = Get.put(AddExpenseController());
  late AnimationController _animationController;
  late List<Animation<Offset>> _fieldSlideAnimations;
  late List<Animation<double>> _fieldFadeAnimations;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controllers
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    // Slide animation for each form field
    _fieldSlideAnimations = List.generate(
      8,
      (index) => Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    // Fade animation for each form field
    _fieldFadeAnimations = List.generate(
      8,
      (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    // Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.margin15),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              // Fade and Slide animation for Amount field
              FadeTransition(
                opacity: _fieldFadeAnimations[0],
                child: SlideTransition(
                  position: _fieldSlideAnimations[0],
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: CustomTextFormField(
                      hintText: 'Enter amount',
                      labelText: 'Amount',
                      controller: controller.amountController,
                      keyboardType: TextInputType.number,
                      validator: (val) => Validation.validateAmount(val),
                    ),
                  ),
                ),
              ),
              // Fade and Slide animation for Title field
              FadeTransition(
                opacity: _fieldFadeAnimations[1],
                child: SlideTransition(
                  position: _fieldSlideAnimations[1],
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: CustomTextFormField(
                      hintText: 'Enter title',
                      labelText: 'Title',
                      controller: controller.titleController,
                      validator: (val) => Validation.validateTitle(val),
                    ),
                  ),
                ),
              ),
              // Fade and Slide animation for Description field
              FadeTransition(
                opacity: _fieldFadeAnimations[2],
                child: SlideTransition(
                  position: _fieldSlideAnimations[2],
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: CustomTextFormField(
                      hintText: 'Enter description',
                      labelText: 'Description',
                      controller: controller.descriptionController,
                      validator: (val) => Validation.validateDescription(val),
                    ),
                  ),
                ),
              ),
              // Fade and Slide animation for Date & Time field
              FadeTransition(
                opacity: _fieldFadeAnimations[3],
                child: SlideTransition(
                  position: _fieldSlideAnimations[3],
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            hintText: 'Pick a date',
                            labelText: 'Date',
                            controller: controller.dateController,
                            readOnly: true,
                            onTap: () => controller.pickDate(context),
                            suffixIcon: const Icon(Icons.calendar_today),
                            validator: (val) => val == null || val.isEmpty ? 'Please select a date' : null,
                          ),
                        ),
                        spacerWidth(),
                        Expanded(
                          child: CustomTextFormField(
                            hintText: 'Pick a time',
                            labelText: 'Time',
                            controller: controller.timeController,
                            readOnly: true,
                            onTap: () => controller.pickTime(context),
                            suffixIcon: const Icon(Icons.access_time),
                            validator: (val) => val == null || val.isEmpty ? 'Please select a time' : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Fade and Slide animation for Payment Type dropdown
              FadeTransition(
                opacity: _fieldFadeAnimations[4],
                child: SlideTransition(
                  position: _fieldSlideAnimations[4],
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Obx(() => DropdownButtonFormField<String>(
                          value: controller.selectedPaymentType.value,
                          items: controller.paymentTypes
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  ))
                              .toList(),
                          onChanged: (value) => controller.selectedPaymentType.value = value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(AppDimensions.margin10),
                            labelText: 'Payment Type',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radius10,
                              ),
                            ),
                          ),
                          validator: (value) => value == null ? 'Please select a payment type' : null,
                        ).paddingSymmetric(vertical: AppDimensions.margin7)),
                  ),
                ),
              ),
              // Fade and Slide animation for Place field
              FadeTransition(
                opacity: _fieldFadeAnimations[5],
                child: SlideTransition(
                  position: _fieldSlideAnimations[5],
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: CustomTextFormField(
                      hintText: 'Enter place',
                      labelText: 'Place',
                      controller: controller.placeController,
                    ),
                  ),
                ),
              ),
              // Fade and Slide animation for Note field
              FadeTransition(
                opacity: _fieldFadeAnimations[6],
                child: SlideTransition(
                  position: _fieldSlideAnimations[6],
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: CustomTextFormField(
                      hintText: 'Enter note',
                      labelText: 'Note',
                      controller: controller.noteController,
                    ),
                  ),
                ),
              ),
              // Submit Button with animation
              FadeTransition(
                opacity: _fieldFadeAnimations[7],
                child: SlideTransition(
                  position: _fieldSlideAnimations[7],
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: SizedBox(height: AppDimensions.height30),
                  ),
                ),
              ),
              // Submit Button
              FadeTransition(
                opacity: _fieldFadeAnimations[7],
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: customBtn(
                    onTap: () => controller.submitForm(),
                    btnTxt: 'Add Expense',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
