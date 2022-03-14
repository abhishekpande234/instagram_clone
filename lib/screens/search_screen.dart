import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: 'Search for user',
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder  (
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      bool islistavailable = false ;
                      var searchUid = (snapshot.data! as dynamic).docs[index].get('uid');
                      var searchPhotoUrl = (snapshot.data! as dynamic).docs[index].get('photoUrl');
                      var searchUserName = (snapshot.data! as dynamic).docs[index].get('username');
                      islistavailable = true ;
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => islistavailable ? ProfileScreen(
                                    uid: searchUid
                                        ) : CircularProgressIndicator()
                            )
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(islistavailable ?
                                searchPhotoUrl : ''
                                    ),
                          ),
                          title: Text(islistavailable ? searchUserName : 'Fetching....'
                              ),
                        ),
                      );
                    });
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) => Image.network(
                      (snapshot.data! as dynamic).docs[index].get('postUrl')),
                  staggeredTileBuilder: (index) =>
                      MediaQuery.of(context).size.width > webScreenSize
                          ? StaggeredTile.count(
                              (index % 7 == 0) ? 1 : 1,
                              (index % 7 == 0) ? 1 : 1,
                            )
                          : StaggeredTile.count(
                              (index % 7 == 0) ? 2 : 1,
                              (index % 7 == 0) ? 2 : 1,
                            ),
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                );
              }),
    );
  }
}
