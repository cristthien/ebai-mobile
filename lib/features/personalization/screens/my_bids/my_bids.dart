import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/appbar/appbar.dart';

class MyBids extends StatelessWidget {
  const MyBids({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('My Bids')),
    );
  }
}
