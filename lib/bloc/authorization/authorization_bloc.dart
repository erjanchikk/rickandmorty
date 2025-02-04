import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/helpers/pref_keys.dart';
import 'package:rickandmorty/helpers/save_provider.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(AuthorizationInitial()) {
    on<Register>((event, emit) async {
      try {
        final authCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        print(authCredential);
        print("Вы успешно зарегистрировались!");
      } catch (e) {
        emit(AuthorizationErrorState(error: e.toString()));
      }
    });

    on<Login>((event, emit) async {
      try {
        final authCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        SaveProvider().saveUser(authCredential.user!.email!);

        emit(AuthorizationSuccessState());
        print("Авторизация прошла успешна!");
      } catch (e) {
        emit(AuthorizationErrorState(error: e.toString()));
      }
    });

    on<CheckUser> ((event, emit) async{
      String? user = await SaveProvider().getUSer();
      if (user!=null) {
        emit(AuthorizationSuccessState());
      }
    });
  }
}
