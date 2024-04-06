import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/bloc/quotes_bloc.dart';
import 'package:quotes_app/favourite_page.dart';
import 'package:quotes_app/loading.dart';
import 'package:quotes_app/quote_mode.dart';
import 'package:quotes_app/quotes_provider.dart';

class QuotesViewPage extends StatefulWidget {
  const QuotesViewPage({super.key});

  @override
  State<QuotesViewPage> createState() => _QuotesViewPageState();
}

class _QuotesViewPageState extends State<QuotesViewPage> {
  PageController _pageController =
      PageController(viewportFraction: 0.5, initialPage: 2);
  int _currentPageIndex = 2;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuotesBloc()..add(GetQuotes()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '      Quotes',
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: FavoritePage(),
                            type: PageTransitionType.fade));
                  },
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 400,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: PageView.builder(
                              scrollDirection: Axis.vertical,
                              controller: _pageController,
                              itemCount: state.quotes.length,
                              itemBuilder: (context, index) {
                                return QuotesCard(
                                  quotes: state.quotes[index],
                                  isCurrentPage: _currentPageIndex == index,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is Offline) {
                  return Center(
                    child: Text('No Internet'),
                  );
                } else {
                  return LoadingPage();
                  //  Center(
                  //   child: CircularProgressIndicator(
                  //     color: Color(0xfff0e7da),
                  //   ),
                  // );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class QuotesCard extends StatelessWidget {
  //final String title;
  final QuotesModel quotes;
  final bool isCurrentPage;
  const QuotesCard(
      {super.key, required this.isCurrentPage, required this.quotes});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuotesProvider>(context);

    return AnimatedContainer(
      padding: EdgeInsets.all(20),
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: isCurrentPage ? 0.0 : 16),
      height: isCurrentPage ? 350 : 300,
      width: isCurrentPage ? 300 : 250,
      decoration: BoxDecoration(
        color: isCurrentPage
            ? Color(0xfff0e7da)
            : Color(0xfff0e7da).withOpacity(0.6),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 2),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                quotes.quote,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                    onPressed: () {
                      provider.addQuotes(quotes.quote);
                    },
                    icon: provider.isExist(quotes.quote)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          )),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  quotes.author,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
