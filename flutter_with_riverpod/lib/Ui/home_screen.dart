import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/network_api.dart';

class HomeScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, watch) {
    final jsonParser = watch(getDataModelFuture);
    return jsonParser.dataModel == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              centerTitle: true,
              title: Text(jsonParser.dataModel?.title ?? ''),
              actions: [
                IconButton(onPressed: () {
                  watch(getDataModelFuture).readJsonData();
                }, icon: const Icon(Icons.refresh), tooltip: 'Refresh',),
              ],
            ),
            body: ListView.builder(
                itemCount:
                    jsonParser.dataModel!.rows!.isEmpty ? 0 : jsonParser.dataModel!.rows?.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 34,
                                backgroundImage: NetworkImage(jsonParser.dataModel?.rows?[index].imageHref ?? ''),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => const Icon(
                                          Icons.error,
                                          size: 40,
                                          color: Colors.black,
                                        ),
                                    height: 45,
                                    width: 45,
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    imageUrl: jsonParser.dataModel?.rows?[index].imageHref ??
                                        "",),
                              ),
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Text(
                                        jsonParser.dataModel?.rows?[index].title ?? "",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Text(
                                        jsonParser.dataModel?.rows?[index].description ??
                                            "",
                                      ),
                                    )
                                  ],
                                ),
                              ))
                            ]),
                      ));
                },
                shrinkWrap: true,
              ),
          );
  }
}
