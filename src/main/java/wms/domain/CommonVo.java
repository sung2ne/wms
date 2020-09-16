package wms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CommonVo {
	// 구분자(PK)
	private String userIdx;				// 사용자 구분자
	private String departmentIdx;		// 부서 구분자

	// 등록, 수정, 삭제
	private String deleteYN;			// 삭제 여부(Y:삭제, N:삭제안함)
	private String createUserIdx;		// 등록한 사용자 ID
	private String updateUserIdx;		// 수정한 사용자 ID
	private String deleteUserIdx;		// 삭제한 사용자 ID
	private String createDateTime;		// 등록 일시
	private String updateDateTime;		// 수정 일시
	private String deleteDateTime;		// 삭제 일시
	private String createUserName;		// 등록한 사용자 이름
	private String updateUserName;		// 수정한 사용자 이름
	private String deleteUserName;		// 삭제한 사용자 이름
	
	// 부서
	private String departmentName;	// 부서이름
}
