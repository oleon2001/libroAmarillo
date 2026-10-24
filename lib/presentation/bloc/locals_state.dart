import '../../domain/entities/local_entity.dart';

abstract class LocalsState {
  const LocalsState();
}

class LocalsInitial extends LocalsState {}

class LocalsLoading extends LocalsState {}

class LocalsLoaded extends LocalsState {
  final List<LocalEntity> locals;

  const LocalsLoaded({required this.locals});
  
  LocalsLoaded copyWith({
    List<LocalEntity>? locals,
  }) {
    return LocalsLoaded(
      locals: locals ?? this.locals,
    );
  }
}

class LocalsError extends LocalsState {
  final String message;

  const LocalsError({required this.message});
}
