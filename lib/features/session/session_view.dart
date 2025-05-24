import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/image_path_const.dart';

class SessionView extends StatelessWidget {
  const SessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // session svg
          SvgPicture.asset(session, height: 200),

          // session text
          const SizedBox(height: 20),
          Text('Session Active on Another Device', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          // session text
          Text(
            'You are already logged in on another device. Please log out from that device to continue.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
