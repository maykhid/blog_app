import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/search_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(const SearchState.unknown());

  final SearchRepository _searchRepository;

  Future<void> search(String searchTerm) async {
    emit(const SearchState.processing());
    final response = await _searchRepository.seacrchLiveOrOfflinePosts(searchTerm);
    emit(response.fold((error) => SearchState.failed(message: error.message),
        (res) => SearchState.done(response: res)));
  }
}