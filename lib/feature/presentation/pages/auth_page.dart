import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_state.dart';
import 'package:open_scooter_ui/feature/presentation/pages/map_page.dart';
import 'package:open_scooter_ui/feature/presentation/widgets/forms/enter_phone.dart';
import 'package:open_scooter_ui/feature/presentation/widgets/forms/enter_sms.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserLogin) return MapPage();
      if (state is UserSentSMS) return EnterSMSCode();
      return EnterPhone();
    }));
  }
}
