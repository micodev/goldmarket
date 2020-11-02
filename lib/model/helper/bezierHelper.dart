import 'package:goldmarket/model/core/bezier_data.dart';
import 'package:goldmarket/model/service/Api/SystemApi.dart';

class BezierHelper {
  final api = SystemApi();
  Future<List<BezierData>> fetchBezier() async {
    var json = await api.fetchBezier();
    List<BezierData> beziers;
    if (json['bezier'] != null) {
      beziers = new List<BezierData>();
      json['bezier'].forEach((v) {
        beziers.add(new BezierData.fromJson(v));
      });
    }
    return beziers;
  }
}
