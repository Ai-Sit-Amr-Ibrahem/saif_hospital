part of 'get_countries_cubit.dart';

@immutable
abstract class GetCountriesState {
  const GetCountriesState();
  List<Object?> get props => [];
}

class ContractsInitial extends GetCountriesState {}

class GetCountriesStateLoading extends GetCountriesState {}

class GetCountriesStateLoaded extends GetCountriesState {
  final List<LookUps> data;

  const GetCountriesStateLoaded(this.data);

  @override
  List<Object?> get props => [data];

  GetCountriesStateLoaded copyWith({
    List<LookUps>? data,
  }) {
    return GetCountriesStateLoaded(
      data ?? this.data,
    );
  }
}

class GetCountriesStateError extends GetCountriesState {
  final String error;

  const GetCountriesStateError(this.error);

  @override
  List<Object?> get props => [error];
}