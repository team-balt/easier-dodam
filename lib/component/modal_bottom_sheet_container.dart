import 'package:easier_dodam/component/theme/color.dart';
import 'package:flutter/material.dart';

class ModalBottomSheetContainer extends StatelessWidget {
  final Widget child;

  const ModalBottomSheetContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: EasierDodamColors.staticWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: EasierDodamColors.gray500,
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          child
        ],
      ),
    );
  }
}
