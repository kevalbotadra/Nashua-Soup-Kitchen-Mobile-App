import 'package:bloc/bloc.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/data/repositories/account_repository.dart';
import 'package:nsks/logic/blocs/account/account_event.dart';
import 'package:nsks/logic/blocs/account/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;

  AccountBloc(AccountRepository accountRepository)
      : _accountRepository = accountRepository,
        super(InitialAccountState());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is GetAccount) {
      try {
        NsksUser user = await _accountRepository.getAccountDetails();
        yield AccountRetrieved(user: user);
      } catch (e) {
        yield AccountFailure(
            message: "There was an issue obtaining your account");
      }
    }
  }
}
