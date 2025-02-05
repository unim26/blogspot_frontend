import 'package:blogspot/features/auth/presentation/blocs/obscure_password/obscure_password_state.dart';
import 'package:blogspot/features/auth/presentation/blocs/obscure_password/obscure_pasword_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObscurePasswordBloc extends Bloc<ObscurePasswordEvent,ObscurePasswordState>{

  ObscurePasswordBloc() : super(ObscurePasswordInitial()){

    //toogle event listener
    on<ObscurePasswordToggleEvent>(toogleObscure);
  }


  //toogle function
  void toogleObscure(ObscurePasswordToggleEvent event, Emitter<ObscurePasswordState> emit){
    emit(ObscurePasswordToggled(isObsucre: event.isObscure));
  }
}