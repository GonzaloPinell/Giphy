import 'package:flutter/material.dart';
import 'package:giphy/src/models/giphy_model.dart';
import 'package:giphy/src/services/giphy_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> giphy;

  late GiphyModel giphyModel;

  @override
  void initState() {
    giphy = giphyService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giphy'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.refresh_rounded,
        ),
        onPressed: () {
          setState(() {
            giphy = giphyService();
          });
        },
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: giphy,
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                } else {
                  giphyModel = GiphyModel.fromJson(snapshot.data!);

                  if (giphyModel.data.isNotEmpty) {
                    return ListView.builder(
                      itemCount: giphyModel.data.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.5,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Image.network(
                                giphyModel.data
                                    .elementAt(index)
                                    .images
                                    .original
                                    .url,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              (giphyModel.data.elementAt(index).title.isEmpty)
                                  ? 'No hay información'
                                  : giphyModel.data.elementAt(index).title,
                              style: TextStyle(
                                color: (giphyModel.data
                                        .elementAt(index)
                                        .title
                                        .isEmpty)
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              (giphyModel.data
                                      .elementAt(index)
                                      .username
                                      .isEmpty)
                                  ? 'No hay información'
                                  : giphyModel.data.elementAt(index).username,
                              style: TextStyle(
                                color: (giphyModel.data
                                        .elementAt(index)
                                        .username
                                        .isEmpty)
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No hay gifs que mostrar',
                      ),
                    );
                  }
                }
            }
          },
        ),
      ),
    );
  }
}
