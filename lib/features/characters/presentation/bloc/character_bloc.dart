import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/characters/domain/usecases/get_characters_usecase.dart';
import 'package:elmohadra/features/characters/presentation/events/character_event.dart';
import 'package:elmohadra/features/characters/presentation/states/character_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CharacterBloc extends Bloc<CharacterEvents, CharacterStates> {
  final GetCharactersUsecase getCharactersUsecase;

  CharacterBloc({required this.getCharactersUsecase})
    : super(CharacterInitial()) {
    on<GetCharactersEvent>((event, emit) async {
      emit(CharacterLoading());

      final res = await getCharactersUsecase(NoParams());
      res.fold(
        (l) => emit(CharacterIError(l.message, l)),
        (r) => emit(GetCharactersSuccess(characters: r)),
      );
    });
  }
}
