import 'package:flutter/material.dart';

import '../../constants.dart';

class UniversalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? _actions;
  final Widget? _title;
  final Widget? _leading;

  const UniversalAppBar({
    @required List<Widget>? actions,
    @required Widget? title,
    Widget? leading,
  })  : _actions = actions,
        _title = title,
        _leading = leading;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: _actions,
      automaticallyImplyLeading: false,
      backgroundColor: kDarkPrimaryColour,
      centerTitle: true,
      leading: _leading,
      title: _title,
    );
  }
}
