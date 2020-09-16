package sung2ne.location;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import com.google.code.geocoder.Geocoder;
import com.google.code.geocoder.GeocoderRequestBuilder;
import com.google.code.geocoder.model.GeocodeResponse;
import com.google.code.geocoder.model.GeocoderRequest;
import com.google.code.geocoder.model.GeocoderResult;
import com.google.code.geocoder.model.GeocoderStatus;
import com.google.code.geocoder.model.LatLng;
import com.google.gson.Gson;
import sung2ne.etc.NaverData;

public class GeoUtil {

	/*
	 * 위도, 경도 변환
	 * @param location 주소
	 * @return coords 위도,경도
	 */
	public static String[] getPointFromGeoCoder(String addr) {
		if (addr == null)
		return null;

		Geocoder geocoder = new Geocoder();
		// setAddress : 변환하려는 주소 (경기도 성남시 분당구 등)
		// setLanguate : 인코딩 설정
		GeocoderRequest geocoderRequest = new GeocoderRequestBuilder().setAddress(addr).setLanguage("ko").getGeocoderRequest();
		GeocodeResponse geocoderResponse;

		try {
			geocoderResponse = geocoder.geocode(geocoderRequest);
			if (geocoderResponse.getStatus() == GeocoderStatus.OK & !geocoderResponse.getResults().isEmpty()) {
				GeocoderResult geocoderResult=geocoderResponse.getResults().iterator().next();
				LatLng latitudeLongitude = geocoderResult.getGeometry().getLocation();

				String[] coords = new String[2];
				coords[0] = latitudeLongitude.getLat().toString();
				coords[1] = latitudeLongitude.getLng().toString();
				return coords;
			}
		} catch (IOException ex) {
			//ex.printStackTrace();
			return null;
		}

		return null;
	}

	/*
	 * 네이버 주소 API를 이용한 위도, 경도 변환
	 * @param location 주소
	 * @return coords 위도,경도
	 */
	public static String[] getPointFromNaverMap(String addr) {
	    String json = null;
	    String clientId = "gaUKTXRyNSilwhbmRPc_";	// Client ID
	    String clientSecret = "B6ZOOyyJRt";			// Client Secret

	    try {
	        addr = URLEncoder.encode(addr, "UTF-8");
	        String apiURL = "https://openapi.naver.com/v1/map/geocode?query=" + addr; // json
	        URL url = new URL(apiURL);
	        HttpURLConnection con = (HttpURLConnection) url.openConnection();
	        con.setRequestMethod("GET");
	        con.setRequestProperty("X-Naver-Client-Id", clientId);
	        con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        if (responseCode == 200) { // 정상 호출
	            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        } else { // 에러 발생
	            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	        }
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = br.readLine()) != null) {
	            response.append(inputLine);
	        }
	        br.close();
	        json = response.toString();
	    } catch (Exception e) {
	        //e.printStackTrace();
	    	return null;
	    }

	    Gson gson = new Gson();
	    NaverData data = new NaverData();

	    try {
	        data = gson.fromJson(json, NaverData.class);
	    } catch (Exception e) {
	        //e.printStackTrace();
	    	return null;
	    }

	    if (data.result != null) {
	    	String[] coords = new String[2];
	    	coords[0] = String.valueOf(data.result.items.get(0).point.y);
			coords[1] = String.valueOf(data.result.items.get(0).point.x);
			return coords;
	    }

		return null;
	}
}
