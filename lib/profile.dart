import 'package:flutter/material.dart';


class Profile extends StatelessWidget {
  //const Home({super.key})
  @override
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 200,
          flexibleSpace: Image.asset(
                          "imagens/foto-perfil.jpg",
                          fit: BoxFit.cover,
                          ),
          backgroundColor: Colors.white,
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
                    child: Column(children: [
                      Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Rodrigo Antunes",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                      ),
                      Row(children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star_border),
                      ],
                      ),
                        Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "2 km de distância",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                      ),
                    ],)
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

