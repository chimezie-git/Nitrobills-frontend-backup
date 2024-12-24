import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class MessagesField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String? forcedStringValidator;
  final FocusNode focusNode;

  const MessagesField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.forcedStringValidator,
    required this.focusNode,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MessagesFieldState createState() => _MessagesFieldState();
}

class _MessagesFieldState extends State<MessagesField> {
  Color borderColor = const Color(0xFFBBB9B9); // Default border color

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {
        borderColor = widget.focusNode.hasFocus
            ? Colors.black
            : (widget.forcedStringValidator == null
                ? const Color(0xFFBBB9B9)
                : NbColors.red);
      });
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: NbColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  widget.focusNode.requestFocus();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: widget.controller.text.isEmpty ? 1 : 0,
                      child: NbText.sp16("Messages").w500.black,
                    ),
                    InkWell(
                      onTap: () {
                        widget.controller.clear();
                        widget.onChanged("");
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: SvgPicture.asset(NbSvg.clean),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: widget.controller,
                onChanged: widget.onChanged,
                maxLines: 6,
                focusNode: widget.focusNode,
                cursorColor: NbColors.darkGrey,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: NbColors.darkGrey,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
        if (widget.forcedStringValidator != null)
          Align(
            alignment: Alignment.centerLeft,
            child: NbText.sp12(widget.forcedStringValidator!)
                .setColor(NbColors.red),
          ),
        SizedBox(height: 5.h), // Use SizedBox for vertical spacing
        NbText.sp16("${widget.controller.text.length}/160").w500.black,
      ],
    );
  }
}
