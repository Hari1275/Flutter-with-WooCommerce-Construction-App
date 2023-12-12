// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) =>
    List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  Orders({
    this.id,
    this.parentId,
    this.status,
    this.orderKey,
    this.number,
    this.currency,
    this.version,
    this.pricesIncludeTax,
    this.dateCreated,
    this.dateModified,
    this.customerId,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.createdVia,
    this.customerNote,
    this.dateCompleted,
    this.datePaid,
    this.cartHash,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.refunds,
    this.links,
  });

  int? id;
  int? parentId;
  String? status;
  String? orderKey;
  String? number;
  Currency? currency;
  Version? version;
  bool? pricesIncludeTax;
  DateTime? dateCreated;
  DateTime? dateModified;
  int? customerId;
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? cartTax;
  String? total;
  String? totalTax;
  Ing? billing;
  Ing? shipping;
  PaymentMethod? paymentMethod;
  PaymentMethodTitle? paymentMethodTitle;
  TransactionId? transactionId;
  String? customerIpAddress;
  String? customerUserAgent;
  CreatedVia? createdVia;
  CustomerNote? customerNote;
  DateTime? dateCompleted;
  DateTime? datePaid;
  String? cartHash;
  List<LineItem>? lineItems;
  List<dynamic>? taxLines;
  List<dynamic>? shippingLines;
  List<dynamic>? feeLines;
  List<dynamic>? couponLines;
  List<dynamic>? refunds;
  Links? links;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json["id"],
        parentId: json["parent_id"],
        status: json["status"],
        orderKey: json["order_key"],
        number: json["number"],
        currency: currencyValues.map![json["currency"]],
        version: versionValues.map![json["version"]],
        pricesIncludeTax: json["prices_include_tax"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateModified: DateTime.parse(json["date_modified"]),
        customerId: json["customer_id"],
        discountTotal: json["discount_total"],
        discountTax: json["discount_tax"],
        shippingTotal: json["shipping_total"],
        shippingTax: json["shipping_tax"],
        cartTax: json["cart_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        billing: Ing.fromJson(json["billing"]),
        shipping: Ing.fromJson(json["shipping"]),
        paymentMethod: paymentMethodValues.map![json["payment_method"]],
        paymentMethodTitle:
            paymentMethodTitleValues.map![json["payment_method_title"]],
        transactionId: transactionIdValues.map![json["transaction_id"]],
        customerIpAddress: json["customer_ip_address"],
        customerUserAgent: json["customer_user_agent"],
        createdVia: createdViaValues.map![json["created_via"]],
        customerNote: customerNoteValues.map![json["customer_note"]],
        dateCompleted: DateTime.tryParse(json["date_completed"].toString()),
        datePaid: DateTime.tryParse(json["date_paid"].toString()),
        cartHash: json["cart_hash"],
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
        shippingLines: List<dynamic>.from(json["shipping_lines"].map((x) => x)),
        feeLines: List<dynamic>.from(json["fee_lines"].map((x) => x)),
        couponLines: List<dynamic>.from(json["coupon_lines"].map((x) => x)),
        refunds: List<dynamic>.from(json["refunds"].map((x) => x)),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "status": status,
        "order_key": orderKey,
        "number": number,
        "currency": currencyValues.reverse![currency],
        "version": versionValues.reverse![version],
        "prices_include_tax": pricesIncludeTax,
        "date_created": dateCreated!.toIso8601String(),
        "date_modified": dateModified!.toIso8601String(),
        "customer_id": customerId,
        "discount_total": discountTotal,
        "discount_tax": discountTax,
        "shipping_total": shippingTotal,
        "shipping_tax": shippingTax,
        "cart_tax": cartTax,
        "total": total,
        "total_tax": totalTax,
        "billing": billing!.toJson(),
        "shipping": shipping!.toJson(),
        "payment_method": paymentMethodValues.reverse![paymentMethod],
        "payment_method_title":
            paymentMethodTitleValues.reverse![paymentMethodTitle],
        "transaction_id": transactionIdValues.reverse![transactionId],
        "customer_ip_address": customerIpAddress,
        "customer_user_agent": customerUserAgent,
        "created_via": createdViaValues.reverse![createdVia],
        "customer_note": customerNoteValues.reverse![customerNote],
        "date_completed": dateCompleted!.toIso8601String(),
        "date_paid": datePaid!.toIso8601String(),
        "cart_hash": cartHash,
        "line_items": List<dynamic>.from(lineItems!.map((x) => x.toJson())),
        "tax_lines": List<dynamic>.from(taxLines!.map((x) => x)),
        "shipping_lines": List<dynamic>.from(shippingLines!.map((x) => x)),
        "fee_lines": List<dynamic>.from(feeLines!.map((x) => x)),
        "coupon_lines": List<dynamic>.from(couponLines!.map((x) => x)),
        "refunds": List<dynamic>.from(refunds!.map((x) => x)),
        "_links": links!.toJson(),
      };
}

class Ing {
  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  State? state;
  String? postcode;
  Country? country;
  Email? email;
  String? phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: stateValues.map![json["state"]],
        postcode: json["postcode"],
        country: countryValues.map![json["country"]],
        email: json["email"] == null ? null : emailValues.map![json["email"]],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": stateValues.reverse![state],
        "postcode": postcode,
        "country": countryValues.reverse![country],
        "email": email == null ? null : emailValues.reverse![email],
        "phone": phone,
      };
}

enum Country { IN, EMPTY, US }

final countryValues =
    EnumValues({"": Country.EMPTY, "IN": Country.IN, "US": Country.US});

enum Email { CHIRUCHANDER59_GMAIL_COM, MANOJMDMANOJ007_GMAIL_COM }

final emailValues = EnumValues({
  "chiruchander59@gmail.com": Email.CHIRUCHANDER59_GMAIL_COM,
  "manojmdmanoj007@gmail.com": Email.MANOJMDMANOJ007_GMAIL_COM
});

enum State { KA, EMPTY, CA }

final stateValues =
    EnumValues({"CA": State.CA, "": State.EMPTY, "KA": State.KA});

enum CreatedVia { CHECKOUT }

final createdViaValues = EnumValues({"checkout": CreatedVia.CHECKOUT});

enum Currency { INR }

final currencyValues = EnumValues({"INR": Currency.INR});

enum CustomerNote { EXE, SHASHANK }

final customerNoteValues =
    EnumValues({"exe": CustomerNote.EXE, "shashank": CustomerNote.SHASHANK});

class LineItem {
  LineItem({
    this.id,
    this.name,
    this.sku,
    this.productId,
    this.variationId,
    this.quantity,
    this.taxClass,
    this.price,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.taxes,
    this.meta,
    this.metakey,
  });

  int? id;
  String? name;
  String? sku;
  int? productId;
  int? variationId;
  int? quantity;
  String? taxClass;
  String? price;
  String? subtotal;
  String? subtotalTax;
  String? total;
  String? totalTax;
  List<dynamic>? taxes;
  List<dynamic>? meta;
  String? metakey;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        taxClass: json["tax_class"],
        price: json["price"],
        subtotal: json["subtotal"],
        subtotalTax: json["subtotal_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
        metakey: json["metakey"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku": sku,
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
        "tax_class": taxClass,
        "price": price,
        "subtotal": subtotal,
        "subtotal_tax": subtotalTax,
        "total": total,
        "total_tax": totalTax,
        "taxes": List<dynamic>.from(taxes!.map((x) => x)),
        "meta": List<dynamic>.from(meta!.map((x) => x)),
        "metakey": metakey,
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

enum PaymentMethod { COD, RAZORPAY }

final paymentMethodValues =
    EnumValues({"cod": PaymentMethod.COD, "razorpay": PaymentMethod.RAZORPAY});

enum PaymentMethodTitle { CASH_ON_DELIVERY, CREDIT_CARD_DEBIT_CARD_NET_BANKING }

final paymentMethodTitleValues = EnumValues({
  "Cash on delivery": PaymentMethodTitle.CASH_ON_DELIVERY,
  "Credit Card/Debit Card/NetBanking":
      PaymentMethodTitle.CREDIT_CARD_DEBIT_CARD_NET_BANKING
});

enum Status { COMPLETED }

final statusValues = EnumValues({"completed": Status.COMPLETED});

enum TransactionId { EMPTY, PAY_JL_NZ_TZ_XEJND_AO_Y, PAY_JND8_L_YZ_AN_YU0_Y_K }

final transactionIdValues = EnumValues({
  "": TransactionId.EMPTY,
  "pay_JlNzTzXEJNDAoY": TransactionId.PAY_JL_NZ_TZ_XEJND_AO_Y,
  "pay_JND8lYZAnYu0yK": TransactionId.PAY_JND8_L_YZ_AN_YU0_Y_K
});

enum Version { THE_601 }

final versionValues = EnumValues({"6.0.1": Version.THE_601});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
