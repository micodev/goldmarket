class BezierData {
  int day;
  double value;

  BezierData({this.day, this.value});

  BezierData.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    value = double.parse(json['value'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['value'] = this.value;
    return data;
  }
}
