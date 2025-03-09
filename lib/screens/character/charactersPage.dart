import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rickandmorty/bloc/character/character_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/models/characterModel.dart';

import '../../helpers/utils.dart';
import 'characterDetailsPage.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharactersPage> {
  late final PagingController<int, Character> pagingController;
  late final CharacterBloc characterBloc;
  late final TextEditingController controller;
  bool isList = true;
  int pageCount = 1;

  @override
  void initState() {
    pagingController = PagingController(firstPageKey: pageCount);
    characterBloc = CharacterBloc();
    controller = TextEditingController();
    pagingController.addPageRequestListener(
      (pageKey) {
        characterBloc.add(GetCharacters(page: pageKey));
      },
    );
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
    return Scaffold(
        backgroundColor: Color(0xff0B1E2D),
        body: Padding(
          padding:
              EdgeInsets.only(left: 16.r, right: 16.r, top: 16.r, bottom: 5.r),
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
                      SvgPicture.asset("assets/icons/filtr_icon.svg", colorFilter: ColorFilter.mode(Color(0xff5B6975), BlendMode.dstIn)),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,
              Expanded(
                child: BlocListener(
                  bloc: characterBloc,
                  listener: (context, state) {
                    if (state is CharacterLoadedState) {
                      pageCount++;
                      setState(() {});
                      pagingController.appendPage(state.character, pageCount);
                    } else if (state is CharacterErrorState) {
                      pagingController.error = state.error;
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TOTAL CHARACTERS: ${pagingController.itemList == null ? "0" : pagingController.itemList!.length}",
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
                        child: PagedGridView<int, Character>(
                          pagingController: pagingController,
                          builderDelegate: PagedChildBuilderDelegate(
                            itemBuilder: (context, item, index) {
                              final character = item;
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CharacterDetailsPage(
                                                character: character,
                                              )));
                                },
                                child:isList? Row(
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
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            character.status!.name.toString(),
                                            style: TextStyle(
                                              color: checkStatus(
                                                  character.status ??
                                                      Status.UNKNOWN),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10.r,
                                              letterSpacing: 1.5.r,
                                            ),
                                          ),
                                          Text(
                                            character.name.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                                    ),
                                  ],
                                ): Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                              color: checkStatus(
                                                  character.status?? Status.UNKNOWN),
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
                                  ),
                              );
                            },
                          ),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: isList ? 343.r : 164.r,
                            childAspectRatio: isList ? 4.5.r : 0.6.r,
                            crossAxisSpacing: 16.r,
                            mainAxisSpacing: 24.r,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}

