import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rickandmorty/bloc/character/character_bloc.dart';
import 'package:rickandmorty/helpers/utils.dart';
import 'package:rickandmorty/models/locationModel.dart';
import 'package:rickandmorty/widgets/listLocationWidget.dart';
import '../../bloc/location/location_bloc.dart';

class LocationDetailsPage extends StatefulWidget {
  final ResultLocation? location;
  final String? id;
  const LocationDetailsPage({super.key, this.location, this.id});
  @override
  State<LocationDetailsPage> createState() => _LocationDetailsPageState();
}

class _LocationDetailsPageState extends State<LocationDetailsPage> {
  late final CharacterBloc characterBloc;
  late final LocationBloc locationBloc;
  @override
  void initState() {
    characterBloc = CharacterBloc();
    locationBloc = LocationBloc();
    if (widget.location != null) {
      characterBloc.add(GetCharactersInLocation(
          numbers: extractId(widget.location!.residents ?? [])));
    } else {
      locationBloc.add(GetCharacterLocation(id: widget.id!));
    }

    super.initState();
  }

  @override
  void dispose() {
    characterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0B1E2D),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
          ),
          Positioned(
            child: Image.asset(
              "assets/location.png",
              height: 280.r,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50.r,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 251.r,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: const Color(0XFF0B1E2D),
                borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
              ),
              child: widget.location == null
                  ? BlocBuilder(
                      bloc: locationBloc,
                      builder: (context, state) {
                        if (state is LocationLoadingState) {
                          return const Center(
                            child: CupertinoActivityIndicator(
                              color: Colors.white,
                            ),
                          );
                        } else if (state is LocationLoadedState) {
                          characterBloc.add(GetCharactersInLocation(
                              numbers:
                                  extractId(state.location.first.residents??[])));
                          return ListLocationWidget(
                            location: state.location.first,
                            characterBloc: characterBloc,
                          );
                        } else if (state is LocationErrorState) {
                          return Center(
                            child: Text(state.error),
                          );
                        }
                        return Container();
                      },
                    )
                  : ListLocationWidget(
                      location: widget.location!,
                      characterBloc: characterBloc,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
