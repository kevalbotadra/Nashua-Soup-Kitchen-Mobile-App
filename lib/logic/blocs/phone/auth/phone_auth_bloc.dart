import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nsks/data/providers/phone_provider.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_event.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_state.dart';

class PhoneAuthenticationBloc
    extends Bloc<PhoneAuthenticationEvent, PhoneAuthenticationState> {
  final PhoneAuthRepository _phoneAuthRepository;

  PhoneAuthenticationBloc(PhoneAuthRepository phoneAuthRepository)
      : _phoneAuthRepository = phoneAuthRepository,
        super(InitialAuthenticationState());

  @override
  Stream<PhoneAuthenticationState> mapEventToState(
      PhoneAuthenticationEvent event) async* {
    if (event is AppStarted) {
      final User? user = await _phoneAuthRepository.getUser();
      if (user != null) {
        final bool docExists = await _phoneAuthRepository.checkIfDocExists(
            await _phoneAuthRepository.getUser().then((value) => value!.uid));
        if (docExists) {
          yield Authenticated();
        } else {
          yield StartRegistrationState();
        }
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield Loading();
      yield Authenticated();
    }

    if (event is LoggedOut) {
      yield Loading();
      try {
        _phoneAuthRepository.logout();
      } catch (_) {
        yield Unauthenticated();
      }
      yield Unauthenticated();
    }

    if (event is StartRegistration) {
      final bool docExists = await _phoneAuthRepository.checkIfDocExists(
            await _phoneAuthRepository.getUser().then((value) => value!.uid));
        if (docExists) {
          yield Authenticated();
        } else {
          yield StartRegistrationState();
        }
    }

  }
}
