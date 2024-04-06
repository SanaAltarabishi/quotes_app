part of 'quotes_bloc.dart';

@immutable
sealed class QuotesState {}

final class QuotesInitial extends QuotesState {}

class Success extends QuotesState {
  List<QuotesModel> quotes;
  Success({
    required this.quotes,
  });
}

class Error extends QuotesState {}

class Loading extends QuotesState {}

class Offline extends QuotesState {}
