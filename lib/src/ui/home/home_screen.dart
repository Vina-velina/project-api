import 'package:flutter/material.dart';
import 'package:api_tugas/src/api/api_service.dart';
import 'package:api_tugas/src/model/profile.dart';
import 'package:api_tugas/src/ui/formadd/form_add_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext context;
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getProfiles(),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Profile> profiles = snapshot.data;
            return _buildListView(profiles);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Profile> profiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Profile profile = profiles[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      profile.name.toUpperCase(),
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(profile.email.toLowerCase()),
                    Text(profile.age.toString()+" Tahun"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Konfirmasi"),
                                    content: Text("Apakah Anda Yakin Ingin Menghapus Data Anggota ${profile.name}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yakin"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiService.deleteProfile(profile.id).then((isSuccess) {
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(content: Text("Data Berhasil Dihapus")));
                                            } else {
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(content: Text("Data Gagal Dihapus")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Batal"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Hapus",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return FormAddScreen(profile: profile);
                            }));
                            if (result != null) {
                              setState(() {});
                            }
                          },
                          child: Text(
                            "Ubah",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: profiles.length,
      ),
    );
  }
}
