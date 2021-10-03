import 'package:open_scooter_ui/feature/domain/entities/balance_entity.dart';

import 'credit_card_model.dart';

class BalanceModel extends BalanceEntity {
  BalanceModel({required amount, required unit, required cards})
      : super(amount: amount, unit: unit, cards: cards);

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
        amount: json['amount'],
        unit: json['unit'],
        cards: (json['cards'] as List)
            .map((e) => CreditCardModel.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {'amount': this.amount, 'unit': this.unit, 'cards': this.cards};
  }
}
