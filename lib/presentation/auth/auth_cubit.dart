import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain/models/user.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  const Authenticated(this.user);
  final User user;
  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  const AuthError(this.code);
  final String code;
  @override
  List<Object?> get props => [code];
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo) : super(AuthInitial());

  final AuthRepository _repo;

  void init() {
    emit(_repo.isLoggedIn() ? Authenticated(User(name: 'You', email: 'me@example.com', token: _repo.getToken()!)) : Unauthenticated());
  }

  Future<void> login(String email, String password) async {
    emit(Authenticating());
    try {
      final user = await _repo.login(email: email, password: password);
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    emit(Unauthenticated());
  }
}