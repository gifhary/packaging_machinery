import 'package:flutter/material.dart';

class IniTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final String? hintText;
  const IniTextField({Key? key, this.label, this.controller, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Text(label ?? ""),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(117, 111, 99, 1), width: 1),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(117, 111, 99, 1), width: 1),
              ),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
