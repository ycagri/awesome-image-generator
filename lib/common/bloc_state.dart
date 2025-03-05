import 'package:equatable/equatable.dart';

class BlocState extends Equatable {
  final timestamp = DateTime.timestamp();

  @override
  List<Object?> get props => [timestamp];
}

class HomePageState extends BlocState {
  final bool isLoading;

  final bool canGenerate;

  final String? imageUrl;

  final String? error;

  HomePageState({
    required this.isLoading,
    required this.canGenerate,
    this.imageUrl,
    this.error,
  });

  @override
  List<Object?> get props => [isLoading, canGenerate, imageUrl, error];
}
