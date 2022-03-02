import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/data/providers/phone_provider.dart';
import 'package:nsks/logic/blocs/phone/register/phone_register_event.dart';
import 'package:nsks/logic/blocs/phone/register/phone_register_state.dart';

class RegisterBloc extends Bloc<PhoneRegisterEvent, PhoneRegisterState> {
  final PhoneAuthRepository _phoneAuthRepository;

  String verID = "";

  RegisterBloc(PhoneAuthRepository phoneAuthRepository)
      : _phoneAuthRepository = phoneAuthRepository,
        super(InitialRegisterState());

  @override
  Stream<PhoneRegisterState> mapEventToState(
    PhoneRegisterEvent event,
  ) async* {
    if (event is CompleteRegistrationEvent) {
      yield LoadingState();
      try {
        final User? user = await _phoneAuthRepository.getUser();
        final NsksUser nsksUser = await _phoneAuthRepository.registerUser(
            uid: user!.uid,
            name: event.name,
            username: event.username,
            phoneNumber: user.phoneNumber);
        yield SuccessfulRegistration(user: nsksUser);
      } catch (e) {
        yield ExceptionState(message: e.toString());
      }
      
    }
  }
}
