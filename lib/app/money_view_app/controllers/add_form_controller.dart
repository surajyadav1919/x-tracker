import '../../../exports.dart';

class AddFormController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController repTxtCtr = TextEditingController();
  TextEditingController userTxtCtr = TextEditingController();
  TextEditingController passTxtCtr = TextEditingController();
  TextEditingController mobileTxtCtr = TextEditingController();
  TextEditingController aadhaarTxtCtr = TextEditingController();
  TextEditingController addressTxtCtr = TextEditingController();
  TextEditingController pinTxtCtr = TextEditingController();
  TextEditingController lockDaysTxtCtr = TextEditingController();
  TextEditingController dvrEmailTxtCtr = TextEditingController();

  RxBool checkBoxValue = false.obs;

  final selectedGrp = RxnString();
  final List<String> grpList = ['Group1', 'Group2', 'Group3'];
  final selectedDesignation = RxnString();
  final List<String> designationList = ['Designation1', 'Designation2', 'Designation3', "Designation4"];
  final selectedRep = RxnString();
  final List<String> repList = ['Rep1', 'Rep2', 'Rep3', 'Rep4', 'Rep5'];

  RxList<RadioModel> radioList = <RadioModel>[
    RadioModel(title: "DVR File Upload"),
    RadioModel(title: "Expense File Upload"),
    RadioModel(title: "Location Saved"),
    RadioModel(title: "Blocked"),
  ].obs;

  List<String> selected = [];

}

class RadioModel {
  String? title;
  bool? selected;
  RadioModel({this.title, this.selected});
}
