part of 'quotes_bloc.dart';

@immutable
sealed class QuotesEvent {}

class GetQuotes extends QuotesEvent{}