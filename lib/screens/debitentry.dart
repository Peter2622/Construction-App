import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DebitEntry extends StatefulWidget {
  const DebitEntry({super.key});

  @override
  State<DebitEntry> createState() => _DebitEntryState();
}

class _DebitEntryState extends State<DebitEntry> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Debit Entry'),
    );
  }
}
