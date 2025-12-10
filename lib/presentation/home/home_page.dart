import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('welcome'))),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(tr('balance')),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.read<AuthCubit>().logout(),
              child: Text(tr('logout')),
            ),
          ],
        ),
      ),
    );
  }
}