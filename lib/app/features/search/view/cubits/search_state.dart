import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums.dart';
import '../../../shared/model/post.dart';

class SearchState extends Equatable {
  const SearchState._({
    this.message,
    this.searchResponse,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;
  final Posts? searchResponse;

  const SearchState.unknown() : this._();

  const SearchState.processing()
      : this._(status: DataResponseStatus.processing);

  const SearchState.done({required Posts response})
      : this._(status: DataResponseStatus.success, searchResponse: response);

  const SearchState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);

  @override
  List<Object?> get props => [status, message, searchResponse];
}