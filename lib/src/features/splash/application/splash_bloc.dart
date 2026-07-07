import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashStarted extends SplashEvent {
  const SplashStarted();
}

class SplashState extends Equatable {
  const SplashState({required this.ready});

  final bool ready;

  @override
  List<Object?> get props => [ready];
}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState(ready: false)) {
    on<SplashStarted>(_onStarted);
  }

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    emit(const SplashState(ready: true));
  }
}
