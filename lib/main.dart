import 'package:flutter/material.dart';
import 'package:quizpbm/detailproduct.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() {
  runApp(MyApp(
    counter: 2,
    index: 1,
  ));
}

class MyApp extends StatefulWidget {
  final int counter, index;
  const MyApp({Key? key, required this.counter, required this.index})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List data = [];

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/product.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  num total = 0;

  setTotal(data, index, counter) {
    num initTotal = 0;
    data[index]["jumlah"] = counter;
    for (var i = 0; i < data.length; i++) {
      initTotal = initTotal + ((data[i]["price"]) * (data[i]["jumlah"]));
    }
    total = initTotal;
    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text("Keranjang Belanja"), backgroundColor: Colors.green),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
                height: 120,
                width: double.infinity,
                margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(data[index]["image"]),
                                fit: BoxFit.cover),
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)))),
                    Container(
                        margin: EdgeInsets.only(
                            left: 10, top: 5, right: 10, bottom: 5),
                        height: 100,
                        width: 200,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(data[index]["name"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Text("Rp " + data[index]["price"].toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                  "Jumlah : " +
                                      data[index]["jumlah"].toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                              MaterialButton(
                                height: 30,
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Text("Lihat Detail"),
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailProduct(
                                                detail: index,
                                                data: data,
                                              )))
                                },
                                splashColor: Colors.lightGreen,
                              )
                            ]))
                  ],
                ));
          },
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
          color: Colors.green,
          height: 50,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text("TOTAL",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
              Container(
                child: Text(
                    "Rp " + setTotal(data, widget.index, widget.counter),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              )
            ],
          ),
        )),
      ),
    );
  }
}
