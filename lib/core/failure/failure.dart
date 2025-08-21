class FailureItem  {
  final List<dynamic> loc;
  final String msg;
  final String type;

  FailureItem({
    required this.loc,
    required this.msg,
    required this.type,
  });

  factory FailureItem.fromJson(Map<String, dynamic> json) {
    return FailureItem(
      loc: json['loc'] as List<dynamic>,
      msg: json['msg'] as String,
      type: json['type'] as String,
    );
  }
}

class FailureResponse {
  final List<FailureItem> detail;

  FailureResponse({required this.detail});

  factory FailureResponse.fromJson(Map<String, dynamic> json) {
    return FailureResponse(
      detail: (json['detail'] as List)
          .map((item) => FailureItem.fromJson(item))
          .toList(),
    );
  }
}