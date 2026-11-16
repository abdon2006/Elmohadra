import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:elmohadra/core/widgets/app_divider.dart';
import 'package:elmohadra/features/files/presentation/bloc/file_bloc.dart';
import 'package:elmohadra/features/files/presentation/bloc/file_event.dart';
import 'package:elmohadra/features/files/presentation/bloc/file_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilesScreen extends StatefulWidget {
  final String chapterId;

  const FilesScreen({super.key, required this.chapterId});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FileBloc>().add(GetFilesEvent(chapterId: widget.chapterId));
  }

  String chapterTitle = '';
  String subjectTitle = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: AppSpacing.md.w),
          child: Column(
            children: [
              Text(chapterTitle, style: AppTypography.screenTitle(context)),
              Text(subjectTitle, style: AppTypography.screenTitle(context)),
              SizedBox(height: AppSpacing.sm.h),
              appDivider(isDark: isDark),
              SizedBox(height: AppSpacing.sm.h),
              Expanded(
                child: BlocConsumer<FileBloc, FileStates>(
                  builder: (_, state) {
                    if (state is FileError) {
                      // TODO
                    }
                    if (state is FileLoading) {
                      // TODO
                    }

                    if (state is GetFilesSuccess) {
                      if (state.chapterDetailsEntity.files.isEmpty) {
                        // TODO
                      }

                      return ListView.separated(
                        itemBuilder: (_, i) {
                          final item = state.chapterDetailsEntity.files[i];
                          return Text(item.title);
                        },
                        separatorBuilder: (_, _) =>
                            SizedBox(height: AppSpacing.sm.h),
                        itemCount: state.chapterDetailsEntity.files.length,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  listener: (_, state) {
                    if (state is GetFilesSuccess) {
                      setState(() {
                        subjectTitle = state.chapterDetailsEntity.subjectTitle;
                        chapterTitle = state.chapterDetailsEntity.title;
                      });
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
