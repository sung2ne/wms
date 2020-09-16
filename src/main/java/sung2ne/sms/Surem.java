package sung2ne.sms;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class Surem {

	// 슈어엠 결과 코드 및 메시지
	public static String suremResult(String suremStatus) {
		String resultMessage = null;

		switch (suremStatus) {
			case "O":
				resultMessage = "전송성공";
				break;
			case "-1":
				resultMessage = "접속실패 (socket에러 or connect 에러)";
				break;
			case "-2":
				resultMessage = "전송에러 (socket에러)";
				break;
			case "-3":
				resultMessage = "수신에러 (socket에러)";
				break;
			case "C":
				resultMessage = "고객사 사용자 ID 이상";
				break;
			case "I":
				resultMessage = "미등록 회원 또는 기본료 미납";
				break;
			case "M":
				resultMessage = "호출할 메시지의 내용이 없음";
				break;
			case "N":
				resultMessage = "국번 or 전화번호 뒤 4자리 이상";
				break;
			case "P":
				resultMessage = "이통사 번호 이상";
				break;
			case "R":
				resultMessage = "'700', '800' 금지업체";
				break;
			case "T":
				resultMessage = "예약일자 이상";
				break;
			case "U":
				resultMessage = "호출 URL이 없음";
				break;
			case "c":
				resultMessage = "기타 오류";
				break;
			case ")":
				resultMessage = "예약취소 시 동일 데이터 찾을 수 없음";
				break;
			case "Z":
				resultMessage = "수신거부번호 전송시도";
				break;
			case "H":
				resultMessage = "I.P Firewall 등록 고객사 중 미등록 아이피";
				break;
			case "X":
				resultMessage = "기타에러";
				break;
		}

		return resultMessage;
	}

	@SuppressWarnings("unchecked")
	public static String biztalk(String usercode, String deptcode, String profileKey, String from, String to, String text, String templateCode) throws Exception {
		URL url = new URL("https://api.surem.com/alimtalk/v1/json");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setUseCaches(false);
        conn.setDoInput(true);
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");

        JSONObject json = new JSONObject();
		json.put("usercode", usercode);
		json.put("deptcode", deptcode);
		json.put("yellowid_key", profileKey);

		JSONArray messages = new JSONArray();
        JSONObject message = new JSONObject();
        message.put("message_id", "1000000");
        message.put("to", to);
        message.put("text", text);
        message.put("from", from);
        message.put("template_code", templateCode);
        message.put("re_send", "Y");
        message.put("text", text);
        messages.add(message);

        json.put("messages", messages);

        try(OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream())){
            wr.write(json.toString());
            wr.flush();
        }catch(Exception e){
        }

        if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
            throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
        }

        BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));

        String result = null;
        String output;
        System.out.println("Output from Server .... \n");
        while ((output = br.readLine()) != null) {
            System.out.println(output);
            result = output;
        }

        conn.disconnect();

		return result;
    }
}
