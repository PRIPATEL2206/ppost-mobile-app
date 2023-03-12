import 'package:http/http.dart';
import 'package:ppostman/api/web_api.dart';
import 'package:ppostman/controlers/web_controler.dart';
import 'package:ppostman/get_helper/get_helper.dart';
import 'package:ppostman/repos/web_repo.dart';

Future<void> init() async {
  //  initalize local sharedpreference instance

  // initalize webclint
  final webClint = Client();

// initalize Apis
// initalize Web Api
  WebApi webApi = WebApi(webClint);

  // initalize repos
  // initialize web repo
  WebRepo webRepo = WebRepo(webApi);

  // initialize controlers
  // initialize web controlers
  WebControler webControler = WebControler(webRepo);

  // put controler in getServices to leter use

  GetHelper.put(webControler);
}
