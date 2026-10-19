import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/events/auth_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatefulWidget {
  const new({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late AppLinks appLinks;
  late StreamSubscription<Uri> appLinksListener;
  @override
  void initState() {
    context.read<AuthBloc>().add(CheckAuthStatusEvent());
    appLinks = AppLinks();
    appLinksListener = appLinks.uriLinkStream.listen((uri) {
      context.read<AuthBloc>().add(DeepLinkReceivedEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    appLinksListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthStates>(
      builder: (context, state) {
        // return switch (state) {
        //   AuthAuthenticated(:final user) => HomeScreen(),
        //   AuthNewUser(:final user) => CompleteProfileScreen(),
        //   AuthUnAuthenticated() => LoginScreen(),
        //   AuthInitial() || AuthLoading() => CircularProgressIndicator(),
        //   AuthError() => LoginScreen(),
        // };
        // temp
        return SizedBox();
      },
    );
  }
}
