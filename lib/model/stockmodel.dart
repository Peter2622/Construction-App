// To parse this JSON data, do
//
//     final stockModel = stockModelFromJson(jsonString);

import 'dart:convert';

List<StockModel> stockModelFromJson(String str) => List<StockModel>.from(json.decode(str).map((x) => StockModel.fromJson(x)));

String stockModelToJson(List<StockModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockModel {
    String id;
    List<Material> materialConsumed;
    String materialId;
    String materialName;
    List<Material> materialReceived;
    List<ProcurementOrder> procurementOrder;
    String siteId;
    int totalMaterialConsumed;
    int totalMaterialReceived;
    int totalProcurementOrder;

    StockModel({
        required this.id,
        required this.materialConsumed,
        required this.materialId,
        required this.materialName,
        required this.materialReceived,
        required this.procurementOrder,
        required this.siteId,
        required this.totalMaterialConsumed,
        required this.totalMaterialReceived,
        required this.totalProcurementOrder,
    });

    factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        id: json["id"],
        materialConsumed: List<Material>.from(json["materialConsumed"].map((x) => Material.fromJson(x))),
        materialId: json["materialId"],
        materialName: json["materialName"],
        materialReceived: List<Material>.from(json["materialReceived"].map((x) => Material.fromJson(x))),
        procurementOrder: List<ProcurementOrder>.from(json["procurementOrder"].map((x) => ProcurementOrder.fromJson(x))),
        siteId: json["siteId"],
        totalMaterialConsumed: json["totalMaterialConsumed"],
        totalMaterialReceived: json["totalMaterialReceived"],
        totalProcurementOrder: json["totalProcurementOrder"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "materialConsumed": List<dynamic>.from(materialConsumed.map((x) => x.toJson())),
        "materialId": materialId,
        "materialName": materialName,
        "materialReceived": List<dynamic>.from(materialReceived.map((x) => x.toJson())),
        "procurementOrder": List<dynamic>.from(procurementOrder.map((x) => x.toJson())),
        "siteId": siteId,
        "totalMaterialConsumed": totalMaterialConsumed,
        "totalMaterialReceived": totalMaterialReceived,
        "totalProcurementOrder": totalProcurementOrder,
    };
}

class Material {
    DateTime date;
    int quantity;

    Material({
        required this.date,
        required this.quantity,
    });

    factory Material.fromJson(Map<String, dynamic> json) => Material(
        date: DateTime.parse(json["date"]),
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "quantity": quantity,
    };
}

class ProcurementOrder {
    DateTime orderDate;
    int orderQuantity;

    ProcurementOrder({
        required this.orderDate,
        required this.orderQuantity,
    });

    factory ProcurementOrder.fromJson(Map<String, dynamic> json) => ProcurementOrder(
        orderDate: DateTime.parse(json["orderDate"]),
        orderQuantity: json["orderQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "orderDate": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "orderQuantity": orderQuantity,
    };
}
