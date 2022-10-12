class GetTapPaymentModel {
  String? buttonConfirm;
  var amount;
  List<Products>? products;
  String? publicKey;
  var itemprice1;
  String? itemname1;
  String? currencycode;
  String? ordid;
  String? entryChargeMode;
  String? cstemail;
  String? cstid;
  String? phoneCode;
  var tapCustomerId;
  String? cstfname;
  String? cstlname;
  String? cstmobile;
  String? cntry;
  String? returnurl;

  GetTapPaymentModel(
      {this.buttonConfirm,
      this.amount,
      this.products,
      this.publicKey,
      this.itemprice1,
      this.itemname1,
      this.currencycode,
      this.ordid,
      this.entryChargeMode,
      this.cstemail,
      this.cstid,
      this.phoneCode,
      this.tapCustomerId,
      this.cstfname,
      this.cstlname,
      this.cstmobile,
      this.cntry,
      this.returnurl});

  GetTapPaymentModel.fromJson(Map<String, dynamic> json) {
    buttonConfirm = json['button_confirm'];
    amount = json['amount'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
    publicKey = json['public_key'];
    itemprice1 = json['itemprice1'];
    itemname1 = json['itemname1'];
    currencycode = json['currencycode'];
    ordid = json['ordid'];
    entryChargeMode = json['entry_charge_mode'];
    cstemail = json['cstemail'];
    cstid = json['cstid'];
    phoneCode = json['phone_code'];
    tapCustomerId = json['tap_customer_id'];
    cstfname = json['cstfname'];
    cstlname = json['cstlname'];
    cstmobile = json['cstmobile'];
    cntry = json['cntry'];
    returnurl = json['returnurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['button_confirm'] = this.buttonConfirm;
    data['amount'] = this.amount;
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    data['public_key'] = this.publicKey;
    data['itemprice1'] = this.itemprice1;
    data['itemname1'] = this.itemname1;
    data['currencycode'] = this.currencycode;
    data['ordid'] = this.ordid;
    data['entry_charge_mode'] = this.entryChargeMode;
    data['cstemail'] = this.cstemail;
    data['cstid'] = this.cstid;
    data['phone_code'] = this.phoneCode;
    data['tap_customer_id'] = this.tapCustomerId;
    data['cstfname'] = this.cstfname;
    data['cstlname'] = this.cstlname;
    data['cstmobile'] = this.cstmobile;
    data['cntry'] = this.cntry;
    data['returnurl'] = this.returnurl;
    return data;
  }
}

class Products {
  String? cartId;
  String? productId;
  String? name;
  String? model;
  String? shipping;
  String? image;
  List<Null>? option;
  List<Null>? download;
  String? quantity;
  String? minimum;
  String? subtract;
  bool? stock;
  var price;
  var total;
  var reward;
  var points;
  String? taxClassId;
  int? weight;
  String? weightClassId;
  String? length;
  String? width;
  String? height;
  String? lengthClassId;
  bool? recurring;

  Products(
      {this.cartId,
      this.productId,
      this.name,
      this.model,
      this.shipping,
      this.image,
      this.option,
      this.download,
      this.quantity,
      this.minimum,
      this.subtract,
      this.stock,
      this.price,
      this.total,
      this.reward,
      this.points,
      this.taxClassId,
      this.weight,
      this.weightClassId,
      this.length,
      this.width,
      this.height,
      this.lengthClassId,
      this.recurring});

  Products.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productId = json['product_id'];
    name = json['name'];
    model = json['model'];
    shipping = json['shipping'];
    image = json['image'];
    if (json['option'] != null) {
      option = <Null>[];
      json['option'].forEach((v) {
//        option.add(new Null.fromJson(v));
      });
    }
    if (json['download'] != null) {
      download = <Null>[];
      json['download'].forEach((v) {
        //      download.add(new Null.fromJson(v));
      });
    }
    quantity = json['quantity'];
    minimum = json['minimum'];
    subtract = json['subtract'];
    stock = json['stock'];
    price = json['price'];
    total = json['total'];
    reward = json['reward'];
    points = json['points'];
    taxClassId = json['tax_class_id'];
    weight = json['weight'];
    weightClassId = json['weight_class_id'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    lengthClassId = json['length_class_id'];
    recurring = json['recurring'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['model'] = this.model;
    data['shipping'] = this.shipping;
    data['image'] = this.image;
    if (this.option != null) {
      //    data['option'] = this.option.map((v) => v.toJson()).toList();
    }
    if (this.download != null) {
//      data['download'] = this.download.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['minimum'] = this.minimum;
    data['subtract'] = this.subtract;
    data['stock'] = this.stock;
    data['price'] = this.price;
    data['total'] = this.total;
    data['reward'] = this.reward;
    data['points'] = this.points;
    data['tax_class_id'] = this.taxClassId;
    data['weight'] = this.weight;
    data['weight_class_id'] = this.weightClassId;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['length_class_id'] = this.lengthClassId;
    data['recurring'] = this.recurring;
    return data;
  }
}
