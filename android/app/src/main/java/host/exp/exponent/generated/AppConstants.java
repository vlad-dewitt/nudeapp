package host.exp.exponent.generated;

import com.facebook.common.internal.DoNotStrip;

import java.util.ArrayList;
import java.util.List;

import host.exp.exponent.BuildConfig;
import host.exp.exponent.Constants;

@DoNotStrip
public class AppConstants {

  public static final String VERSION_NAME = "1.0.0";
  public static String INITIAL_URL = "exp://exp.host/@vlad.dewitt/nudeapp";
  public static final String SHELL_APP_SCHEME = "exp5b1bba5c81734aeb884d5697777eb207";
  public static final String RELEASE_CHANNEL = "prod-2019-12-24t18-48-03";
  public static boolean SHOW_LOADING_VIEW_IN_SHELL_APP = true;
  public static boolean ARE_REMOTE_UPDATES_ENABLED = true;
  public static final List<Constants.EmbeddedResponse> EMBEDDED_RESPONSES;
  public static boolean FCM_ENABLED = false;

  static {
    List<Constants.EmbeddedResponse> embeddedResponses = new ArrayList<>();

    
        // ADD EMBEDDED RESPONSES HERE
        // START EMBEDDED RESPONSES
        embeddedResponses.add(new Constants.EmbeddedResponse("https://exp.host/@vlad.dewitt/nudeapp", "assets://shell-app-manifest.json", "application/json"));
        embeddedResponses.add(new Constants.EmbeddedResponse("https://d1wp6m56sqw74a.cloudfront.net/%40vlad.dewitt%2Fnudeapp%2F1.0.0%2Fa9dcef15fc9de6668eb8f633d0536149-34.0.0-android.js", "assets://shell-app.bundle", "application/javascript"));
        // END EMBEDDED RESPONSES
    EMBEDDED_RESPONSES = embeddedResponses;
  }

  // Called from expoview/Constants
  public static Constants.ExpoViewAppConstants get() {
    Constants.ExpoViewAppConstants constants = new Constants.ExpoViewAppConstants();
    constants.VERSION_NAME = VERSION_NAME;
    constants.INITIAL_URL = INITIAL_URL;
    constants.SHELL_APP_SCHEME = SHELL_APP_SCHEME;
    constants.RELEASE_CHANNEL = RELEASE_CHANNEL;
    constants.SHOW_LOADING_VIEW_IN_SHELL_APP = SHOW_LOADING_VIEW_IN_SHELL_APP;
    constants.ARE_REMOTE_UPDATES_ENABLED = ARE_REMOTE_UPDATES_ENABLED;
    constants.EMBEDDED_RESPONSES = EMBEDDED_RESPONSES;
    constants.ANDROID_VERSION_CODE = BuildConfig.VERSION_CODE;
    constants.FCM_ENABLED = FCM_ENABLED;
    return constants;
  }
}
