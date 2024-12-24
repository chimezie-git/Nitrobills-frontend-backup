import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class DoubleTextField extends StatefulWidget {
  static const String firstNameHint = "First name";
  static const String lastNameHint = "Last name";
  final TextEditingController firstNameCntrl;
  final TextEditingController lastNameCntrl;
  final bool forcedError;
  final String? forcedErrorString;
  final void Function(String?)? onChanged;

  const DoubleTextField({
    super.key,
    required this.firstNameCntrl,
    required this.lastNameCntrl,
    required this.forcedError,
    required this.forcedErrorString,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DoubleTextFieldState createState() => _DoubleTextFieldState();
}

class _DoubleTextFieldState extends State<DoubleTextField> {
  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;
  Color borderColor = const Color(0xFFBBB9B9);

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _firstNameFocusNode.addListener(() {
      setState(() {
        borderColor =
            _firstNameFocusNode.hasFocus || _lastNameFocusNode.hasFocus
                ? Colors.black
                : const Color(0xFFBBB9B9);
      });
    });
    _lastNameFocusNode.addListener(() {
      setState(() {
        borderColor =
            _firstNameFocusNode.hasFocus || _lastNameFocusNode.hasFocus
                ? Colors.black
                : const Color(0xFFBBB9B9);
      });
    });
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose(); 
    _lastNameFocusNode.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? errorText;
    if (widget.forcedError) {
      borderColor = NbColors.red;
      errorText = widget.forcedErrorString;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 62.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          child: _textField(
            widget.firstNameCntrl,
            DoubleTextField.firstNameHint,
            TextInputType.text,
            focusNode: _firstNameFocusNode, 
            onChanged: widget.onChanged,
          ),
        ),
        Container(
          height: 62.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
            border: Border(
              bottom: BorderSide(color: borderColor, width: 1),
              left: BorderSide(color: borderColor, width: 1),
              right: BorderSide(color: borderColor, width: 1),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          child: _textField(
            widget.lastNameCntrl,
            DoubleTextField.lastNameHint,
            TextInputType.text,
            focusNode: _lastNameFocusNode, 
            onChanged: widget.onChanged,
          ),
        ),
        if (errorText != null) NbText.sp12(errorText).setColor(borderColor),
      ],
    );
  }
}

class TrippleTextField extends StatefulWidget {
  static const String userNameHint = "Username";
  static const String emailHint = "Email address";
  static const String phoneHint = "Phone number (080-XXX-XXX-XXXX)";

  final TextEditingController userNameCntrl;
  final TextEditingController phoneNumCntrl;
  final TextEditingController emailCntrl;
  final bool forcedError;
  final String? forcedErrorString;
  final void Function(String?)? onChanged;

  const TrippleTextField({
    super.key,
    required this.userNameCntrl,
    required this.phoneNumCntrl,
    required this.emailCntrl,
    required this.forcedError,
    required this.forcedErrorString,
    required this.onChanged,
  });

  @override
  _TrippleTextFieldState createState() => _TrippleTextFieldState();
}

class _TrippleTextFieldState extends State<TrippleTextField> {
  late FocusNode _userNameFocusNode;
  late FocusNode _phoneNumFocusNode;
  late FocusNode _emailFocusNode;
  Color borderColor = const Color(0xFFBBB9B9); 

  @override
  void initState() {
    super.initState();
    _userNameFocusNode = FocusNode();
    _phoneNumFocusNode = FocusNode();
    _emailFocusNode = FocusNode();

    _userNameFocusNode.addListener(_updateBorderColor);
    _phoneNumFocusNode.addListener(_updateBorderColor);
    _emailFocusNode.addListener(_updateBorderColor);
  }

  void _updateBorderColor() {
    setState(() {
      borderColor = _userNameFocusNode.hasFocus ||
              _phoneNumFocusNode.hasFocus ||
              _emailFocusNode.hasFocus
          ? Colors.black
          : const Color(0xFFBBB9B9);
    });
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose(); 
    _phoneNumFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? errorText;
    if (widget.forcedError) {
      borderColor = Colors.red;
      errorText = widget.forcedErrorString;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 62.0, 
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16.0)),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _textField(
            widget.userNameCntrl,
            TrippleTextField.userNameHint,
            TextInputType.text,
            focusNode: _userNameFocusNode,
            onChanged: widget.onChanged,
          ),
        ),
        Container(
          height: 62.0, 
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: borderColor, width: 1),
              left: BorderSide(color: borderColor, width: 1),
              right: BorderSide(color: borderColor, width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _textField(
            widget.phoneNumCntrl,
            TrippleTextField.phoneHint,
            TextInputType.phone,
            focusNode: _phoneNumFocusNode, 
            onChanged: widget.onChanged,
          ),
        ),
        Container(
          height: 62.0, 
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(16.0)),
            border: Border(
              bottom: BorderSide(color: borderColor, width: 1),
              left: BorderSide(color: borderColor, width: 1),
              right: BorderSide(color: borderColor, width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _textField(
            widget.emailCntrl,

            TrippleTextField.emailHint,
            TextInputType.emailAddress,
            focusNode: _emailFocusNode,
            onChanged: widget.onChanged,
          ),
        ),
        if (errorText != null)
          Text(
            errorText,
            style: TextStyle(color: borderColor),
          ),
      ],
    );
  }
}

class PlainTextField extends StatefulWidget {
  final TextEditingController? cntrl;
  final String? hint;
  final TextInputType? keyboardType;
  final double? fieldHeight;
  final bool obscureText;
  final Color fieldColor;
  final bool enable;
  final String? Function() textValidator;
  final bool forcedError;
  final String? forcedErrorString;
  final void Function(String?)? onChanged;

  const PlainTextField({
    super.key,
    required this.cntrl,
    required this.hint,
    required this.keyboardType,
    required this.fieldHeight,
    required this.obscureText,
    required this.fieldColor,
    required this.enable,
    required this.textValidator,
    required this.forcedError,
    required this.forcedErrorString,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PlainTextFieldState createState() => _PlainTextFieldState();
}

class _PlainTextFieldState extends State<PlainTextField> {
  late FocusNode _focusNode;
  Color borderColor = const Color(0xFFBBB9B9); 

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        borderColor =
            _focusNode.hasFocus ? Colors.black : const Color(0xFFBBB9B9);
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? errorText;
    if (widget.forcedError) {
      borderColor = NbColors.red;
      errorText = widget.forcedErrorString;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.fieldHeight ?? 62.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.fieldColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          child: _textField(
            widget.cntrl,
            widget.hint,
            widget.keyboardType,
            obscureText: widget.obscureText,
            enabled: widget.enable,
            onChanged: widget.onChanged,
            focusNode: _focusNode, 
          ),
        ),
        if (errorText != null) NbText.sp12(errorText).setColor(borderColor),
      ],
    );
  }
}

class IconTextField extends StatefulWidget {
  final TextEditingController? cntrl;
  final String? hint;
  final TextInputType? keyboardType;
  final double? fieldHeight;
  final bool obscureText;
  final Color fieldColor;
  final bool enable;
  final Widget? trailing;
  final String? Function() textValidator;
  final bool forcedError;
  final String? forcedErrorString;
  final void Function(String?)? onChanged;

  const IconTextField({
    super.key,
    required this.cntrl,
    required this.hint,
    required this.trailing,
    required this.keyboardType,
    required this.fieldHeight,
    required this.obscureText,
    required this.fieldColor,
    required this.enable,
    required this.textValidator,
    required this.forcedError,
    required this.forcedErrorString,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _IconTextFieldState createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<IconTextField> {
  late FocusNode _focusNode;
  Color borderColor = const Color(0xFFBBB9B9);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        borderColor =
            _focusNode.hasFocus ? Colors.black : const Color(0xFFBBB9B9);
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? errorText;
    if (widget.forcedError) {
      borderColor = NbColors.red;
      errorText = widget.forcedErrorString;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.fieldHeight ?? 62.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.fieldColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          child: Row(
            children: [
              Expanded(
                child: _textField(
                  widget.cntrl,
                  widget.hint,
                  widget.keyboardType,
                  obscureText: widget.obscureText,
                  enabled: widget.enable,
                  onChanged: widget.onChanged,
                  focusNode:
                      _focusNode,
                ),
              ),
              widget.trailing ?? const SizedBox.shrink(),
            ],
          ),
        ),
        if (errorText != null) NbText.sp12(errorText).setColor(borderColor),
      ],
    );
  }
}

TextField _textField(
  TextEditingController? controller,
  String? hint,
  TextInputType? keyboardType, {
  bool obscureText = false,
  bool enabled = true,
  required void Function(String?)? onChanged,
  FocusNode? focusNode, 
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    enabled: enabled,
    keyboardType: keyboardType,
    style: TextStyle(
      fontSize: 16.sp,
      height: 1,
      fontWeight: FontWeight.w500,
      color: NbColors.darkGrey,
    ),
    cursorColor: NbColors.darkGrey,
    onChanged: onChanged,
    focusNode: focusNode, 
    decoration: InputDecoration(
      contentPadding: EdgeInsets.zero,
      border: InputBorder.none,
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 16.sp,
        height: 1,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF929090),
      ),
    ),
  );
}
