import 'package:open_scooter_ui/feature/domain/entities/cost_entity.dart';

class CostModel extends CostEntity {
  CostModel({required unlock, required minute})
      : super(unlock: unlock, minute: minute);

  factory CostModel.fromJson(Map<String, dynamic> json) {
    return CostModel(unlock: json['unlock'], minute: json['minute']);
  }

  Map<String, dynamic> toJson() {
    return {'unlock': this.unlock, 'minute': this.minute};
  }
}
