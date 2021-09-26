import 'package:equatable/equatable.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserNotLogin extends UserState {
  @override
  List<Object> get props => [];
}

class UserSendSMS extends UserState {
  UserSendSMS();

  @override
  List<Object> get props => [];
}

class UserLogin extends UserState {
  final UserEntity user;

  UserLogin({required this.user});
  @override
  List<Object> get props => [];
}
