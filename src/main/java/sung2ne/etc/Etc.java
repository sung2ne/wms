package sung2ne.etc;

import javax.servlet.http.HttpServletRequest;
import java.text.NumberFormat;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Etc {

	/*
	 * 클라이언트 IP
	 * @param request HttpServletRequest
	 * @return ip 클라이언트 IP
	 */
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-RealIP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
	}

	public static String rndString(int cnt) {
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();

		for (int i = 0; i < cnt; i++) {
		    int rIndex = rnd.nextInt(3);
		    switch (rIndex) {
		    case 0:
		        // a-z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
		        break;
		    case 1:
		        // A-Z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
		        break;
		    case 2:
		        // 0-9
		        temp.append((rnd.nextInt(10)));
		        break;
		    }
		}

		String rndString = temp.toString();
		return rndString;
	}

	// html 태그 제거
	public static String stripHtmlTags(String content) {
		Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>",Pattern.DOTALL);
        Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>",Pattern.DOTALL);
        Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
        //Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
        Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
        Pattern WHITESPACE = Pattern.compile("\\s\\s+");

        Matcher m;

        m = SCRIPTS.matcher(content);
        content = m.replaceAll("");
        m = STYLE.matcher(content);
        content = m.replaceAll("");
        m = TAGS.matcher(content);
        content = m.replaceAll("");
        m = ENTITY_REFS.matcher(content);
        content = m.replaceAll("");
        m = WHITESPACE.matcher(content);
        content = m.replaceAll(" ");

        return content;
	}

	// String 을 byte 길이 만큼 자르기.
	public static String subStringBytes(String str, int byteLength) {
	    int retLength = 0;
	    int tempSize = 0;
	    int asc;
	    if(str == null || "".equals(str) || "null".equals(str)){
	        str = "";
	    }

	    int length = str.length();

	    for (int i = 1; i <= length; i++) {
	        asc = (int) str.charAt(i - 1);
	        if (asc > 127) {
	            if (byteLength >= tempSize + 2) {
	                tempSize += 2;
	                retLength++;
	            } else {
	                return str.substring(0, retLength);
	            }
	        } else {
	            if (byteLength > tempSize) {
	                tempSize++;
	                retLength++;
	            }
	        }
	    }

	    return str.substring(0, retLength);
	}

	//허용한 HTML 태그를 제외하고 <,>를 &lt;,&gt;로 치환
	public static String replaceHTMLSpecialChars(String str, String strAllowTag) {
		String pattern = "<(/?)(?!/####)([^<|>]+)?>";
		String substitute = "&lt;$1$2&gt;";
		String[] allowTags = strAllowTag.split(",");
		StringBuffer buffer = new StringBuffer();

	    for (int i = 0; i < allowTags.length; i++) {
	    	buffer.append("|" + allowTags[i].trim() + "(?!w)");
	    }

	    pattern = pattern.replaceAll("####", buffer.toString());
	    String returnstr = str.replaceAll(pattern, substitute);
	    return returnstr;
	}

	// <br> 태그 허용
	public static String allowBR(String contents) {
		return contents.replaceAll("\r\n", "<br>");
	}

	// HTML 태그 모두 제거
	public static String removeTag(String html) {
		return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}

	/**
     * 3자리 마다 comma 로 구분지어 주는 문자열 생성
     * @param val
     * @return
     */
	public static String formatSeperatedByComma(long val) {
        NumberFormat format = NumberFormat.getNumberInstance();
        return format.format(val);
    }

	/**
     * 3자리 마다 comma 로 구분지어 주는 문자열 생성
     * @param val
     * @return
     */
	public static String formatSeperatedByComma(String val) {
		long longVal = Long.parseLong(val);
        NumberFormat format = NumberFormat.getNumberInstance();
        return format.format(longVal);
    }
}
