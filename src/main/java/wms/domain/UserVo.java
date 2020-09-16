package wms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserVo extends CommonVo {
	// 사용자 정보
	private String userId;			// 사용자 ID
	private String password;		// 비밀번호
	private String userName;		// 이름
	private String phone;			// 전화번호
	private String mobile;			// 핸드폰번호
	private String email;			// 이메일
	private String grade;			// 사용자 권한, A:시스템관리자, CA:업체관리자, CU:업체사용자

	// 추가
	private String newPassword;		// 새로운 비밀번호(비밀번호 변경에 사용)
}
