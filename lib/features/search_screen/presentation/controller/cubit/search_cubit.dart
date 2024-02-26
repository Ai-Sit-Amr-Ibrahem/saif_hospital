import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/search_screen/data/data_source/search_data_source.dart';
import 'package:hisksa/features/search_screen/data/repo/search_repo.dart';

import '../../../../../../utils/di/injection.dart';
import '../../../../../../utils/errors/failures.dart';
import '../../../../../../utils/network/connection/network_info.dart';
import '../../../../../../utils/resources/snackbar_widget.dart';
import '../../../data/model/search_model.dart';
import 'search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  final SearchRepo _searchRepo = SearchRepo(
    networkInfo: instance<NetworkInfoImp>(),
    searchDataSource: SearchDataSource(),
  );

  SearchModel? searchModel;

  void getSearch(context, String input) {
    print('here are dates');
    emit(GetSearchLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _searchRepo.getSearch(
      body: {
        'NAME_SEARCH': input,
      },
    ).then((value) {
      // dismissLoadingDialog(context);
      value.fold((l) {
        String error = '';
        if (l is OffLineFailure) {
          error = 'لا يوجد اتصال بالانترنت';
          failSnackBar(
              'لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا', context);
        } else if (l is WrongDataFailure) {
          error = l.message.toString();

          failSnackBar(
              l.message.toString(), 'من فضلك ادخل بيانات صحيحة', context);
        } else if (l is ServerFailure) {
          error = 'هناك مشكلة في السيرفر ';

          failSnackBar('هناك مشكلة في السيرفر ',
              'برجاء التواصل مع خدمة العملاء', context);
        }
        emit(GetSearchErrorState());
      }, (r) {
        searchModel = r;

        emit(GetSearchSuccessState());
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }
}
