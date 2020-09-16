package sung2ne.etc;

import java.io.UnsupportedEncodingException;

// 인코딩 변경
public class EncodingUtil {

	/*
	 * utf-8 -> euc-kr
	 * @param utf8   : utf-8 인코딩된 문자열
	 * @return eucKr : euc-kr 인코딩된 문자열
	 */
	public static String utf8ToEucKR(String utf8) {
		String eucKr = "";
		try {
			eucKr = new String(utf8.getBytes("utf-8"), "euc-kr");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return eucKr;
	}

	/*
	 * euc-kr -> utf-8
	 * @param eucKr : euc-kr 인코딩된 문자열
	 * @return utf8 : utf-8 인코딩된 문자열
	 */
	public static String euckrToUtf8(String eucKr) {
		String utf8 = "";
		try {
			utf8 = new String(eucKr.getBytes("euc-kr"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return utf8;
	}
}
