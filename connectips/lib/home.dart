import 'dart:convert';
import 'dart:math';

import 'package:connectips/constants.dart';
import 'package:connectips/customtxtfield.dart';
import 'package:connectips/history.dart';
import 'package:connectips/model.dart';
import 'package:connectips/proceed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formkey = GlobalKey<FormState>();
  TextEditingController merchantId = TextEditingController();
  TextEditingController appId = TextEditingController(text: '15SVfffH05CUaC');
  TextEditingController appName = TextEditingController(text: 'Connect Ips');
  TextEditingController txnId = TextEditingController();
  TextEditingController txnDate = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  TextEditingController txnCrncy = TextEditingController(text: 'NPR');
  TextEditingController txnAmount = TextEditingController();
  TextEditingController refId = TextEditingController();
  TextEditingController svcCode = TextEditingController();
  TextEditingController particulars = TextEditingController();
  TextEditingController token = TextEditingController();

  bool isbase32enable = false;

  String generateRandomnumString(int digits) {
    Random random = Random();
    // Generate n random digits by appending each digit to a string
    String randomDigits = '';
    for (int i = 0; i < digits; i++) {
      randomDigits +=
          random.nextInt(10).toString(); // Generate a single digit (0-9)
    }
    return randomDigits;
  }

  void _generateToken() {
    final random = Random();
    final _svcCode =
        List.generate(8, (index) => random.nextInt(36)).map((digit) {
      if (digit < 10) {
        return digit.toString();
      } else {
        return String.fromCharCode('A'.codeUnitAt(0) + digit - 10);
      }
    }).join();
    token.text = _svcCode;
  }

  void _generateSvcCode() {
    final random = Random();
    final _svcCode =
        List.generate(15, (index) => random.nextInt(36)).map((digit) {
      if (digit < 10) {
        return digit.toString();
      } else {
        return String.fromCharCode('A'.codeUnitAt(0) + digit - 10);
      }
    }).join();
    svcCode.text = _svcCode;
  }

  String generateTxnid() {
    txnId.text = generateRandomnumString(8);
    return generateRandomnumString(8);
  }

  String generateRefId() {
    refId.text = generateRandomnumString(13);
    return generateRandomnumString(13);
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final connectIpdmodel = ConnectIpsModel(
        merchantId: merchantId.text,
        appId: appId.text,
        appname: appName.text,
        txnId: txnId.text,
        txnDate: txnDate.text,
        txnCrncy: txnCrncy.text,
        txnAmt: txnAmount.text,
        refId: refId.text,
        svcCode: svcCode.text,
        particulars: particulars.text,
        token: token.text);
    final json = connectIpdmodel.toJson();
    String transactionsJson = prefs.getString('transactions') ?? '[]';
    List transactions = jsonDecode(transactionsJson);
    //added the json as list is in jsonformat
    transactions.add(json);
    prefs.setString('transactions', jsonEncode(transactions));

//single update the existing
    // final json = connectIpdmodel.toJson();
    // await prefs.setString('payment', jsonEncode(json));
  }

  @override
  void initState() {
    super.initState();
    generateRefId();
    generateTxnid();
    _generateToken();
    _generateSvcCode();
  }

  @override
  void dispose() {
    merchantId.dispose();
    appId.dispose();
    appName.dispose();
    txnId.dispose();
    txnDate.dispose();
    txnCrncy.dispose();
    txnAmount.dispose();
    refId.dispose();
    svcCode.dispose();
    particulars.dispose();
    token.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Connect ',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontSize: 22.sp)),
                TextSpan(
                    text: 'IPS',
                    style: TextStyle(
                        color: themecolor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold))
              ]),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => History(),
                      ));
                },
                icon: const Icon(Icons.history))
          ],
        ),
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTxtField(
                  keyboardtype: TextInputType.number,
                  inputformatter: [FilteringTextInputFormatter.digitsOnly],
                  maxlen: 10,
                  prefixicon: const Icon(Icons.business),
                  controller: merchantId,
                  labeltxt: 'Merchant Id',
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 9) {
                      return 'Provide valid Id';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTxtField(
                  controller: appId,
                  labeltxt: 'App ID',
                  prefixicon: const Icon(Icons.apps),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTxtField(
                  controller: appName,
                  labeltxt: 'App Name',
                  prefixicon: const Icon(Icons.text_fields_rounded),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTxtField(
                  readonly: true,
                  controller: txnId,
                  labeltxt: 'Txn Id',
                  prefixicon: const Icon(Icons.receipt),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTxtField(
                  readonly: true,
                  controller: txnDate,
                  labeltxt: 'Txn Date',
                  prefixicon: const Icon(Icons.calendar_month),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTxtField(
                  readonly: true,
                  controller: txnCrncy,
                  labeltxt: 'Txn Crncy',
                  prefixicon: const Icon(Icons.attach_money),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTxtField(
                  inputformatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardtype: TextInputType.number,
                  controller: txnAmount,
                  labeltxt: 'Txn Amount',
                  prefixicon: const Icon(Icons.money),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Provide an Amount";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTxtField(
                  readonly: true,
                  controller: refId,
                  labeltxt: 'Reference Id',
                  prefixicon: const Icon(Icons.confirmation_num),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTxtField(
                  controller: svcCode,
                  labeltxt: 'Svc Code',
                  prefixicon: const Icon(Icons.code),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTxtField(
                  controller: particulars,
                  labeltxt: 'Particulars',
                  prefixicon: const Icon(Icons.list),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Provide us some Particulars";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTxtField(
                  controller: token,
                  labeltxt: 'Token',
                  prefixicon: const Icon(Icons.lock),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: themecolor,
                        checkColor: Colors.white,
                        value: isbase32enable,
                        onChanged: (value) {
                          setState(() {
                            isbase32enable = value!;
                          });
                        }),
                    const Text('Is to Enable base 32'),
                  ],
                ),
                SubmitBtn(
                  txt: 'Proceed',
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      _saveData();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => History(),
                          )).then((_) {
                        generateRefId();
                        generateTxnid();
                        _generateToken();
                        _generateSvcCode();
                        merchantId.clear();
                        txnAmount.clear();
                        particulars.clear();
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
