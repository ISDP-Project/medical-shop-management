import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/authentication.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final Userr user = context.read<AuthenticationBloc>().state.user!;

    return Scaffold(
        appBar:AppBar(
          title:Text("Your Profile"),

      ),
        body: SafeArea(
            child: Column(children: [
      Container(
        child: Container(
          width: double.infinity,
          height: 150,
          child: Container(
            alignment: const Alignment(0.0, 2.5),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
              ),
              radius: 70.0,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        "${user.firstName} ${user.lastName}",
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.blueGrey,
          letterSpacing: 2.0,
        ),
      ),
      const SizedBox(height: 40),
      Column(children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      "Email:",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 40)),
                    Text(
                      "${user.email}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              // const Expanded(
              //     child: Padding(padding: EdgeInsets.only(left: 15.0))),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top:20)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      "Ph Number:",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 40)),
                    Text(
                      "${user.phoneNo}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              // const Expanded(
              //     child: Padding(padding: EdgeInsets.only(left: 15.0))),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top:20)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Icon(
                      Icons.medical_services,
                      color: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      "Phamacy:",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 40)),
                    Text(
                      "${user.pharmacyName}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              // const Expanded(
              //     child: Padding(padding: EdgeInsets.only(left: 15.0))),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top:20)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Icon(
                      Icons.money,
                      color: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      "GSTIN:",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 40)),
                    Text(
                      "${user.pharmacyGstin}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              // const Expanded(
              //     child: Padding(padding: EdgeInsets.only(left: 15.0))),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top:20)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Icon(
                      Icons.gps_fixed,
                      color: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      "Address:",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 40)),
                    Text(
                      "${user.pharmacyAddress}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              // const Expanded(
              //     child: Padding(padding: EdgeInsets.only(left: 15.0))),
            ],
          ),
        ),
      ]),
    ])));
  }
}
