import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';

class EnterCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EnterCreditCard();
  }
}

class EnterCreditCard extends State<EnterCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.grey.withOpacity(0.7), width: 2.0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Add form labels to config
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          // decoration: BoxDecoration(boxShadow: <BoxShadow>[
          //   BoxShadow(
          //       color: Colors.black54, blurRadius: 15.0, offset: Offset(0, 8))
          // ],
          // borderRadius: BorderRadius.all(Radius.circular(15))),
          child: SafeArea(
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: Colors.blue.shade700,
                  onCreditCardWidgetChange: (nice) => {}),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(children: [
                  CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      themeColor: Theme.of(context).colorScheme.primary,
                      cardNumberDecoration: InputDecoration(
                        labelText: "Number",
                        hintText: 'XXXX XXXX XXXX XXXX',
                        hintStyle: const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: border,
                        enabledBorder: border,
                      ),
                      expiryDateDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'Card Holder',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      onCreditCardModelChange: _onCreditCardModelChange),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text("Glassmorphism",
                  //         style: TextStyle(color: Colors.white, fontSize: 18)),
                  //     Switch(
                  //         value: useGlassMorphism,
                  //         inactiveTrackColor: Colors.grey,
                  //         activeColor: Colors.white,
                  //         activeTrackColor: Colors.green,
                  //         onChanged: (bool value) => setState(() {
                  //               useGlassMorphism = value;
                  //             })),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _inputSucceed(context);
                        }
                      },
                      child: Container(
                          margin: const EdgeInsets.all(12),
                          child: const Text("Add",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'halter',
                                  fontSize: 14,
                                  package: 'flutter_credit_card'))))
                ]),
              ))
            ]),
          ),
        ));
  }

  void _onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Map<String, String> _formInput() {
    return {
      "CARD_NUMBER": cardNumber,
      "CARD_HOLDER": cardHolderName,
      "CARD_CVV": cvvCode,
      "CARD_EXPIRY_DATE": expiryDate
    };
  }

  void _inputSucceed(BuildContext context) {
    final input = _formInput();
    Navigator.of(context).pop(input);
  }
}
