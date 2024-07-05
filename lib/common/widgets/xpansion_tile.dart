import 'package:flutter/material.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/titles.dart';

class XpansionTile extends StatelessWidget {
  const XpansionTile({super.key, required this.text, required this.text2, this.onExpansionChanged, this.trailing, required this.children});
  final String text;
  final String text2;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:AppConst.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent),
        child: Padding(
          padding: EdgeInsets.all(0.5*w),
          child: ExpansionTile(
              title:BottomTitles(
                  text: text,
                  text2: text2,
                 ),
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            onExpansionChanged: onExpansionChanged,
            controlAffinity: ListTileControlAffinity.trailing,
            trailing: trailing,
            children: children,
          ),
        )
      ),
    );
  }
}
