import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_esign_pspdfplugin/data/data.dart';
import 'package:test_esign_pspdfplugin/model/prices.dart';
import 'package:test_esign_pspdfplugin/network/network_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ConstData {
  late String _currentName;
  MetalPrices? metalPrices;
  NetworkData networkData = NetworkData();
  String _errorMessage = "";

  _suffleName() {
    int index = Random().nextInt(5);
    _currentName = names[index];
    setState(() {});
  }

  _getData() async {
    try {
      metalPrices = await networkData.getMetalPrices();
    } catch (exp) {
      _errorMessage = exp.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong",
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    _currentName = names.first;
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Greeting",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "hello, ",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  TextSpan(
                    text: _currentName,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            metalPrices == null
                ? Text(_errorMessage)
                : TableWidget(metalPrices: metalPrices!),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.shuffle,
        ),
        onPressed: () {
          _suffleName();
        },
      ),
    );
  }
}

class TableWidget extends StatelessWidget {
  const TableWidget({
    super.key,
    required this.metalPrices,
  });
  final MetalPrices metalPrices;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Current Updated time : ${metalPrices.currentTime}"),
        Table(
          children: [
            const TableRow(
              children: [
                Text("Unit"),
                Text("Gold"),
                Text("Silver "),
                Text("Platinum"),
              ],
            ),
            TableRow(
              children: [
                const Text("Ounce"),
                Text(" ${metalPrices.prices!.ounce!.gold}"),
                Text("${metalPrices.prices!.ounce!.silver}"),
                Text("${metalPrices.prices!.ounce!.platinum}"),
              ],
            ),
            TableRow(
              children: [
                const Text("Gram"),
                Text(" ${metalPrices.prices!.gram!.gold}"),
                Text("${metalPrices.prices!.gram!.silver}"),
                Text("${metalPrices.prices!.gram!.platinum}"),
              ],
            ),
            TableRow(
              children: [
                const Text("100 g"),
                Text(" ${metalPrices.prices!.hundredGram!.gold}"),
                Text("${metalPrices.prices!.hundredGram!.silver}"),
                Text("${metalPrices.prices!.hundredGram!.platinum}"),
              ],
            ),
            TableRow(
              children: [
                const Text("1 kg"),
                Text(" ${metalPrices.prices!.thousandGram!.gold}"),
                Text("${metalPrices.prices!.thousandGram!.silver}"),
                Text("${metalPrices.prices!.thousandGram!.platinum}"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
