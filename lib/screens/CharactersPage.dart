import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rickandmorty/bloc/character.dart/character_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/screens/CharacterPage.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharactersPage> {
  late final CharacterBloc characterBloc;
  late final TextEditingController controller;
  bool isList = true;

  @override
  void initState() {
    characterBloc = CharacterBloc();
    characterBloc.add(GetCharacters(page: "1"));
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    characterBloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff0B1E2D),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              15.verticalSpace,
              Container(
                height: 48.r,
                decoration: BoxDecoration(
                  color: Color(0xff152A3A),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.r, vertical: 12.r),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Color(0xff5B6975)),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Find character',
                            hintStyle: TextStyle(
                                color: Color(0xff5B6975),
                                fontWeight: FontWeight.w400,
                                fontSize: 16.r,
                                letterSpacing: 0.44.r),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Color(0xff5B6975),
                      ),
                      Icon(Icons.filter_alt_outlined, color: Color(0xff5B6975)),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,
              Expanded(
                child: BlocBuilder<CharacterBloc, CharacterState>(
                  bloc: characterBloc,
                  builder: (context, state) {
                    if (state is CharacterLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CharacterLoadedState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "TOTAL CHARACTERS: ${state.character.info!.count.toString()}",
                                style: TextStyle(
                                  color: Color(0xff5B6975),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5.r,
                                  fontSize: 10.r,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isList = !isList;
                                  });
                                },
                                icon: isList
                                    ? Icon(Icons.grid_view)
                                    : Icon(Icons.list),
                                color: Color(0xff5B6975),
                                iconSize: 24.r,
                              )
                            ],
                          ),
                          Expanded(
                              child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: isList ? 343.r : 164.r,
                              childAspectRatio: isList ? 4.5.r : 0.6.r,
                              crossAxisSpacing: 16.r,
                              mainAxisSpacing: 24.r,
                            ),
                            itemCount: state.character.results!.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final character = state.character.results![index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterPage( character: character,))); 
                                },
                                child: isList
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          height: 74.r,
                                          width: 74.r,
                                          child: ClipOval(
                                            child: Image.network(
                                              character.image.toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 18.r),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              character.status!.name.toString(),
                                              style: TextStyle(
                                                color: checkStatus(character
                                                    .status
                                                    .toString()),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.r,
                                                letterSpacing: 1.5.r,
                                              ),
                                            ),
                                            Text(
                                              character.name.toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.r,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${character.species!.name.toString()[0]}${character.species!.name.toString().substring(1).toLowerCase()}, ${character.gender!.name.toString()[0]}${character.gender!.name.toString().substring(1).toLowerCase()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5.r,
                                                  fontSize: 12.r,
                                                  color: Color(0xff6E798C)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 120.r,
                                          width: 120.r,
                                          child: ClipOval(
                                            child: Image.network(
                                              character.image ?? "",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 18.r),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              character.status!.name.toString(),
                                              style: TextStyle(
                                                color: checkStatus(character
                                                    .status
                                                    .toString()),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.r,
                                                letterSpacing: 1.5.r,
                                              ),
                                            ),
                                            Text(
                                              character.name.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.r,
                                                color: Colors.white,
                                                
                                              ),
                                            ),
                                            Text(
                                        "${state.character.results![index].species!.name.toString()[0]}${state.character.results![index].species!.name.toString().substring(1).toLowerCase()}, ${state.character.results![index].gender!.name.toString()[0]}${state.character.results![index].gender!.name.toString().substring(1).toLowerCase()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5.r,
                                            fontSize: 12.r,
                                            color: Color(0xff6E798C)),
                                      ),
                                          ],
                                        ),
                                      ],
                                    ),
                              );

                              
                            },
                          )),
                        ],
                      );
                    } else if (state is CharacterErrorState) {
                      return Center(
                        child: Text(
                          "Ошибка: ${state.error}",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color checkStatus(String status) {
  switch (status) {
    case "Status.ALIVE":
      return Color(0xff43D049);
    case "Status.DEAD":
      return Color(0xffEB5757);
    default:
      return Color(0xff6E798C);
  }
}
