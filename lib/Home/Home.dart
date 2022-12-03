import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  //const Home({super.key})
  @override
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 140.0,
                child:DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: 
                Row(children: [
                  CircleAvatar(
                    radius: 30.0,
                    child: ClipRRect(
                      child: Image.asset( 
                        "imagens/foto-perfil.jpg",
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                        ),
                      borderRadius: BorderRadius.circular(100.0),
                      )
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    'Rodrigo Antunes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    ),
                ],),
              ),
              ),
              ListTile(
                title: Text(
                  'Livros',
                  style: TextStyle(
                  color: Color(0xFFB0BEC5),  
                  ),
                  ),
                leading: Icon(Icons.book),   
                enabled: false,
                tileColor: Color(0xFFECEFF1),           
                onTap: (){

                },
              ),
              ListTile(
                title: Text('Meus Livros'),
                leading: Icon(Icons.menu_book),
                onTap: (){

                },
              ),
              ListTile(
                title: Text('Livros Desejados'),
                leading: Icon(Icons.bookmark),
                onTap: (){

                },
              ),
              ListTile(
                title: Text('Empréstimos'),
                leading: Icon(Icons.people_alt),
                onTap: (){

                },
              ),
              ListTile(
                title: Text(
                  'Conta',
                  style: TextStyle(
                    color: Color(0xFFB0BEC5),  
                  )
                  ),
                tileColor: Color(0xFFECEFF1),
                leading: Icon(Icons.person),
                enabled: false,
                onTap: (){

                },
              ),
              ListTile(
                title: Text('Configurações'),
                leading: Icon(Icons.settings),
                onTap: (){

                },
              ),
              ListTile(
                title: Text('Segurança'),
                leading: Icon(Icons.security),
                onTap: (){

                },
              ),
              ListTile(
                title: Text('Ajuda'),
                leading: Icon(Icons.help),
                onTap: (){

                },
              )
            ],
          ),
        ),
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

