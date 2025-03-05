import 'package:app/common/bloc_state.dart';
import 'package:app/common/request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  final RequestHandler _requestHandler;

  HomePageCubit(this._requestHandler)
    : super(HomePageState(isLoading: false, canGenerate: false));

  void generate(String label, String description) {
    emit(
      HomePageState(
        isLoading: true,
        canGenerate: state.canGenerate,
        imageUrl: state.imageUrl,
      ),
    );

    _requestHandler.generateImage(label, description).then(
      (url) {
        emit(
          HomePageState(
            isLoading: state.isLoading,
            canGenerate: state.canGenerate,
            imageUrl: url,
          ),
        );
      },
      onError:
          (e, s) => emit(
            HomePageState(
              isLoading: false,
              canGenerate: state.canGenerate,
              imageUrl: null,
              error: e.toString(),
            ),
          ),
    );
  }

  void onTextChanged(bool canGenerate) {
    emit(
      HomePageState(
        isLoading: state.isLoading,
        canGenerate: canGenerate,
        imageUrl: state.imageUrl,
      ),
    );
  }
}
