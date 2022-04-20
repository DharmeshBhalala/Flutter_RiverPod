import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Network/network_api.dart';
import '../model/canada_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            //in case if error found
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as Canada;

            return ListView.builder(
              itemCount: items == null ? 0 : items.rows?.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                //    shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) => Icon(
                                        Icons.error,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                  height: 250,
                                  width: 320,
                                  imageUrl: items.rows?[index].imageHref ??
                                      "".toString()),
                            ),

                            // Container(
                            //   width: 50,
                            //   height: 50,
                            //   child:
                            //
                            //
                            //   // Image.network(
                            //   //     items.rows?[index].imageHref ??
                            //   //         "".toString()),
                            // ),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(
                                      items.rows?[index].title ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(
                                      items.rows?[index].description ?? "",
                                    ),
                                  )
                                ],
                              ),
                            ))
                          ]),
                    ));
              },
              shrinkWrap: true,
            );
          } else {
            // show circular progress while data is getting fetched from json file
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
