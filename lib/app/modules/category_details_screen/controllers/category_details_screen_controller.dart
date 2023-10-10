import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/response/category_match_model.dart';

import '../../../../utils/constants.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';

class CategoryDetailsScreenController extends GetxController {
  //TODO: Implement CategoryDetailsScreenController


  ApiCallStatus apiCallStatus = ApiCallStatus.loading;
  CategoryMatchModel data = CategoryMatchModel();
  var slug = "".obs;

  // getting data from api
  getData() async {
    // *) perform api call
    await BaseClient.safeApiCall(
      "${Constants.categoryMatchApiUrl}$slug", // url
      RequestType.get, // request type (get,post,delete,put)
      onLoading: () {
        // *) indicate loading state
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        // api done successfully
        print(response.extra);
        data = CategoryMatchModel.fromJson(response.data);
        // *) indicate success state
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        // show error message to user
        BaseClient.handleApiError(error);
        // *) indicate error status
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }


  @override
  void onInit() {
    slug.value = Get.arguments[0];
    getData();
    super.onInit();
  }


}
