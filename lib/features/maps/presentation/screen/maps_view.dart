import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:puvts_driver/app/locator_injection.dart';
import 'package:puvts_driver/core/constants/puvts_colors.dart';
import 'package:puvts_driver/core/services/cached_services.dart';
import 'package:puvts_driver/core/widgets/puvts_button.dart';
import 'package:puvts_driver/features/login_signup/presentation/screens/login_view.dart';
import 'package:puvts_driver/features/maps/domain/bloc/map_bloc.dart';
import 'package:puvts_driver/features/maps/domain/bloc/map_state.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapBloc(),
      child: MapsView(),
    );
  }
}

class MapsView extends StatefulWidget {
  const MapsView({Key? key}) : super(key: key);

  @override
  _MapsViewState createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  LatLng defaultLatLong = LatLng(11.242034, 124.999902);
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(11.242034, 124.999902),
    zoom: 14.5,
  );
  final CachedService _cachedService = locator<CachedService>();

  GoogleMapController? _googleMapController;

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: puvtsWhite,
            centerTitle: true,
            title: Text(
              'Maps View',
              style: TextStyle(color: puvtsBlue),
            ),
            elevation: 0,
            toolbarHeight: 70,
            actions: [
              IconButton(
                  onPressed: () async {
                    log('Remove User');
                    await _cachedService.clearUser();
                    Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return LoginView();
                        },
                      ),
                      (_) => false,
                    );
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    color: puvtsBlue,
                  ))
            ],
          ),
          body: state.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: true,
                        initialCameraPosition: _initialCameraPosition,
                        onMapCreated: (controller) =>
                            _googleMapController = controller,
                        // polylines: {
                        //   if (state.info != null)
                        //     Polyline(
                        //       polylineId: const PolylineId('direction'),
                        //       color: Colors.red,
                        //       width: 5,
                        //       points: state.info?.polylinePoints
                        //               .map((e) =>
                        //                   LatLng(e.latitude, e.longitude))
                        //               .toList() ??
                        //           [],
                        //     )
                        // },
                        markers: {
                          if (state.markers != null) ...state.markers!,
                          Marker(
                            markerId: MarkerId('empty'),
                          ),
                          state.driverPosition ??
                              Marker(
                                markerId: MarkerId('empty'),
                              ),
                          state.myPosition ??
                              Marker(
                                markerId: MarkerId('empty'),
                              )
                        },
                      ),
                    ),
                    Visibility(
                        visible: state.info != null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                              'Duration: ${state.info?.totalDuration} - Distance ${state.info?.totalDistance}'),
                        )),
                    SizedBox(height: 15),
                    Text(
                        '${state.myPosition?.position.latitude}, ${state.myPosition?.position.longitude}'),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.transparent,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PuvtsButton(
                            text: 'Send New Location',
                            buttonColor: puvtsBlue,
                            height: 50,
                            textColor: Colors.white,
                            borderColor: Colors.transparent,
                            onPressed: () {
                              context.read<MapBloc>().activateMyLocation();
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(
                                      state.myPosition?.position.latitude ??
                                          11.242034,
                                      state.myPosition?.position.longitude ??
                                          124.999902),
                                  zoom: 16.5,
                                ),
                              );
                            },
                          ),
                          PuvtsButton(
                            text: 'Find Passengers',
                            buttonColor: puvtsRed,
                            textColor: Colors.white,
                            height: 50,
                            borderColor: Colors.transparent,
                            onPressed: () =>
                                context.read<MapBloc>().getPassengerLocation(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
          floatingActionButton: Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 130, left: 30),
              child: FloatingActionButton(
                child: Icon(Icons.location_on),
                onPressed: () => _googleMapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(
                          state.myPosition?.position.latitude ?? 11.242034,
                          state.myPosition?.position.longitude ?? 124.999902),
                      zoom: 16.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
