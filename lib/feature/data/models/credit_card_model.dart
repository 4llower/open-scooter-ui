import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';

class CreditCardModel extends CreditCardEntity {
  CreditCardModel({required type, required id}) : super(type: type, id: id);

  factory CreditCardModel.fromJson(Map<String, dynamic> json) {
    return CreditCardModel(id: json['id'], type: json['type']);
  }

  Map<String, dynamic> toJson() {
    return {'id': this.id, 'type': this.type};
  }
}
