import 'package:flutter/material.dart';

import '../../constants/ui_decorations.dart';
import '../../constants/ui_strings.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(BillingPageConstants.billingPage),
      ),
      body: Column(
        children: [
          const Spacer(flex: 5),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              BillingPageConstants.medicalShop,
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
                BillingPageConstants.date,
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(
                flex: 100,
              ),
              Container(
                alignment: Alignment.topRight,
                child: const Text(
                  BillingPageConstants.day,
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
                BillingPageConstants.name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const Spacer(
                flex: 80,
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: const Text(
                    BillingPageConstants.qty,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
              const Spacer(
                flex: 80,
              ),
              Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(50),
                  child: const Text(
                    BillingPageConstants.price,
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
              left: kDefaultPadding * 25,
              right: kDefaultPadding * 25,
              bottom:
                  MediaQuery.of(ctx).viewInsets.bottom + kDefaultPadding * 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  margin: const EdgeInsets.symmetric(
                      horizontal: kDefaultMargin * 3,
                      vertical: kDefaultMargin * 1.4),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius:
                        BorderRadius.circular(kDefaultBorderRadius * 1.75),
                  ),
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
                    BillingPageConstants.paracetamol,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 10),
                  Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.circular(kDefaultBorderRadius * 3.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        Text(
                          BillingPageConstants.quantityNumber,
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
