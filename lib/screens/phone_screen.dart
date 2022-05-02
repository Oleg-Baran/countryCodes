import 'package:flutter/material.dart';
import 'package:phone_code/widgets/country_item.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final phoneController = TextEditingController();

  final maskFormatter = MaskTextInputFormatter(mask: '(###) ### ####');
  bool validPhone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8EAAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(),
              body(),
              nextBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Text(
        "Get Started",
        style: TextStyle(
            color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget nextBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            if (validPhone) {
              print("work!");
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(15),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                color: !validPhone
                    ? const Color.fromRGBO(244, 245, 255, 0.4)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Image.asset("./assets/images/arrow_right.png"),
          ),
        )
      ],
    );
    ;
  }

  Widget body() {
    return Expanded(
      child: Center(
        child: Row(
          children: [
            countryCode(),
            const SizedBox(width: 8),
            phoneNum(),
          ],
        ),
      ),
    );
  }

  Widget countryCode() {
    return GestureDetector(
      onTap: (() {
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: const Color(0xFF8EAAFB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            context: context,
            builder: (BuildContext bc) {
              return const FractionallySizedBox(
                  heightFactor: 0.93, child: CountryItem());
            });
      }),
      child: Container(
        height: 48,
        width: 80,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 245, 255, 0.4),
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                '🇺🇦',
                style: TextStyle(fontSize: 28),
              ),
              Text('+380'),
            ],
          ),
        ),
      ),
    );
  }

  Widget phoneNum() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 48,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 245, 255, 0.4),
            borderRadius: BorderRadius.circular(16)),
        child: TextFormField(
          keyboardType: TextInputType.phone,
          style: const TextStyle(fontSize: 16),
          maxLength: 15,
          inputFormatters: [maskFormatter],
          decoration: const InputDecoration(
              hintText: "(123) 123 1234",
              counterText: "",
              border: InputBorder.none),
          controller: phoneController,
          onSaved: (value) {
            phoneController.text = value.toString();
          },
          onChanged: (v) {
            setState(() {
              if (phoneController.text.length == 14) {
                validPhone = true;
              } else {
                validPhone = false;
              }
            });
          },
        ),
      ),
    );
  }
}
