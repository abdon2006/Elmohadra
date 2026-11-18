import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_animated_entry.dart';
import 'package:elmohadra/core/widgets/app_divider.dart';
import 'package:elmohadra/core/widgets/app_loading_indicator.dart';
import 'package:elmohadra/core/widgets/app_page_header.dart';
import 'package:elmohadra/core/widgets/app_text_field.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:elmohadra/features/subjects/domain/usecases/get_subjects_usecase.dart';
import 'package:elmohadra/features/subjects/presentation/bloc/subject_bloc.dart';
import 'package:elmohadra/features/subjects/presentation/bloc/subject_event.dart';
import 'package:elmohadra/features/subjects/presentation/bloc/subject_states.dart';
import 'package:elmohadra/features/subjects/presentation/widgets/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  int year = 0;
  late final TextEditingController searchController;

  void _load() {
    final auth = context.read<AuthBloc>().state;
    if (auth is AuthAuthenticated) {
      year = auth.user.academicYear;
      context.read<SubjectBloc>().add(
        GetSubjectsEvent(
          params: GetSubjectsParams(year: auth.user.academicYear),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() => setState(() {}));
    _load();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final String yearTitle = switch (year) {
      1 => 'السنة الاولي',
      2 => 'السنة التانية',
      3 => 'السنة التالتة',
      4 => 'السنة الرابعة',
      _ => '',
    };
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacing.md.h),
                AppPageHeader(title: 'subjects_title'.tr(), showBack: false),
                SizedBox(height: AppSpacing.sm.h),
                appDivider(isDark: isDark),
                SizedBox(height: AppSpacing.sm.h),
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
                        final String query = searchController.text
                            .trim()
                            .toLowerCase();
                        final subjects = query.isEmpty
                            ? state.subjects
                            : state.subjects
                                  .where(
                                    (s) =>
                                        s.title.toLowerCase().contains(query),
                                  )
                                  .toList();
                        if (state.subjects.isEmpty) {
                          return _Message(text: 'subjects_empty'.tr());
                        }

                        if (subjects.isEmpty) {
                          // TODO handle no results state
                        }
                        return Column(
                          children: [
                            AppTextField(
                              hint: 'اسم المادة',
                              label: 'ابحث عن موادك',
                              isPass: false,
                              controller: searchController,
                            ),
                            SizedBox(height: AppSpacing.md.h),
                            Row(
                              children: [
                                Text(
                                  yearTitle,
                                  style: AppTypography.sectionTitle(context),
                                ),
                                Spacer(),
                                Text(
                                  "${state.subjects.length} مواد",
                                  style: AppTypography.sectionTitle(context),
                                ),
                              ],
                            ),

                            SizedBox(height: AppSpacing.sm.h),
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.only(
                                  bottom: AppSpacing.lg.h,
                                ),
                                itemCount: subjects.length,
                                separatorBuilder: (_, _) =>
                                    SizedBox(height: AppSpacing.sm.h),
                                itemBuilder: (_, i) {
                                  final subject = subjects[i];
                                  return AppAnimatedEntry(
                                    delay: Duration(milliseconds: i + 100),
                                    child: SubjectCard(
                                      subject: subject,
                                      onTap: () => context.push(
                                        '/subjects/${subject.id}/chapters',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
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
