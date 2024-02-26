import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/helper/theme_pref.dart';
import '../../../../../utils/resources/constants.dart';
import 'theme_states.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  void changeAppMode (){
    isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark);
    emit(ChangeThemeState());
  }
}