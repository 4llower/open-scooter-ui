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

class UserPhoneInput extends UserState {
  final String phone;

  UserPhoneInput({required this.phone});

  @override
  List<Object> get props => [];
}

class UserSendingSMS extends UserState {
  UserSendingSMS();

  @override
  List<Object> get props => [];
}

class UserSentSMS extends UserState {
  UserSentSMS();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  UserLoading();

  @override
  List<Object> get props => [];
}

class UserLogin extends UserState {
  final UserEntity user;

  UserLogin({required this.user});
  @override
  List<Object> get props => [];
}
