class AdditionalProp {
  AdditionalProp();

  AdditionalProp.fromJson(Map<String, dynamic> json) {
    // TODO: implement AdditionalProp.fromJson
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

}

class Tags {
  AdditionalProp? additionalProp1;

  Tags({this.additionalProp1});

  Tags.fromJson(Map<String, dynamic> json) {
    additionalProp1 = json['additionalProp1'] != null ? AdditionalProp?.fromJson(json['additionalProp1']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['additionalProp1'] = additionalProp1!.toJson();
    return data;
  }
}