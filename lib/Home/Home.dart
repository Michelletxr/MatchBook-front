import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text(
            "Livros perto de você",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.pink,
          elevation: 0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverAppBar(
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Transform.translate(
                    offset: const Offset(0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Filtrar por",
                          style: TextStyle(
                            color: Colors.black,
                          )
                        ),   
                        Row(children: [
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton(
                            value: "Localização",
                            items: <DropdownMenuItem<String>> [
                                      DropdownMenuItem(child: Text("Localização"),value: "Localização"),
                                      DropdownMenuItem(child: Text("Natal"),value: "Natal"),
                                      DropdownMenuItem(child: Text("Parnamirim"),value: "Parnamirim"),
                                      DropdownMenuItem(child: Text("Mossoró"),value: "Mossoró"),
                                    ],
                             onChanged: (String? lugar) {
                              print("lugar");
                            }
                          ),
                       
                        DropdownButton(
                            value: "Gênero",
                            items: <DropdownMenuItem<String>> [
                                      DropdownMenuItem(child: Text("Gênero"),value: "Gênero"),
                                      DropdownMenuItem(child: Text("Romance"),value: "Romance"),
                                      DropdownMenuItem(child: Text("Terror"),value: "Terror"),
                                      DropdownMenuItem(child: Text("Auto-Ajuda"),value: "Auto-Ajuda"),
                                      DropdownMenuItem(child: Text("Ficção-Científica"),value: "Ficcao-c"),
                                      DropdownMenuItem(child: Text("Drama"),value: "Drama"),
                                      DropdownMenuItem(child: Text("Fantasia"),value: "Fantasia"),
                                      DropdownMenuItem(child: Text("Literatura Brasileira"),value: "Literatura Brasileira"),
                                    ],
                             onChanged: (String? lugar) {
                              print("lugar");
                            }
                          ),
                        ],)
                      ]
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    child: Image(image: AssetImage('imagens/capa.jpg'),)
                  );
                },
                childCount: 100,
              ),
            )
          ],
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                onPressed: () {}, icon: Icon(Icons.home), color: Colors.grey),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.search), color: Colors.grey),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.account_box_rounded),
                color: Colors.grey)
          ],
        )
        );
  }
}

