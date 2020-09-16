package sung2ne.etc;

import sung2ne.datatime.DateTimeUtil;

import javax.servlet.http.HttpServletRequest;
import java.text.NumberFormat;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SerialNumber {

	// 순번 만들기 - 시리얼넘버(4자리)
	public static String makeSN4(String lastSN) {
		String newSN = null;
		int sn = Integer.parseInt(lastSN);
		sn = sn + 1;
		if (sn < 10) {
			newSN = "000" + Integer.toString(sn);
		} else if (sn < 100) {
			newSN = "00" + Integer.toString(sn);
		} else if (sn < 1000) {
			newSN = "0" + Integer.toString(sn);
		} else {
			newSN = Integer.toString(sn);
		}
		return newSN;
	}

	// 순번 만들기 - 년월일 + 시리얼넘버(12자리)
	public static String makeSN12(String lastSN) {
		String today = DateTimeUtil.saveDate();
		String newSN = null;
		int sn = Integer.parseInt(lastSN.substring(8));
		sn = sn + 1;
		if (sn < 10) {
			newSN = today + "000" + Integer.toString(sn);
		} else if (sn < 100) {
			newSN = today + "00" + Integer.toString(sn);
		} else if (sn < 1000) {
			newSN = today + "0" + Integer.toString(sn);
		} else {
			newSN = today + Integer.toString(sn);
		}
		return newSN;
	}

}
