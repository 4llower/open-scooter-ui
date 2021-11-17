import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_state.dart';

class EnterPhone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EnterPhone();
  }
}

class _EnterPhone extends State<EnterPhone> {
  String initialCountry = 'BY';
  final TextEditingController controller = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'BY');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserSendingSMS)
        return Container(
            alignment: Alignment.center, child: CircularProgressIndicator());
      if (state is UserLoading) {
        // _tryLoadUser(context);
        return CircularProgressIndicator();
      }

      return Container(
          padding: EdgeInsets.all(30.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              children: [Text("Enter your phone number")],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  _updatePhoneNumber(context, number.phoneNumber ?? '');
                },
                inputDecoration: InputDecoration(hintText: "29 29-327-42"),
                spaceBetweenSelectorAndTextField: 4,
                textFieldController: controller,
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                ),
                ignoreBlank: false,
                initialValue: number,
                selectorTextStyle: TextStyle(color: Colors.white),
                formatInput: true,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
              ),
            ),
            Row(
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    _sendMessage(context);
                  },
                  child: Text('Send'),
                )
              ],
            )
          ]));
    });
  }

  void _updatePhoneNumber(BuildContext context, String phone) {
    BlocProvider.of<UserCubit>(context).updatePhone(phone);
  }

  void _sendMessage(BuildContext context) {
    BlocProvider.of<UserCubit>(context).sendSMSCode();
  }

  void _tryLoadUser(BuildContext context) async {
    BlocProvider.of<UserCubit>(context).tryLoadUser();
  }
}
