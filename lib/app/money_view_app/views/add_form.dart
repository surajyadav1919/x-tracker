import 'package:csc_picker/csc_picker.dart';
import 'package:multiselected_item_dropdown/multiselected_item_dropdown.dart';
import 'package:x_tracker/app/money_view_app/controllers/add_form_controller.dart';
import 'package:x_tracker/exports.dart';

class AddFormScreen extends StatelessWidget {
  AddFormScreen({super.key});
  final AddFormController controller = Get.put(AddFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Admin")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.margin12),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'Rep. Name',
                // labelText: 'Title',
                controller: controller.repTxtCtr,
                validator: (val) => Validation.validateField(val, 'Rep. Name'),
              ),
              CustomTextFormField(
                hintText: 'User/Email ID',
                // labelText: 'Title',
                controller: controller.userTxtCtr,
                validator: (val) => Validation.validateField(val, 'User/Email ID'),
              ),
              CustomTextFormField(
                hintText: 'Password',
                // labelText: 'Title',
                controller: controller.passTxtCtr,
                validator: (val) => Validation.validateField(val, 'Password'),
              ),
              CustomTextFormField(
                hintText: 'Mobile',
                // labelText: 'Title',
                controller: controller.mobileTxtCtr,
                validator: (val) => Validation.validateField(val, 'Mobile'),
              ),
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedGrp.value,
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    items: controller.grpList
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) => controller.selectedGrp.value = value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      constraints:
                          BoxConstraints(minHeight: AppDimensions.height30, maxHeight: AppDimensions.height30 * 2),
                      contentPadding: EdgeInsets.all(AppDimensions.margin10),
                      // labelText: 'Payment Type',
                      hintText: "Group",
                      border: inputBorder(),
                      enabledBorder: inputBorder(),
                      errorBorder: inputBorder(),
                      disabledBorder: inputBorder(),
                      focusedBorder: inputBorder(),
                      focusedErrorBorder: inputBorder(),
                    ),
                    validator: (value) => value == null ? 'Please select a group' : null,
                  ).paddingSymmetric(vertical: AppDimensions.margin7)),
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedDesignation.value,
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    items: controller.designationList
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) => controller.selectedDesignation.value = value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      constraints:
                          BoxConstraints(minHeight: AppDimensions.height30, maxHeight: AppDimensions.height30 * 2),
                      contentPadding: EdgeInsets.all(AppDimensions.margin10),
                      // labelText: 'Payment Type',
                      hintText: "Designation",
                      border: inputBorder(),
                      enabledBorder: inputBorder(),
                      errorBorder: inputBorder(),
                      disabledBorder: inputBorder(),
                      focusedBorder: inputBorder(),
                      focusedErrorBorder: inputBorder(),
                    ),
                    validator: (value) => value == null ? 'Please select a designation' : null,
                  ).paddingSymmetric(vertical: AppDimensions.margin7)),
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedRep.value,
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    items: controller.repList
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) => controller.selectedRep.value = value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      constraints:
                          BoxConstraints(minHeight: AppDimensions.height30, maxHeight: AppDimensions.height30 * 2),
                      contentPadding: EdgeInsets.all(AppDimensions.margin10),
                      // labelText: 'Payment Type',
                      hintText: "Parent Rep.",
                      border: inputBorder(),
                      enabledBorder: inputBorder(),
                      errorBorder: inputBorder(),
                      disabledBorder: inputBorder(),
                      focusedBorder: inputBorder(),
                      focusedErrorBorder: inputBorder(),
                    ),
                    validator: (value) => value == null ? 'Please select a Parent Rep.' : null,
                  ).paddingSymmetric(vertical: AppDimensions.margin7)),
              CustomTextFormField(
                hintText: 'Aadhaar No',
                // labelText: 'Title',
                keyboardType: TextInputType.number,
                maxLength: 12,
                controller: controller.aadhaarTxtCtr,
                validator: (val) => Validation.validateField(val, 'Aadhaar No'),
              ),
              CustomTextFormField(
                minLine: 3,
                maxLine: 5,
                keyboardType: TextInputType.streetAddress,
                hintText: 'Address',
                // labelText: 'Title',
                controller: controller.addressTxtCtr,
                validator: (val) => Validation.validateField(val, 'Address'),
              ),
              CscPickerWidget(),
              CustomTextFormField(
                maxLength: 6,
                keyboardType: TextInputType.number,
                hintText: 'Pin',
                // labelText: 'Title',
                controller: controller.pinTxtCtr,
                validator: (val) => Validation.validateField(val, 'Pin'),
              ),
              CustomTextFormField(
                hintText: 'Lock Days',
                // labelText: 'Title',
                controller: controller.lockDaysTxtCtr,
                validator: (val) => Validation.validateField(val, 'Lock Days'),
              ),
              CustomTextFormField(
                hintText: 'DVR Email sent to',
                keyboardType: TextInputType.emailAddress,
                // labelText: 'Title',
                controller: controller.dvrEmailTxtCtr,
                validator: (val) => Validation.validateField(val, 'DVR Email sent to'),
              ),
              Row(
                children: [
                  Obx(() => Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: controller.checkBoxValue.value,
                      onChanged: (val) {
                        controller.checkBoxValue.value = val!;
                      })),
                  Expanded(child: Text("Email to top line also")),
                ],
              ),
              Obx(
                () => ListView.builder(
                    itemCount: controller.radioList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var radioList = controller.radioList[index];
                      return Row(
                        children: [
                          Expanded(flex: 6, child: Text("${radioList.title}")),
                          Expanded(
                              flex: 3,
                              child: RadioListTile(
                                  toggleable: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("No"),
                                  value: radioList.selected,
                                  groupValue: false,
                                  onChanged: (val) {
                                    radioList.selected = false;
                                    controller.radioList.refresh();
                                  })),
                          Expanded(
                              flex: 3,
                              child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("Yes"),
                                  value: radioList.selected ?? false,
                                  groupValue: true,
                                  onChanged: (val) {
                                    radioList.selected = true;
                                    controller.radioList.refresh();
                                  })),
                        ],
                      );
                    }),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Linked Head Quarter",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDimensions.font20),
                  )).paddingSymmetric(vertical: AppDimensions.margin10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(AppDimensions.radius10)),
                child: MultiSelectedItemDropdown<String>(
                  list: ['head quarter 1', 'head quarter 2', 'head quarter 3', 'head quarter 4'], //required field
                  hintText: 'Please Select head quarter',
                  isShowMultiSelected: true,
                  isMultiSelected: true,
                  showBorderRadius: true,
                  onUpdateSelectedList: (val) {},
                ),
              ),
              customBtn(
                  btnClr: Colors.grey.shade400,
                  btnTxt: "Save",
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      showInSnackbar();
                    }
                  }).paddingSymmetric(vertical: AppDimensions.margin30)
            ],
          ),
        ),
      ),
    );
  }
}

class CscPickerWidget extends StatefulWidget {
  const CscPickerWidget({super.key});

  @override
  _CscPickerWidgetState createState() => _CscPickerWidgetState();
}

class _CscPickerWidgetState extends State<CscPickerWidget> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      showStates: true,
      showCities: true,
      flagState: CountryFlag.DISABLE,

      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radius10)),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),

      disabledDropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radius10)),
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),

      countrySearchPlaceholder: "Country",
      stateSearchPlaceholder: "State",
      citySearchPlaceholder: "City",

      countryDropdownLabel: "Country",
      stateDropdownLabel: "State",
      cityDropdownLabel: "City",

      //defaultCountry: CscCountry.India,
      //disableCountry: true,

      // countryFilter: [CscCountry.India, CscCountry.United_States, CscCountry.Canada],

      selectedItemStyle: TextStyle(
        color: Colors.black,
        fontSize: AppDimensions.font14,
      ),

      dropdownHeadingStyle: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),

      dropdownItemStyle: TextStyle(
        color: Colors.black,
        fontSize: AppDimensions.font14,
      ),

      dropdownDialogRadius: 10.0,

      searchBarRadius: 10.0,

      onCountryChanged: (value) {
        setState(() {
          countryValue = value;
        });
      },
      layout: Layout.vertical,
      onStateChanged: (value) {
        setState(() {
          stateValue = value ?? "";
        });
      },

      onCityChanged: (value) {
        setState(() {
          cityValue = value ?? "";
        });
      },
    );
  }
}
