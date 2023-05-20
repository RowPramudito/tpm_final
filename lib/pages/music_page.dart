import 'package:flutter/material.dart';
import 'package:tmp_finalproject/connect_api.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  Connect connect_api = new Connect();

  List<String> tags = [
    'pop', 'rock', 'hip hop', 'indie', 'electronic', 'experimental', 'jazz', 'metal', 'dance',
    'punk', 'blues', 'shoegaze', 'rnb', 'industrial'
  ];
  String chosen_tag = 'pop';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            height: MediaQuery.of(context).size.height/10,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  child: OutlinedButton(
                    child: Text(tags[index]),
                    onPressed: (){
                      setState(() {
                        chosen_tag = tags[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: connect_api.fetchTopAlbums(chosen_tag),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final albums = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10
                    ),
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      final album = albums[index];
                      final albumName = album['name'];
                      final artistName = album['artist']['name'];
                      final Uri _url = Uri.parse(album['url']);

                      return Card(
                        child: InkWell(
                          onTap: () {
                            launchUrl(_url);
                          },
                          child: GridTile(
                            child: Image.network(
                              album['image'][2]['#text'],
                              fit: BoxFit.fill,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                throw Exception('Failed to load album cover');
                              },
                            ),
                            footer: GridTileBar(
                              backgroundColor: Colors.black38,
                              title: Text(
                                albumName,
                                style: const TextStyle(
                                  fontSize: 16
                                ),
                              ),
                              subtitle: Text(
                                artistName,
                                style: const TextStyle(
                                  fontSize: 10
                                ),
                              ),
                            )
                          ),
                        ),
                      );
                    },
                  );
                }
                else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to fetch top albums.'),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
