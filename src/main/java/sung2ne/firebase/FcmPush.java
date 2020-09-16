package sung2ne.firebase;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONObject;

public class FcmPush {

    // https://firebase.google.com/docs/cloud-messaging/http-server-ref
	public static String pushFCMNotification(String apiKey, String token, JSONObject notification, JSONObject fcmData) throws Exception {
        String result = null;
        String output;
        String fcmUrl = "https://fcm.googleapis.com/fcm/send";

        URL url = new URL(fcmUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setUseCaches(false);
        conn.setDoInput(true);
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "key=" + apiKey);
        conn.setRequestProperty("Content-Type", "application/json");

        JSONObject fcm = new JSONObject();
        JSONObject background = new JSONObject();
        notification.put("sound", "default");
        notification.put("click_action", "FCM_PLUGIN_ACTIVITY");
        notification.put("icon", "fcm_push_icon");
        background.put("title", notification.get("title"));
        background.put("body", notification.get("body"));
        if (fcmData != null) background.put("data", fcmData);
        fcm.put("data", background);
        fcm.put("to", token.trim()); // deviceID

        try(OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream())){
            wr.write(fcm.toString());
            wr.flush();
        }catch(Exception e){
           e.printStackTrace();
           result = "error";
        }

        if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
            throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
        }

        BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));

        //System.out.println("Output from Server .... \n");
        while ((output = br.readLine()) != null) {
            //System.out.println(output);
            result = output;
        }

        conn.disconnect();
        return result;
    }
}
