import 'package:open_scooter_ui/feature/domain/entities/cost_entity.dart';

class CostModel extends CostEntity {
  CostModel({required double unlock, required double minute})
      : super(unlock: unlock, minute: minute);

  factory CostModel.fromJson(Map<String, dynamic> json) {
    return CostModel(
        unlock: json['unlock'].toDouble(), minute: json['minute'].toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'unlock': this.unlock, 'minute': this.minute};
  }
}
