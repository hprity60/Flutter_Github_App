import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/data/remote datasource/repositories/remote_repositories.dart';
import 'core/router_name.dart';
import 'modules/controllers/repo cubit/repo_cubit.dart';
import 'modules/controllers/search bloc/search_bloc.dart';
import 'utils/k_strings.dart';
import 'utils/my_theme.dart';

//late final SharedPreferences _sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // _sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(
   
    repository: ApiRepositoriesIml(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.repository}) : super(key: key);
  final ApiRepositories repository;
  

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(
              
              apiRepositories: ApiRepositoriesIml(),
            ),
          ),
          BlocProvider(
            create: (context) => RepoCubit(repository),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Kstrings.appName,
          theme: MyTheme.theme,
          onGenerateRoute: RouteNames.generateRoute,
          initialRoute: RouteNames.repoListScreen,
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
            );
          },
          builder: (context, child) {
            return MediaQuery(
              child: child!,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
        ));
  }
}
