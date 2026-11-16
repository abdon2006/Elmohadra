import 'package:elmohadra/core/theme/app_radius.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_divider.dart';
import 'package:elmohadra/core/widgets/app_loading_indicator.dart';
import 'package:elmohadra/features/chapters/domain/entities/chapter_entity.dart';
import 'package:elmohadra/features/chapters/presentation/bloc/chapter_bloc.dart';
import 'package:elmohadra/features/chapters/presentation/bloc/chapter_event.dart';
import 'package:elmohadra/features/chapters/presentation/bloc/chapter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChaptersScreen extends StatefulWidget {
  final String subjectId;

  const ChaptersScreen({super.key, required this.subjectId});

  @override
  State<ChaptersScreen> createState() => _StateChaptersScreen();
}

class _StateChaptersScreen extends State<ChaptersScreen> {
  void _load() {
    context.read<ChapterBloc>().add(
      GetChaptersEvent(subjectId: widget.subjectId),
    );
  }

  String subjectTitle = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                textAlign: TextAlign.start,
                subjectTitle,
                style: AppTypography.screenTitle(context),
              ),
              SizedBox(height: AppSpacing.sm.h),

              appDivider(isDark: isDark),
              SizedBox(height: AppSpacing.sm.h),

              Expanded(
                child: BlocConsumer<ChapterBloc, ChapterStates>(
                  builder: (_, state) {
                    if (state is ChapterError) {
                      // TODO error state
                    }
                    if (state is ChapterLoading) {
                      return const Center(child: AppLoadingIndicator());
                    }
                    if (state is GetChaptersSuccess) {
                      if (state.chapters.isEmpty) {
                        // TODO empty state
                      }
                      return ListView.separated(
                        itemBuilder: (_, i) {
                          final item = state.chapters[i];
                          return chapterCard(
                            context: context,
                            chapter: item,
                            onTap: () => context.push(
                              '/subjects/${widget.subjectId}/chapters/${item.id}/files',
                            ),
                          );
                        },
                        separatorBuilder: (_, _) {
                          return SizedBox(height: AppSpacing.sm.h);
                        },
                        itemCount: state.chapters.length,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  listener: (_, state) {
                    if (state is GetChaptersSuccess) {
                      setState(
                        () => subjectTitle = state.chapters[0].subjectTitle,
                      );
                    }
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

Widget chapterCard({
  required BuildContext context,
  required ChapterEntity chapter,
  required void Function() onTap,
}) {
  final theme = Theme.of(context).colorScheme;
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md.r),
      ),
      child: Center(
        child: Text(chapter.title, style: AppTypography.cardTitle(context)),
      ),
    ),
  );
}
