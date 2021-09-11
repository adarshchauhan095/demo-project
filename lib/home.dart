import 'package:demo/apiService.dart';
import 'package:demo/detailScreen.dart';
import 'package:demo/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var allCrypto = List<dynamic>.empty(growable: true);

  bool isLoading = false;

  API_SERVICE apiService = API_SERVICE();
  getCrypto() async {
    setState(() {
      isLoading = true;
    });
    await apiService.fetchCryptoData().then((value) {
      if (value != null) {
        print("end");
        allCrypto.addAll(value);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    getCrypto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Cryptocurrencies")),
      body: isLoading
          ? loader()
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: allCrypto.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(),
                          settings: RouteSettings(arguments: {
                            "name": allCrypto[index].name,
                            "percentage":
                                double.parse(allCrypto[index].changePercent24Hr)
                                    .toStringAsFixed(2),
                            "price": limitString(allCrypto[index].priceUsd)
                          })),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 18, bottom: 18),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  text("Rank", fontSize: 16.0),
                                  text(allCrypto[index].rank,
                                      textColor: Colors.grey),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.only(left: 16, right: 16),
                                width: width / 7.2,
                                height: width / 7.2,
                                child: Image.asset("images/bitcoin.png",
                                    fit: BoxFit.cover),
                                padding: EdgeInsets.all(width / 30),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        text(allCrypto[index].name,
                                            fontSize: 16.0),
                                        text(
                                            double.parse(allCrypto[index]
                                                        .changePercent24Hr)
                                                    .toStringAsFixed(2) +
                                                "%",
                                            fontSize: 16,
                                            textColor: isNegative(
                                                    allCrypto[index]
                                                        .changePercent24Hr)
                                                ? Colors.red
                                                : Colors.green),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                    text(
                                        "\$" +
                                            limitString(
                                                allCrypto[index].priceUsd),
                                        fontSize: 14)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(height: 0.5, color: Colors.grey)
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
