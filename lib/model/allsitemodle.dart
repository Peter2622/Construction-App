// To parse this JSON data, do
//
//     final getAllsiteModel = getAllsiteModelFromJson(jsonString);

import 'dart:convert';

List<GetAllsiteModel> getAllsiteModelFromJson(String str) => List<GetAllsiteModel>.from(json.decode(str).map((x) => GetAllsiteModel.fromJson(x)));

String getAllsiteModelToJson(List<GetAllsiteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllsiteModel {
    String address;
    String city;
    String createdBy;
    String createdDateTime;
    String estimatedBudget;
    String estimatedDays;
    List<ProjectHandler> projectHandlers;
    String scopeOfWork;
    String siteId;
    String siteName;
    String updatedBy;
    DateTime updatedDateTime;

    GetAllsiteModel({
        required this.address,
        required this.city,
        required this.createdBy,
        required this.createdDateTime,
        required this.estimatedBudget,
        required this.estimatedDays,
        required this.projectHandlers,
        required this.scopeOfWork,
        required this.siteId,
        required this.siteName,
        required this.updatedBy,
        required this.updatedDateTime,
    });

    factory GetAllsiteModel.fromJson(Map<String, dynamic> json) => GetAllsiteModel(
        address: json["address"],
        city: json["city"],
        createdBy: json["createdBy"] ??"",
        createdDateTime: json["createdDateTime"]??"",
        estimatedBudget: json["estimatedBudget"],
        estimatedDays: json["estimatedDays"],
        projectHandlers: List<ProjectHandler>.from(json["projectHandlers"].map((x) => ProjectHandler.fromJson(x))),
        scopeOfWork: json["scopeOfWork"],
        siteId: json["siteId"],
        siteName: json["siteName"],
        updatedBy: json["updatedBy"],
        updatedDateTime: DateTime.parse(json["updatedDateTime"]),
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "createdBy": createdBy,
        "createdDateTime": createdDateTime,
        "estimatedBudget": estimatedBudget,
        "estimatedDays": estimatedDays,
        "projectHandlers": List<dynamic>.from(projectHandlers.map((x) => x.toJson())),
        "scopeOfWork": scopeOfWork,
        "siteId": siteId,
        "siteName": siteName,
        "updatedBy": updatedBy,
        "updatedDateTime": updatedDateTime.toIso8601String(),
    };
}

class ProjectHandler {
    String workerName;
    String workerType;

    ProjectHandler({
        required this.workerName,
        required this.workerType,
    });

    factory ProjectHandler.fromJson(Map<String, dynamic> json) => ProjectHandler(
        workerName: json["workerName"],
        workerType: json["workerType"],
    );

    Map<String, dynamic> toJson() => {
        "workerName": workerName,
        "workerType": workerType,
    };
}
