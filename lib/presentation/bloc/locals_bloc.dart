import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/local_entity.dart';
import '../../domain/usecases/get_locals_by_bounds.dart';
import '../../domain/usecases/watch_social_data_updates.dart';
import 'locals_event.dart';
import 'locals_state.dart';

class LocalsBloc extends Bloc<LocalsEvent, LocalsState> {
  final GetLocalsByBounds getLocalsByBounds;
  final WatchSocialDataUpdates watchSocialDataUpdates;
  StreamSubscription<LocalEntity>? _socialDataSubscription;

  LocalsBloc({
    required this.getLocalsByBounds,
    required this.watchSocialDataUpdates,
  }) : super(LocalsInitial()) {
    on<FetchLocalsEvent>(_onFetchLocals);
    on<SocialDataUpdatedEvent>(_onSocialDataUpdated);
  }

  Future<void> _onFetchLocals(
      FetchLocalsEvent event, Emitter<LocalsState> emit) async {
    emit(LocalsLoading());

    final (failure, locals) = await getLocalsByBounds(
      ParamsGetLocals(
        minLat: event.minLat,
        maxLat: event.maxLat,
        minLng: event.minLng,
        maxLng: event.maxLng,
        category: event.category,
      ),
    );

    if (failure != null) {
      emit(LocalsError(message: failure.message));
    } else if (locals != null) {
      // 1. Degradación elegante (Fila 1): Emitimos la UI rápida de Places
      emit(LocalsLoaded(locals: locals));

      // 2. Iniciamos el listener para las actualizaciones asíncronas de Playwright
      _subscribeToSocialUpdates();
    }
  }

  void _subscribeToSocialUpdates() {
    _socialDataSubscription?.cancel();
    _socialDataSubscription = watchSocialDataUpdates().listen(
      (updatedLocal) {
        add(SocialDataUpdatedEvent(updatedLocal: updatedLocal));
      },
      onError: (_) {
         // Silently handle websocket errors to maintain Graceful Degradation
      }
    );
  }

  void _onSocialDataUpdated(
      SocialDataUpdatedEvent event, Emitter<LocalsState> emit) {
    if (state is LocalsLoaded) {
      final currentState = state as LocalsLoaded;
      
      final updatedLocals = currentState.locals.map((local) {
        if (local.id == event.updatedLocal.id) {
          return event.updatedLocal as LocalEntity;
        }
        return local;
      }).toList();

      emit(currentState.copyWith(locals: updatedLocals));
    }
  }

  @override
  Future<void> close() {
    _socialDataSubscription?.cancel();
    return super.close();
  }
}
