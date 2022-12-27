import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

// data loading state
class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

// data loaded state


// data error loading state