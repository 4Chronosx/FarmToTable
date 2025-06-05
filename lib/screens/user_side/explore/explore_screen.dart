
import 'package:farm2you/commons.dart';
import 'package:latlong2/latlong.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  
  @override
  Widget build(BuildContext context) {
    final mapControllerVar = MapController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            context.push('/userprofile');
          }, icon: Icon(FontAwesomeIcons.solidCircleUser, size: 30),)
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapControllerVar,
            options: MapOptions(
              initialCenter: LatLng(10.322467560222893, 123.89885172891246),
              initialZoom: 18,
              minZoom: 0,
              maxZoom: 100,
              cameraConstraint: CameraConstraint.contain(
                bounds:LatLngBounds(
                    const LatLng(-85.0, -180.0),
                    const LatLng(85.0, 180.0)
                  )
                )
            ),
            children: [
              TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',)

            ]
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              
            )
          ),
        ],
      ),
      
    );
  }

}
