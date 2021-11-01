import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_state.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterSMSCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      return Container(
          padding: EdgeInsets.all(30),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Enter code from SMS"),
            Container(
                margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
                child: PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 20, color: Colors.white),
                    colorBuilder:
                        FixedColorBuilder(Colors.white.withOpacity(0.3)),
                  ),
                  onCodeSubmitted: (code) {
                    _enterCode(context, code);
                  },
                  codeLength: 4,
                  onCodeChanged: (code) {
                    if (code!.length == 4) {
                      //TODO: change to previous state
                      // FocusScope.of(context).requestFocus(FocusNode());
                      _enterCode(context, code);
                    }
                  },
                ))
          ]));
    });
  }

  void _enterCode(BuildContext context, String code) {
    BlocProvider.of<UserCubit>(context).enterCode(code);
  }
}
