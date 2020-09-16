package wms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserVo extends CommonVo {
	// 사용자 정보
	private String employeeNumber;	// 사원번호
	private String password;		// 비밀번호
	private String name;			// 이름
	private String phone;			// 전화번호
	private String mobile;			// 핸드폰번호
	private String email;			// 이메일
	private String userType;		// 권한(최고관리자, 업체관리자, 업체사용자)
	private String status;			// 재직, 휴직, 퇴사

	// 추가
	private String newPassword;		// 새로운 비밀번호(비밀번호 변경에 사용)
}
