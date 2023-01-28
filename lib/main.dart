import 'package:podcast_app/bootstrap.dart';
import 'package:podcast_app/ui/app/app.dart';

Future<void> main() async {
  await bootstrap(
    () => const AppPage(),
  );
}
