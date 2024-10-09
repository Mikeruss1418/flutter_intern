
class ConnectIpsModel {
  String? merchantId;
  String? appId;
  String? appname;
  String? txnId;
  String? txnDate;
  String? txnCrncy;
  String? txnAmt;
  String? refId;
  String? svcCode;
  String? particulars;
  String? token;

  ConnectIpsModel({
    this.merchantId,
    this.appId,
    this.appname,
    this.txnId,
    this.txnDate,
    this.txnCrncy,
    this.txnAmt,
    this.refId,
    this.svcCode,
    this.particulars,
    this.token,
  });
    // Method to convert JSON to ConnectIpsModel
  ConnectIpsModel.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    appId = json['appId'];
    appname = json['appname'];
    txnId = json['txnId'];
    txnDate = json['txnDate'];
    txnCrncy = json['txnCrncy'];
    txnAmt = json['txnAmt'];
    refId = json['refId'];
    svcCode = json['svcCode'];
    particulars = json['particulars'];
    token = json['token'];
  }
    // Method to convert ConnectIpsModel to JSON
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['merchantId'] = merchantId;
    data['appId'] = appId;
    data['appname'] = appname;
    data['txnId'] = txnId;
    data['txnDate'] = txnDate;
    data['txnCrncy'] = txnCrncy;
    data['txnAmt'] = txnAmt;
    data['refId'] = refId;
    data['svcCode'] = svcCode;
    data['particulars'] = particulars;
    data['token'] = token;
    return data;
  }
}
