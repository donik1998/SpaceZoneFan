import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:space_fun_zone/data/models/epic_image_model.dart';
import 'package:space_fun_zone/data/services/epic_service.dart';
import 'package:space_fun_zone/tools/no_such_date_dialog.dart';

class EPIC extends StatefulWidget {
  const EPIC({Key? key}) : super(key: key);

  @override
  _EPICState createState() => _EPICState();
}

class _EPICState extends State<EPIC> {
  List<EpicImageModel> _images = List<EpicImageModel>.empty(growable: true);
  late DateTime _currentDateTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final images = await EPICAPIService.instance.getImages();
      if (images is List<EpicImageModel>) setState(() => _images = images);
    });
    _currentDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 16),
        Text(
          'Most recent photos of Earth to ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(_currentDateTime)}',
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        if (_images.isEmpty)
          const Expanded(
            child: Center(
              child: FlareActor(
                'assets/images/LiquidLoad.flr',
                fit: BoxFit.contain,
                alignment: Alignment.center,
                animation: 'Loading',
              ),
            ),
          ),
        if (_images.isNotEmpty)
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: _images.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return EarthPhotoWidget(photo: _images.elementAt(index));
              },
            ),
          ),
        const SizedBox(height: 16),
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          height: 56,
          onPressed: () => _selectDate(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          child: const Text(
            'Select date',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    var period = const Duration(days: 365 * 10);
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(period),
      lastDate: DateTime.now().add(period),
    );
    if (_pickedDate is DateTime) {
      EPICAPIService.instance.getClosetsToDateImages(_pickedDate).then((images) {
        setState(() {
          _images = images;
          _currentDateTime = _pickedDate;
        });
        if (_images.isEmpty) {
          showDialog(context: context, builder: (context) => NoSuchDateError());
        }
      });
    }
  }
}

class EarthPhotoWidget extends StatelessWidget {
  final EpicImageModel photo;

  const EarthPhotoWidget({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String convertedDateTime = DateFormat('yyyy/MM/dd').format(photo.date!);
    return Column(
      children: [
        Container(
          child: CachedNetworkImage(
            imageUrl: 'https://epic.gsfc.nasa.gov/archive/natural/$convertedDateTime/png/${photo.image}.png',
            imageBuilder: (context, image) => ClipOval(child: Image(image: image)),
            placeholder: (context, url) => const Center(child: Icon(Icons.language)),
          ),
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          'Taken on ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(photo.date!)}',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
