import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';

class BalanceEntity {
  final int amount;
  final String unit;
  final List<CreditCardEntity> cards;

  BalanceEntity(
      {required this.amount, required this.unit, required this.cards});
}
