import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing Page'),
      ),
      body: Column(
        children: [
          const Spacer(flex: 5),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              "Medical Shop Name",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(flex: 10),
          Row(
            children: [
              const Spacer(
                flex: 15,
              ),
              const Text(
                "Date: 20-04-2022 ",
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(
                flex: 100,
              ),
              Container(
                alignment: Alignment.topRight,
                child: const Text(
                  "Day: Friday ",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Spacer(flex: 25)
            ],
          ),
          Row(
            children: [
              const Spacer(
                flex: 20,
              ),
              const Text(
                "Name:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const Spacer(
                flex: 80,
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: const Text(
                    "Qty.",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
              const Spacer(
                flex: 80,
              ),
              Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(50),
                  child: const Text(
                    "Price:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
              const Spacer(flex: 20)
            ],
          ),
          const Spacer(
            flex: 80,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _show(context),
      ),
    );
  }

  void _show(BuildContext ctx) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 0,
              left: 200,
              right: 200,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: const Icon(Icons.search,
                              color: Colors.blueAccent),
                          margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      const Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search medecine"),
                      ))
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Paracetamol",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 10),
                  Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
