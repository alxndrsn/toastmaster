package toastmaster.cordova;

import android.os.Bundle;
import org.apache.cordova.*;

public class MainActivity extends CordovaActivity {
	public static MainActivity CONTEXT;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		CONTEXT = this;
		loadUrl(launchUrl);
	}
}
