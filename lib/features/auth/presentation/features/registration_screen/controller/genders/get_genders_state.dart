part of 'get_genders_cubit.dart';

@immutable
abstract class GetGenderState {
  const GetGenderState();
  List<Object?> get props => [];
}

class ContractsInitial extends GetGenderState {}

class GetGenderStateLoading extends GetGenderState {}

class GetGenderStateLoaded extends GetGenderState {
  final List<LookUps> data;

  const GetGenderStateLoaded(this.data);

  @override
  List<Object?> get props => [data];

  GetGenderStateLoaded copyWith({
    List<LookUps>? data,
  }) {
    return GetGenderStateLoaded(
      data ?? this.data,
    );
  }
}

class GetGenderStateError extends GetGenderState {
  final String error;

  const GetGenderStateError(this.error);

  @override
  List<Object?> get props => [error];
}