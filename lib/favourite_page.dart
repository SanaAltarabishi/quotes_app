import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/quotes_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuotesProvider>(context);
    final quotes = provider.quotes;
    return Scaffold(
      backgroundColor: Color(0xff895159),
      appBar: AppBar(
        backgroundColor: Color(0xff895159),
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'fav',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.black,
                    size: 14,
                  )),
              Text(
                'urite',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          final quote = quotes[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    quote,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: provider.isExist(quote)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                    onPressed: () {
                      provider.addQuotes(quote);
                    },
                  ),
                ),
              ),
              Divider(
                color: Color(0xfff0e7da),
              ),
            ],
          );
        },
      ),
    );
  }
}
