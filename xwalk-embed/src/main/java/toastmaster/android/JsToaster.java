package toastmaster.android;

import android.app.*;
import android.widget.*;
import android.os.*;

public class JsToaster {
	private final Activity context;

	public JsToaster(Activity context) { this.context = context; }

	@android.webkit.JavascriptInterface
	@org.xwalk.core.JavascriptInterface
	public void toast(String toast) {
		Toast.makeText(context, toast, Toast.LENGTH_SHORT).show();
	}
}
