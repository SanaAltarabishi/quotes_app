import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quotes_app/quote_mode.dart';
import 'package:quotes_app/service.dart';

part 'quotes_event.dart';
part 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  QuotesBloc() : super(QuotesInitial()) {
    on<GetQuotes>((event, emit) async {
      try {
        emit(Loading());
        final dynamic temp = await QuotesServiceImp().getQuotes();
        if (temp is String) {
          emit(Error());
        } else {
          List<QuotesModel> qoutes = List.generate(
              temp.length, (index) => QuotesModel.fromMap(temp[index]));
          emit(Success(quotes: qoutes));
        }
      } catch (e) {
        print(e);
        emit(Offline());
      }
    });
  }
}
