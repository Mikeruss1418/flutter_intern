
import 'dart:convert';
import 'dart:math';
import 'package:connectips/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:connectips/model.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<ConnectIpsModel> _transactions = [];
  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    String transactionsJson = prefs.getString('transactions') ?? '[]';
    List transactions = jsonDecode(transactionsJson);
    setState(() {
      _transactions =
          transactions.map((json) => ConnectIpsModel.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: themecolor,
        elevation: 0,
      ),
      body: _transactions.isEmpty
          ? Center(
              child: Text(
                'No transactions found',
                style: TextStyle(fontSize: 18.sp, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return _buildTransactionCard(_transactions[index], index);
              },
            ),
    );
  }

  Widget _buildTransactionCard(ConnectIpsModel transaction, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: themecolor,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          transaction.txnId ?? 'Unknown Transaction',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        subtitle: Text(
          _formatDate(transaction.txnDate),
          style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Merchant ID', transaction.merchantId),
                _buildInfoRow('App ID', transaction.appId),
                _buildInfoRow('App Name', transaction.appname),
                _buildInfoRow('Transaction Currency', transaction.txnCrncy),
                _buildInfoRow('Transaction Amount', transaction.txnAmt),
                _buildInfoRow('Reference ID', transaction.refId),
                _buildInfoRow('Service Code', transaction.svcCode),
                _buildInfoRow('Particulars', transaction.particulars),
                _buildInfoRow('Token', transaction.token, isToken: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value, {bool isToken = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              isToken
                  ? '${value?.substring(0, min(value.length, 10))}...' //used min becasue 1st one is empty
                  : (value ?? 'N/A'),
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown Date';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM d, yyyy ').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
