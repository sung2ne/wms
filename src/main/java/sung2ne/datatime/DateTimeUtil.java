package sung2ne.datatime;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import org.apache.commons.lang.time.DateUtils;
import org.json.simple.parser.ParseException;

public class DateTimeUtil {

	// save_date (yyyyMMdd)
	public static String saveDate() {
		SimpleDateFormat format = new SimpleDateFormat ("yyyyMMdd");
		Date time = new Date();
		return format.format(time);
	}

	// save_time (HHmmss)
	public static String saveTime() {
		SimpleDateFormat format = new SimpleDateFormat ("HHmmss");
		Date time = new Date();
		return format.format(time);
	}

	// save_date_time (yyyyMMddHHmmss)
	public static String saveDateTime() {
		SimpleDateFormat format = new SimpleDateFormat ("yyyyMMddHHmmss");
		Date time = new Date();
		return format.format(time);
	}

	public static Date getDate(int year, int month, boolean truncate) {
    	Calendar cal = Calendar.getInstance();
    	cal.set(Calendar.YEAR, year);
    	cal.set(Calendar.MONTH, month);

    	if( truncate ) {
    		cal = DateUtils.truncate(cal, Calendar.MONTH);
    	}

    	return cal.getTime();
    }

    public static Date getDate(int year, int month) {
    	return getDate(year, month, false);
    }

    /**
	 * 1년 후의 날을 구한다.
	 */
	public static Date getNextYear(Date date) {
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.add(Calendar.YEAR, 1);

    	return cal.getTime();
    }

	/**
	 * 1년 전의 날을 구한다.
	 */
    public static Date getPreviousYear(Date date) {
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.add(Calendar.YEAR, -1);

    	return cal.getTime();
    }

    /**
	 * 한달 후의 날을 구한다.
	 */
    public static Date getNextMonth(Date date) {
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.add(Calendar.MONTH, 1);

    	return cal.getTime();
    }

    /**
	 * 한달 전의 날을 구한다.
	 */
	public static Date getPreviousMonth(Date date) {
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.add(Calendar.MONTH, -1);

    	return cal.getTime();
    }

	/**
	 * 7일 후의 날을 구한다.
	 */
	public static Date getNextWeek(Date date) {
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.add(Calendar.DATE, 7);

    	return cal.getTime();
    }

	/**
	 * 7일전의 날을 구한다.
	 */
	public static Date getPreviousWeek(Date date) {
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.add(Calendar.DATE, -7);

    	return cal.getTime();
    }

	/**
	 * 다음 날을 구한다.
	 */
	public static Date getNextDate(Date date) {
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.add(Calendar.DATE, 1);

    	return cal.getTime();
    }

	/**
	 * 하루 전 날을 구한다.
	 */
	public static Date getPreviousDate(Date date) {
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.add(Calendar.DATE, -1);

    	return cal.getTime();
    }

	/**
	 * 해당 주의 첫번째 날을 구한다.
	 */
	public static Date getFirstDateOfWeek(Date date) {
		Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    	cal.add(Calendar.DATE, (dayOfWeek-1)*-1);

    	return cal.getTime();
	}

	/**
	 * 해당 주의 마지막 날을 구한다.
	 */
	public static Date getLastDateOfWeek(Date date) {
		Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    	cal.add(Calendar.DATE, 7-dayOfWeek);

    	return cal.getTime();
	}

	/**
	 * 해당 연도 달의 첫번째 날을 구한다.
	 */
	public static Date getFirstDateOfMonth(Date date) {
		Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.getActualMinimum(Calendar.DAY_OF_MONTH));
		return cal.getTime();
	}

	/**
	 * 해당 연도 달의 첫번째 날을 구한다.
	 */
	public static Date getFirstDateOfMonth(int year, int month) {
		Calendar cal = Calendar.getInstance();

		cal.set(Calendar.YEAR, year);
    	cal.set(Calendar.MONTH, month-1);
    	cal.set(Calendar.DATE, cal.getActualMinimum(Calendar.DAY_OF_MONTH));

		return minimized(cal.getTime());
	}

	/**
	 * 해당 연도 달의 마지막 날을 구한다.
	 */
	public static Date getLastDateOfMonth(Date date) {
		Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		return cal.getTime();
	}

	/**
	 * 해당 연도 달의 마지막 날을 구한다.
	 */
	public static Date getLastDateOfMonth(int year, int month) {
		Calendar cal = Calendar.getInstance();

		cal.set(Calendar.YEAR, year);
    	cal.set(Calendar.MONTH, month-1);
    	cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));

		return maximize(cal.getTime());
	}

	/**
	 * 시,분,초를 모두 최소치로 초기화한다.
	 */
	public static Date minimized(Date date) {
		return DateUtils.truncate(date, Calendar.DATE);
	}

	/**
	 * 시,분,초를 모두 최대치로 초기화한다.
	 */
	public static Date maximize(Date date) {
		Calendar cal = Calendar.getInstance();
    	cal.setTime(date);

    	cal.set(Calendar.HOUR_OF_DAY, 23);
    	cal.set(Calendar.MINUTE, 59);
    	cal.set(Calendar.SECOND, 59);

		return cal.getTime();
	}

	/*
	 *  DateTime 구하는 함수
	 *  @return resultsArray 결과(JSONArray)
	 */
	public static Date dateTime() throws ParseException, java.text.ParseException {
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss", Locale.KOREA );
		Date currentTime = new Date();
		String dateTime = formatter.format ( currentTime );
		Date returnDateTime = formatter.parse(dateTime);
		return returnDateTime;
	}

	/*
	 * timestamp 구하는 함수
	 *  DateTime
	 *  @return resultsArray 결과(JSONArray)
	 */
	public static String toTimestamp(Date dateTime) throws ParseException, java.text.ParseException {
		java.sql.Timestamp sqlDate = new java.sql.Timestamp(dateTime.getTime());
		Calendar cal = Calendar.getInstance();
		cal.setTime(sqlDate);
		long millis = cal.getTimeInMillis();
		return String.valueOf(millis/1000);
	}


}
