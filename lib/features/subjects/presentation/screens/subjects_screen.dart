import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_animated_entry.dart';
import 'package:elmohadra/core/widgets/app_divider.dart';
import 'package:elmohadra/core/widgets/app_loading_indicator.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:elmohadra/features/subjects/presentation/bloc/subject_bloc.dart';
import 'package:elmohadra/features/subjects/presentation/bloc/subject_event.dart';
import 'package:elmohadra/features/subjects/presentation/bloc/subject_states.dart';
import 'package:elmohadra/features/subjects/presentation/widgets/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  void _load() {
    final auth = context.read<AuthBloc>().state;
    if (auth is AuthAuthenticated) {
      context.read<SubjectBloc>().add(
        GetSubjectsEvent(academicYear: auth.user.academicYear),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.md.h),
              Text(
                'subjects_title'.tr(),
                style: AppTypography.screenTitle(context),
              ),
              SizedBox(height: AppSpacing.sm.h),
              appDivider(isDark: isDark),
              SizedBox(height: AppSpacing.md.h),
              Expanded(
                child: BlocBuilder<SubjectBloc, SubjectStates>(
                  builder: (context, state) {
                    if (state is SubjectLoading) {
                      return const Center(child: AppLoadingIndicator());
                    }

                    if (state is SubjectError) {
                      return _Message(
                        text: 'subjects_error'.tr(),
                        action: 'subjects_retry'.tr(),
                        onAction: _load,
                        // TODO we will make a custom error Message
                      );
                    }

                    if (state is SubjectsLoaded) {
                      if (state.subjects.isEmpty) {
                        return _Message(text: 'subjects_empty'.tr());
                      }

                      return ListView.separated(
                        padding: EdgeInsets.only(bottom: AppSpacing.lg.h),
                        itemCount: state.subjects.length,
                        separatorBuilder: (_, _) =>
                            SizedBox(height: AppSpacing.sm.h),
                        itemBuilder: (_, i) {
                          final subject = state.subjects[i];
                          return AppAnimatedEntry(
                            delay: Duration(milliseconds: i + 100),
                            child: SubjectCard(
                              index: i + 1,
                              title: subject.title,
                              chapterCount: subject.chapterCount,
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final String text;
  final String? action;
  final VoidCallback? onAction;

  const _Message({required this.text, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: AppTypography.bodyMedium(context)),
          if (action != null) ...[
            SizedBox(height: AppSpacing.md.h),
            TextButton(onPressed: onAction, child: Text(action!)),
          ],
        ],
      ),
    );
  }
}
