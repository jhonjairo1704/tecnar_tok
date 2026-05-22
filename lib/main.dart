import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnar_tok/core/theme/app_theme.dart';
import 'package:tecnar_tok/features/feed/data/datasources/video_local_data_source.dart';
import 'package:tecnar_tok/features/feed/data/repositories/video_repository_impl.dart';
import 'package:tecnar_tok/features/feed/domain/usecases/get_videos.dart';
import 'package:tecnar_tok/features/feed/presentation/pages/home_page.dart';
import 'package:tecnar_tok/features/feed/presentation/providers/feed_provider.dart';

void main() {
  final localDataSource = VideoLocalDataSourceImpl();
  final videoRepository = VideoRepositoryImpl(localDataSource: localDataSource);
  final getVideos = GetVideos(videoRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FeedProvider(getVideosUseCase: getVideos),
        ),
      ],
      child: const TecnarTokApp(),
    ),
  );
}

class TecnarTokApp extends StatelessWidget {
  const TecnarTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tecnar Tok',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}