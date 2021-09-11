import 'package:demo/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'apiService.dart';
import 'cryptochartModel.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var allCryptoChartValues = List<dynamic>.empty(growable: true);

  bool isLoading = false;

  API_SERVICE apiService = API_SERVICE();
  getCryptoChart() async {
    setState(() {
      isLoading = true;
    });
    await apiService.fetchCryptochartValues().then((value) {
      if (value != null) {
        allCryptoChartValues.addAll(value);

        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    getCryptoChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    String name = args["name"];
    String price = args["price"];
    String percentage = args["percentage"];

    return Scaffold(
        appBar: AppBar(
          title: Text("Crypto Detail"),
        ),
        body: isLoading
            ? loader()
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.grey[100],
                      height: 300,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(text: 'Crypto Data'),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <LineSeries<Datum, String>>[
                          LineSeries<Datum, String>(
                              dataSource: <Datum>[...allCryptoChartValues],
                              xValueMapper: (Datum data, _) => data.priceUsd,
                              yValueMapper: (Datum data, _) => data.time)
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Container(
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
                      title: text(name, fontSize: 16.0),
                      subtitle: text("\$" + price, fontSize: 14),
                      trailing: text(percentage + "%",
                          fontSize: 16,
                          textColor: isNegative(percentage)
                              ? Colors.red
                              : Colors.green),
                    ),
                  ],
                ),
              ));
  }
}
