// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

List<AccountModel> accountModelFromJson(String str) => List<AccountModel>.from(json.decode(str).map((x) => AccountModel.fromJson(x)));

String accountModelToJson(List<AccountModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountModel {
    String accountType;
    double actualAmount;
    double adjustmentAmount;
    bool advanceAdjustment;
    String createdBy;
    String createdDateTime;
    String description;
    String id;
    double paidAmount;
    String siteId;
    String siteName;
    String transactionDate;
    String transactionType;
    String transactorId;
    String transactorName;
    String transactorType;
    String updatedBy;
    String updatedDateTime;

    AccountModel({
        required this.accountType,
        required this.actualAmount,
        required this.adjustmentAmount,
        required this.advanceAdjustment,
        required this.createdBy,
        required this.createdDateTime,
        required this.description,
        required this.id,
        required this.paidAmount,
        required this.siteId,
        required this.siteName,
        required this.transactionDate,
        required this.transactionType,
        required this.transactorId,
        required this.transactorName,
        required this.transactorType,
        required this.updatedBy,
        required this.updatedDateTime,
    });

    factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        accountType: json["accountType"],
        actualAmount: json["actualAmount"],
        adjustmentAmount: json["adjustmentAmount"],
        advanceAdjustment: json["advanceAdjustment"],
        createdBy: json["createdBy"],
        createdDateTime:json["createdDateTime"],
        description: json["description"],
        id: json["id"],
        paidAmount: json["paidAmount"],
        siteId: json["siteId"] ?? "",
        siteName: json["siteName"],
        transactionDate: json["transactionDate"] ?? "",
        transactionType: json["transactionType"],
        transactorId: json["transactorId"] ?? "",
        transactorName: json["transactorName"],
        transactorType: json["transactorType"] ?? "",
        updatedBy: json["updatedBy"],
        updatedDateTime: json["updatedDateTime"],
    );

    Map<String, dynamic> toJson() => {
        "accountType": accountType,
        "actualAmount": actualAmount,
        "adjustmentAmount": adjustmentAmount,
        "advanceAdjustment": advanceAdjustment,
        "createdBy": createdBy,
        "createdDateTime": createdDateTime,
        "description": description,
        "id": id,
        "paidAmount": paidAmount,
        "siteId": siteId,
        "siteName": siteName,
        "transactionDate": transactionDate,
        "transactionType": transactionType,
        "transactorId": transactorId,
        "transactorName": transactorName,
        "transactorType": transactorType,
        "updatedBy": updatedBy,
        "updatedDateTime": updatedDateTime,
    };
}
