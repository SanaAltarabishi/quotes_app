import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/bloc/quotes_bloc.dart';
import 'package:quotes_app/quote_mode.dart';
//either this or the other one QuotesViewPage
class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage>
    with SingleTickerProviderStateMixin {
  bool isHover = false;
  int tappedIndex = -1;
  List<bool>? containerStates;
  @override
  void initState() {
    super.initState();
    containerStates = List<bool>.filled(30, false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuotesBloc()..add(GetQuotes()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Quotes',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Color(0xff895159),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
                onPressed: () {},
              )
            ],
          ),
          backgroundColor: Color(0xff895159),
          body: BlocBuilder<QuotesBloc, QuotesState>(
            builder: (context, state) {
              if (state is Error) {
                return Center(
                  child: Text('Error'),
                );
              } else if (state is Success) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: state.quotes.length,
                    itemBuilder: (context, index) {
                      //! we will change here
                      return QuotesContainer(
                        press: (int tappedIndex) {
                          setState(() {
                            if (this.tappedIndex == tappedIndex) {
                              this.tappedIndex = -1;
                            } else {
                              if (this.tappedIndex != -1) {
                                containerStates![this.tappedIndex] = false;
                              }
                              this.tappedIndex = tappedIndex;
                              containerStates![tappedIndex] = true;
                            }
                          });
                        },
                        quotes: state.quotes[index],
                        index: index,
                        isHover: tappedIndex == index,
                      );
                    });
              } else if (state is Offline) {
                return Center(
                  child: Text('No Internet'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xfff0e7da),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }
}

class QuotesContainer extends StatefulWidget {
  final ValueChanged<int> press;
  final int index;
  final QuotesModel quotes;
  bool isHover;

  QuotesContainer(
      {super.key,
      required this.press,
      required this.index,
      required this.quotes,
      required this.isHover});

  @override
  State<QuotesContainer> createState() => _QuotesContainerState();
}

class _QuotesContainerState extends State<QuotesContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animaton;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animaton = Tween<double>(begin: 0, end: 10).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFog() {
    setState(() {
      widget.isHover = !widget.isHover;
      if (widget.isHover) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.press(widget.index);
        _toggleFog();
      },
      child: AnimatedBuilder(
        animation: _animaton,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: _animaton.value, sigmaY: _animaton.value),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(11),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xfff0e7da),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.quotes.quote,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        widget.quotes.author,
                      ),
                    ),
                    widget.isHover
                        ? Align(
                            alignment: Alignment.bottomLeft,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.black,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ).animate().fadeIn(delay: .3.seconds, duration: .5.seconds),
            ],
          );
        },
      ),
    );
  }
}
