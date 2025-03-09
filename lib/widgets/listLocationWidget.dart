import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rickandmorty/helpers/utils.dart';

import '../bloc/character/character_bloc.dart';
import '../models/characterModel.dart';
import '../models/locationModel.dart';
import '../screens/character/characterDetailsPage.dart';

class ListLocationWidget extends StatefulWidget {
  final ResultLocation location;
  final CharacterBloc characterBloc;
  const ListLocationWidget({super.key, required this.location, required this.characterBloc});
  @override
  State<ListLocationWidget> createState() => _ListLocationWidgetState();
}

class _ListLocationWidgetState extends State<ListLocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.location.name ?? '',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "${widget.location.type} • ${widget.location.dimension}",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xff6E798C),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                  36.verticalSpace,
                  Text(
                    'Characters',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Expanded(
                    child: BlocBuilder<CharacterBloc, CharacterState>(
                      bloc: widget.characterBloc,
                      builder: (context, state) {
                        if (state is CharacterLoadingState) {
                          return const Center(
                            child: CupertinoActivityIndicator(
                              color: Colors.white,
                            ),
                          );
                        } else if (state is CharacterErrorState) {
                          return Text(state.error,
                              style: const TextStyle(color: Colors.white));
                        } else if (state is CharacterLoadedState) {
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                24.verticalSpace,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.character.length,
                            itemBuilder: (BuildContext context, int index) {
                              final character = state.character[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CharacterDetailsPage(
                                        character: character,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 74.r,
                                      width: 74.r,
                                      child: ClipOval(
                                        child: Image.network(
                                            character.image.toString(),
                                            fit: BoxFit.cover),
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
                                              color: const Color(0xff6E798C),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                        color: Colors.white, size: 17.r),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  )
                ],
              );
  }
}