import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:flutter/material.dart';

class EasierDodamTextField extends StatefulWidget {
  // const EasierDodamTextField({super.key});

  final String? labelText;
  final String? hintText;
  final String? supportText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool obscureText;

  const EasierDodamTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.supportText,
    this.focusNode,
    this.controller,
    this.obscureText = false,
  });

  @override
  State<EasierDodamTextField> createState() => _EasierDodamTextFieldState();
}

class _EasierDodamTextFieldState extends State<EasierDodamTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            widget.labelText ?? "",
            style: EasierDodamStyles.label1.copyWith(
              fontSize: 14.0,
              height: 1.2,
              color: _focusNode.hasFocus
                  ? EasierDodamColors.primary300
                  : EasierDodamColors.gray700,
            ),
          ),
        ),
        Positioned(
          child: TextFormField(
            focusNode: _focusNode,
            controller: _controller,
            style: EasierDodamStyles.label1.copyWith(height: 1.3),
            textAlignVertical: TextAlignVertical.center,
            cursorColor: EasierDodamColors.primary300,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: EasierDodamStyles.label1.copyWith(height: 1.3),
              helperText: widget.supportText,
              helperStyle: EasierDodamStyles.label1.copyWith(
                fontSize: 14,
                height: 1.4,
              ),
              fillColor: EasierDodamColors.primary300,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: EasierDodamColors.gray400,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: EasierDodamColors.primary300,
                ),
              ),
              errorBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
