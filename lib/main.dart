import 'package:podcast_app/bootstrap.dart';
import 'package:podcast_app/ui/app/presentation/app_page.dart';

Future<void> main() async {
  await bootstrap(
    () => const AppPage(),
  );
}
