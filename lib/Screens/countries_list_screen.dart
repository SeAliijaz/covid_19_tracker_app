import 'package:covid_19_tracker_app/Services/status_services.dart';
import 'package:flutter/material.dart';
import '../Widgets/custom_text_field.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  ///search controller
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatusServices statusServices = StatusServices();
    return Scaffold(
      body: Column(
        children: [
          CustomTextField(
            textEditingController: searchController,
            hintText: "Search Countries",
            labelText: "Search Here...",
            prefixIcon: Icons.search_outlined,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: statusServices.fetchCountriesLists(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<dynamic>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Loading"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "${snapshot.data![index]["countryInfo"]["flag"]}"),
                          ),
                          title: Text(
                              "Country: ${snapshot.data![index]["country"]}"),
                          subtitle:
                              Text("Cases: ${snapshot.data![index]["cases"]}"),
                          trailing: const Text("Ali ijaz"),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
