import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  final List<Widget> _rowItems;
  final MainAxisAlignment _mainAxisAlignment;

  const ItemRow(this._rowItems, this._mainAxisAlignment);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _mainAxisAlignment,
      children: _rowItems,
    );
  }
}