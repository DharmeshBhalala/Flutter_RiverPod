// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Network/network_api.dart';
import '../model/data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget? homeScreen;
  bool _isGettingData = true;
  DataModel? _dataModel;
  late String errorMsg;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    _dataModel = await readJsonData();
    _isGettingData = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isGettingData
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              title: Text(_dataModel?.title ?? ''),
            ),
            body: ListView.builder(
                itemCount:
                    _dataModel!.rows!.isEmpty ? 0 : _dataModel!.rows?.length,
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
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                     shape: BoxShape.circle,
                                     color: Colors.grey,
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(_dataModel!.rows?[index].imageHref ?? ''),
                                //   child: Image.network(_dataModel!.rows?[index].imageHref ?? '', fit: BoxFit.fill, height: 50,
                                //   width: 50,
                                //   loadingBuilder: (context, child, ImageChunkEvent? chunkwell) {if (chunkwell == null) {return child;} else {
                                //     return Center(child: CircularProgressIndicator(
                                //       value: chunkwell.expectedTotalBytes != null ?
                                //                 chunkwell.cumulativeBytesLoaded / chunkwell.expectedTotalBytes!
                                //              : null, 
                                //              ));
                                //   }},
                                //   errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error))),
                                ),

                                // child: CachedNetworkImage(
                                //     fit: BoxFit.fill,
                                //     errorWidget: (context, url, error) => const Icon(
                                //           Icons.error,
                                //           size: 40,
                                //           color: Colors.black,
                                //         ),
                                //     height: 250,
                                //     width: 320,
                                //     imageUrl: _dataModel.rows?[index].imageHref ??
                                //         "".toString()),
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
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Text(
                                        _dataModel?.rows?[index].title ?? "",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Text(
                                        _dataModel?.rows?[index].description ??
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
