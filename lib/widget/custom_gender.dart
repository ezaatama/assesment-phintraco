import 'package:flutter/material.dart';
import 'package:phintraco_assesment/models/gender.dart';
import 'package:phintraco_assesment/utils/constant.dart';

class CustomGender extends StatefulWidget {
  const CustomGender(
      {Key? key,
      required this.value,
      required this.groupValue,
      this.onChanged,
      this.item})
      : super(key: key);
  final int value;
  final int groupValue;
  final void Function(int?)? onChanged;
  final RadioGenderModel? item;

  @override
  State<CustomGender> createState() => _CustomGenderState();
}

class _CustomGenderState extends State<CustomGender> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool selected = widget.value != widget.groupValue;
        if (selected) {
          widget.onChanged!(widget.value);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Container(
          width: 120,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: widget.value == widget.groupValue
                ? ColorUI.BLUE.withOpacity(0.20)
                : Colors.transparent,
            border: Border.all(
                width: 1.0,
                color: widget.value == widget.groupValue
                    ? ColorUI.BLUE
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(widget.item!.image, width: 35, height: 35),
              const SizedBox(height: 8),
              Text(widget.item!.text,
                  style: BLACK_TEXT_STYLE.copyWith(
                      fontSize: 14,
                      fontWeight: FontUI.WEIGHT_SEMI_BOLD,
                      color: ColorUI.BLACK.withOpacity(0.70)))
            ],
          ),
        ),
      ),
    );
  }
}
