// android/app/src/main/java/com/{projectName}



import android.os.Bundle;
import com.facebook.react.ReactActivity;
import android.view.WindowManager;

public class MainActivity extends ReactActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);

      getWindow().setFlags(
          WindowManager.LayoutParams.FLAG_SECURE,
          WindowManager.LayoutParams.FLAG_SECURE
      );
  }
}
