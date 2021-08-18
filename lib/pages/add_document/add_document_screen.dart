import '../../pages/documents/documents_screen.dart';
import '../../widgets/success_btn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/popup_widget.dart';
import '../../configs/colors.dart';
import '../../configs/screen_configs.dart';
import '../../configs/constants.dart';
import '../../APIFunctions.dart';
import '../../models/contract_list_resp_msg.dart';
import '../../models/customer_resp_msg.dart';
import '../../models/doc_rep_msg.dart';
import '../../models/document_message.dart';
import '../../models/financier_resp_msg.dart';
import '../../models/login_resp_msg.dart';
import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';
import '../../services/api_helper.dart';

class AddDocumentScreen extends StatefulWidget {
  const AddDocumentScreen({Key key}) : super(key: key);
  static String routeName = '/add_document_screen';

  @override
  _AddDocumentScreenState createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  UserDetails userDetails;
  FinancierResponseMessage _financierResponseMessage;
  DocumentMessage documentMessage;
  CustomerListResponseMessage _customerListResponseMessage;
  List<CustomerResult> _customerResults = [];
  ContractListResponseMessage _contractListResponseMessage;
  List<ContractListResult> _contactListResult = [];
  String documentResult, status, message;

  List<financierResult> _financierResult = [];


  bool _isLoading = false;
  var compID;
  String productDropdownValue;
  String financierDropdownValue;
  String buyerDropdownValue;
  String sellerDropdownValue;
  String contractDropdownValue;
  String cuurencyDropdownValue;
  String docTypeDropdownValue;
  String contractID;

  TextEditingController documentDateController = TextEditingController();
  TextEditingController documentNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  String product = '';
  String financierID;
  String buyerID;
  String supplierID;
  final _productValues = [
    'Supplier Invoice Discounting',
    'Buyer Invoice Financing'
  ];

  void getDropDownItem() {
    setState(() {
      product = productDropdownValue;
    });
  }

  void getFinancierID() {
    setState(() {
      financierID = _financierResult[0].financerID.toString();
    });
  }

  void getBuyerID() {
    setState(() {
      buyerID = _customerResults[0].companyID.toString();
    });
  }

  void getSupplierID() {
    setState(() {
      supplierID = _customerResults[1].companyID.toString();
    });
  }
  Future<List> _finacier() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    var token = userDets.token;
    var companyID = userDets.companyID;

    setState(() {
      _isLoading = true;
    });
    _financierResponseMessage =
        await APIHelper().getFinancier(companyID, product, token);

    setState(() {
      _financierResult = _financierResponseMessage.result;

      compID = companyID;
      _isLoading = false;
    });
  }

  Future<List> _getBuyerSeller() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    var token = userDets.token;
    var companyID = userDets.companyID;

    setState(() {
      _isLoading = true;
    });
    _customerListResponseMessage =
        await APIHelper().getCustomer(companyID, financierID, product, token);

    setState(() {
      _customerResults = _customerListResponseMessage.result;

      compID = companyID;
      _isLoading = false;
    });
  }

  Future<List> _getContractList() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    var token = userDets.token;
    var companyID = userDets.companyID;

    setState(() {
      _isLoading = true;
    });
    _contractListResponseMessage = await APIHelper()
        .getContractList(financierID, buyerID, supplierID, product, token);

    setState(() {
      _contactListResult = _contractListResponseMessage.result;

      compID = companyID;
      _isLoading = false;
    });
  }

  TextEditingController documentdate = TextEditingController();
  TextEditingController maturitydate = TextEditingController();

  Future<List> createDocument() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));
    var documents = Documents.fromJson(
        await SharedPreferenceHelper.read(Configs.DOCUMENT_ID));

    var token = userDets.token;
    var companyID = userDets.companyID;
    var createdBy = documents.createdBy;

    setState(() {
      _isLoading = true;
    });

    var id = Utils.CreateCryptoRandomString(32);
    // var id = "27ad54f7-f500-4bb3-ba4e-7017c36cbe9";

    documentMessage = await APIHelper().createDoc(
        product,
        contractDropdownValue,
        companyID,
        buyerID,
        supplierID,
        financierID,
        cuurencyDropdownValue,
        id,
        docTypeDropdownValue,
        documentNumberController.text,
        documentdate.text,
        maturitydate.text,
        amountController.text,
        commentsController.text,
        createdBy,
        status,
        token);

    setState(() {
      if (documentMessage.result.message == null) {
        message = documentMessage.message;
      } else {
        message = documentMessage.result.message;
      }
      if (documentMessage.result.status == null) {
        status = documentMessage.message;
      } else {
        status = documentMessage.status;
      }

      documentResult = documentMessage.statusCode;
    });

    // addDocumentResult.
  }

  @override
  void initState() {
    documentdate.text = "";
    maturitydate.text = ""; //set the initial value of text field
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.documents),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: kBrightColor,
        iconTheme:
            IconThemeData(color: Colors.white, size: getSizeOfScreenHeight(45)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: regularPadding),
            child: Icon(
              Icons.notification_important,
              size: getSizeOfScreenHeight(40),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: getSizeOfScreenHeight(5)),
            child: PopupWidget(),
          ),
        ],
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  Constants.quick_document,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text(Constants.product)),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(Constants.select_product),
                                      value: productDropdownValue,
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          productDropdownValue = newValue;
                                          getDropDownItem();
                                          // _getContractList();
                                          _finacier();
                                        });
                                      },
                                      items: _productValues.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text(Constants.financier)),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(Constants.select_financier),
                                      value: _financierResult.isEmpty
                                          ? "Select Financier"
                                          : _financierResult[0]
                                              .financerID
                                              .toString(),
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          financierDropdownValue = newValue;
                                          getFinancierID();
                                          _getBuyerSeller();
                                        });
                                      },
                                      items: _financierResult
                                          .map(
                                            (map) => DropdownMenuItem(
                                              child: Text(map.companyName),
                                              value:
                                                  '${map.financerID.toString()}',
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text(Constants.buyer)),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(Constants.select_buyer),
                                      value: _customerResults.isEmpty
                                          ? Constants.select_buyer
                                          : _customerResults[0]
                                              .companyID
                                              .toString(),
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          buyerDropdownValue = newValue;
                                          // _getBuyerSeller();
                                          getFinancierID();
                                          _getBuyerSeller();
                                        });
                                      },
                                      items: _customerResults
                                          .map(
                                            (map) => DropdownMenuItem(
                                              child: Text(map.buyerSupplier ==
                                                      Constants.buyer
                                                  ? map.companyName
                                                  : ''),
                                              value: map.companyID.toString(),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text(Constants.seller)),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(Constants.select_seller),
                                      value: _customerResults.isEmpty
                                          ? Constants.select_seller
                                          : _customerResults[1]
                                              .companyID
                                              .toString(),
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          sellerDropdownValue = newValue;
                                          getFinancierID();
                                          getDropDownItem();
                                          getBuyerID();
                                          getSupplierID();
                                          _getContractList();
                                        });
                                      },
                                      items: _customerResults
                                          .map(
                                            (map) => DropdownMenuItem(
                                              child: Text(map.buyerSupplier ==
                                                      Constants.supplier
                                                  ? map.companyName
                                                  : ''),
                                              value: map.companyID.toString(),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text(Constants.contracts)),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(Constants.select_contract),
                                      value: _contactListResult.isEmpty
                                          ? Constants.select_contract
                                          : _contactListResult[0]
                                              .contractID
                                              .toString(),
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          contractDropdownValue = newValue;
                                          // getFinancierID();
                                          // getBuyerID();
                                          // getSupplierID();
                                          // _getContractList();
                                        });
                                      },
                                      items: _contactListResult
                                          .map(
                                            (map) => DropdownMenuItem(
                                              child: Text(map.contractName),
                                              value: map.contractID.toString(),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text(Constants.currency)),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(Constants.select_currency),
                                      value: cuurencyDropdownValue,
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          cuurencyDropdownValue = newValue;
                                        });
                                      },
                                      items: <String>[Constants.ksh]
                                          .map<DropdownMenuItem<String>>(
                                              (String finvalue) {
                                        return DropdownMenuItem<String>(
                                          value: finvalue,
                                          child: Text(finvalue),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text(Constants.doc_type)),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(Constants.select_doc_type),
                                      value: docTypeDropdownValue,
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          docTypeDropdownValue = newValue;
                                        });
                                      },
                                      items: <String>[Constants.invoice]
                                          .map<DropdownMenuItem<String>>(
                                              (String finvalue) {
                                        return DropdownMenuItem<String>(
                                          value: finvalue,
                                          child: Text(finvalue),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                child: Text(
                  Constants.doc_no_1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: documentNumberController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Constants.doc_no),
                      ),
                    ),
                    // _textInput("Document No",),
                    Container(
                        padding: EdgeInsets.all(15),
                        height: 150,
                        child: Center(
                            child: TextField(
                          controller:
                              documentdate, //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText:
                                  Constants.doc_date //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime.now());

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat(Constants.date_format)
                                      .format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                documentdate.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print(Constants.date_error);
                            }
                          },
                        ))),
                    Container(
                        padding: EdgeInsets.all(15),
                        height: 150,
                        child: Center(
                            child: TextField(
                          controller:
                              maturitydate, //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText:
                                  Constants.maturity_date //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text

                          onTap: () async {
                            DateTime pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime
                                    .now(), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat(Constants.date_format)
                                      .format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                maturitydate.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print(Constants.date_error);
                            }
                          },
                        ))),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: amountController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Constants.amount),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: commentsController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Constants.comments),
                      ),
                    ),
                    // _textInput("Amount",),
                    // _textInput("Comments"),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: SuccessBtn(
                              btnText: "Saves",
                              onPressed: () {
                                createDocument();
                                if (documentResult == "200") {
                                  buildShowDialog(context);
                                } else {
                                  print("document not added");
                                }
                              },
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: SuccessBtn(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, DocumentsScreen.routeName);
                              },
                              btnText: Constants.cancel,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
    );
  }
  Widget _textInput(String label, controller) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: label),
      ),
    );
  }

  Future buildShowDialog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(status),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(Constants.ok))
              ],
            ));
  }
}
