package toastmaster.android;

import android.app.*;
import android.webkit.*;
import android.widget.*;
import android.os.*;

public class EmbeddedBrowserActivity extends Activity {
	private static final boolean DEBUG = BuildConfig.DEBUG;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		WebView container = (WebView) findViewById(R.id.WebViewContainer);
		container.getSettings().setJavaScriptEnabled(true);
		container.addJavascriptInterface(
				new JsToaster(this),
				"androidToaster");

		final String url = "http://10.0.2.2:8080";
		if(DEBUG) log("Pointing browser to %s", url);
		container.loadUrl(url);
	}

	private void log(String message, Object...extras) {
		if(DEBUG) System.err.println(String.format(
				message, extras));
	}
}

class JsToaster {
	private final Activity context;

	public JsToaster(Activity context) { this.context = context; }

	public void toast(String toast) {
		Toast.makeText(context, toast, Toast.LENGTH_SHORT).show();
	}
}
