package toastmaster.cordova;

import android.widget.*;

import org.apache.cordova.*;
import org.json.*;

public class ToastPlugin extends CordovaPlugin {
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if(action.equals("toast")) {
			toast(args.getString(0));
		} else {
			callbackContext.error("Unrecognised action: " + action);
			return false;
		}
		callbackContext.success();
		return true;
	}

	private void toast(String toast) {
		Toast.makeText(MainActivity.CONTEXT, toast, Toast.LENGTH_SHORT).show();
	}
}

