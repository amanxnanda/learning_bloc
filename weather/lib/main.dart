import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather/bloc_observer.dart';
import 'package:weather/theme/theme.dart';
import 'package:weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
    () {},
    blocObserver: SimpleBlocObserver(),
  );
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () {},
    storage: storage,
  );

  runApp(
    WeatherApp(weatherRepository: WeatherRepository()),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({
    required WeatherRepository weatherRepository,
    Key? key,
  })  : _weatherRepository = weatherRepository,
        super(key: key);

  final WeatherRepository _weatherRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepository,
      child: BlocProvider(
        create: (_) => ThemeCubit(),
        child: const WeatherAppView(),
      ),
    );
  }
}

class WeatherAppView extends StatelessWidget {
  const WeatherAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ThemeCubit, Color>(
      builder: (context, color) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: color,
            textTheme: GoogleFonts.rajdhaniTextTheme(),
            appBarTheme: AppBarTheme(
                titleTextStyle: GoogleFonts.rajdhaniTextTheme(textTheme).apply(bodyColor: Colors.white).headline6,
                ),
          ),
          home: const WeatherPage(),
        );
      },
    );
  }
}
