import 'package:elmohadra/core/widgets/app_button.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/events/auth_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthStates>(
        builder: (_, state) {
          return Center(
            child: AppButton(
              title: 'sign out ',
              onTap: () => context.read<AuthBloc>().add(SignOutEvent()),
              type: AppButtonType.primary,
              isLoading: state is AuthLoading,
            ),
          );
        },
      ),
    );
  }
}
