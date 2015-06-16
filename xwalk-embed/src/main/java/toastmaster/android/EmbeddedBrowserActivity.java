package toastmaster.android;

import android.app.*;
import android.webkit.*;
import android.widget.*;
import android.os.*;

import org.xwalk.core.XWalkView;

public class EmbeddedBrowserActivity extends Activity {
	private static final boolean DEBUG = BuildConfig.DEBUG;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		XWalkView container = (XWalkView) findViewById(R.id.WebViewContainer);
//		container.getSettings().setJavaScriptEnabled(true);
		container.addJavascriptInterface(
				new JsToaster(this),
				"androidToaster");

		final String url = "https://alxndrsn.github.io/toastmaster/";
		if(DEBUG) log("Pointing browser to %s", url);
		container.load(url, null);
	}

	private void log(String message, Object...extras) {
		if(DEBUG) System.err.println(String.format(
				message, extras));
	}
}

class JsToaster {
	private final Activity context;

	public JsToaster(Activity context) { this.context = context; }

	@android.webkit.JavascriptInterface
	public void toast(String toast) {
		Toast.makeText(context, toast, Toast.LENGTH_SHORT).show();
	}
}
