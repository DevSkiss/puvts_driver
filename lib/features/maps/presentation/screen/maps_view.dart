import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:puvts_driver/core/constants/puvts_colors.dart';
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
  Location location = Location();
  LocationData? locationData;
  Timer? timer;
  LatLng? position;
  bool loading = false;
  late StreamSubscription<LocationData> locationSub;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(11.0, 124.0),
    zoom: 8,
  );
  GoogleMapController? _googleMapController;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 15), (Timer t) async {
      await getLocation();
      context.read<MapBloc>().updateMyLocation(
          latitude: locationData?.latitude ?? 11,
          longitude: locationData?.longitude ?? 124);
    });
    super.initState();
  }

  void _activate() {
    setState(() {
      loading = true;
    });
    locationSub =
        location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        position = LatLng(
          currentLocation.latitude ?? 11,
          currentLocation.longitude ?? 124,
        );
        _googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: position ?? LatLng(11, 124),
              zoom: 16.5,
            ),
          ),
        );
      });
    });
  }

  void _deactivate() {
    setState(() {
      loading = false;
      locationSub.cancel();
    });
  }

  Future<void> getLocation() async {
    locationData = await location.getLocation();
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    locationSub.cancel();
    timer?.cancel();
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
                    context.read<MapBloc>().logout();
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
                            markerId: MarkerId('driverPosition'),
                            infoWindow: InfoWindow(title: 'Driver'),
                            position: LatLng(position?.latitude ?? 11,
                                position?.longitude ?? 124),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueBlue),
                          ),
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
                    if (locationData != null)
                      Text(
                          '${locationData?.latitude}, ${locationData?.longitude}'),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.transparent,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PuvtsButton(
                            text: 'Acitavate',
                            isLoading: loading,
                            buttonColor: puvtsBlue,
                            textColor: Colors.white,
                            height: 50,
                            borderColor: Colors.transparent,
                            onPressed: () {
                              if (loading) {
                                _deactivate();
                              } else {
                                _activate();
                              }
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
        );
      },
    );
  }
}
