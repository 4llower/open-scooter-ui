import 'package:equatable/equatable.dart';

class CreditCardEntity extends Equatable {
  final String type;
  final String id;

  CreditCardEntity({required this.type, required this.id});

  @override
  List<Object> get props => [id];
}
