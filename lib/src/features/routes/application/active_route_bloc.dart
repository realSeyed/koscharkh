import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../charkhs/domain/charkh.dart';
import '../data/active_route_repository.dart';

class ActiveRouteState extends Equatable {
  const ActiveRouteState({
    this.charkh,
    this.elapsedSeconds = 0,
    this.etaSeconds = 0,
    this.currentDestinationIndex = 0,
    this.running = false,
  });

  final Charkh? charkh;
  final int elapsedSeconds;
  final int etaSeconds;
  final int currentDestinationIndex;
  final bool running;

  String get nextDestination {
    final destinations = charkh?.destinations ?? const [];
    if (destinations.isEmpty) {
      return 'empty';
    }
    return destinations[min(currentDestinationIndex, destinations.length - 1)]
        .name;
  }

  ActiveRouteState copyWith({
    Charkh? charkh,
    int? elapsedSeconds,
    int? etaSeconds,
    int? currentDestinationIndex,
    bool? running,
  }) {
    return ActiveRouteState(
      charkh: charkh ?? this.charkh,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      etaSeconds: etaSeconds ?? this.etaSeconds,
      currentDestinationIndex:
          currentDestinationIndex ?? this.currentDestinationIndex,
      running: running ?? this.running,
    );
  }

  @override
  List<Object?> get props => [
    charkh,
    elapsedSeconds,
    etaSeconds,
    currentDestinationIndex,
    running,
  ];
}

sealed class ActiveRouteEvent extends Equatable {
  const ActiveRouteEvent();

  @override
  List<Object?> get props => [];
}

class ActiveRouteStarted extends ActiveRouteEvent {
  const ActiveRouteStarted({
    required this.charkh,
    required this.routeDurationSeconds,
  });

  final Charkh charkh;
  final int routeDurationSeconds;

  @override
  List<Object?> get props => [charkh, routeDurationSeconds];
}

class ActiveRouteTicked extends ActiveRouteEvent {
  const ActiveRouteTicked();
}

class ActiveRouteBloc extends Bloc<ActiveRouteEvent, ActiveRouteState> {
  ActiveRouteBloc(this.repository) : super(const ActiveRouteState()) {
    on<ActiveRouteStarted>(_onStarted);
    on<ActiveRouteTicked>(_onTicked);
  }

  final ActiveRouteRepository repository;
  Timer? _timer;
  DateTime? _startedAt;
  int _baseEtaSeconds = 0;

  Future<void> _onStarted(
    ActiveRouteStarted event,
    Emitter<ActiveRouteState> emit,
  ) async {
    _timer?.cancel();
    _startedAt = DateTime.now();
    _baseEtaSeconds = max(
      event.routeDurationSeconds,
      event.charkh.timeMinutes * 60,
    );
    emit(
      ActiveRouteState(
        charkh: event.charkh,
        etaSeconds: _baseEtaSeconds,
        running: true,
      ),
    );
    await _persist(state);
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(const ActiveRouteTicked()),
    );
  }

  Future<void> _onTicked(
    ActiveRouteTicked event,
    Emitter<ActiveRouteState> emit,
  ) async {
    final charkh = state.charkh;
    if (charkh == null) {
      return;
    }
    final elapsed = state.elapsedSeconds + 1;
    final eta = max(0, _baseEtaSeconds - elapsed);
    final count = max(1, charkh.destinations.length);
    final segment = max(1, _baseEtaSeconds ~/ count);
    final index = min(count - 1, elapsed ~/ segment);
    emit(
      state.copyWith(
        elapsedSeconds: elapsed,
        etaSeconds: eta,
        currentDestinationIndex: index,
      ),
    );
    await _persist(state);
  }

  Future<void> _persist(ActiveRouteState value) async {
    if (value.charkh == null || _startedAt == null) {
      return;
    }
    await repository.saveActiveRoute(
      charkhStableId: value.charkh!.stableId,
      startedAt: _startedAt!,
      elapsedSeconds: value.elapsedSeconds,
      etaSeconds: value.etaSeconds,
      currentDestinationIndex: value.currentDestinationIndex,
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
