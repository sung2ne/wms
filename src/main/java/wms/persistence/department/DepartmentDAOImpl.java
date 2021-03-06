package wms.persistence.department;

import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import wms.domain.DepartmentVo;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import sung2ne.datatime.DateTimeUtil;


@Repository
public class DepartmentDAOImpl implements DepartmentDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "department";

	@Override
	public DepartmentVo create(DepartmentVo vo) throws Exception {
		// 등록 일시, 등록한 사용자 ID, 삭제안함
		vo.setDeleteYN("N");
		vo.setCreateDateTime(DateTimeUtil.saveDateTime());
		if (vo.getCreateUserIdx() == null) {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			vo.setCreateUserIdx(request.getSession().getAttribute("userIdx").toString());
		}

		// IDX
		if (vo.getDepartmentIdx() == null) {
			String uuid = UUID.randomUUID().toString();
			vo.setDepartmentIdx(uuid);
		}

		// 저장
		session.insert(namespace + ".create", vo);

		// 정보
		DepartmentVo newVo = new DepartmentVo();
		newVo.setDepartmentIdx(vo.getDepartmentIdx());
		newVo = session.selectOne(namespace + ".read", newVo);
		return newVo;
	}

	@Override
	public DepartmentVo read(DepartmentVo vo) throws Exception {
		return session.selectOne(namespace + ".read", vo);
	}

	@Override
	public DepartmentVo update(DepartmentVo vo) throws Exception {
		// 삭제
		if (vo.getDeleteYN() != null && vo.getDeleteYN().equals("Y")) {
			// 삭제 일시, 삭제한 사용자 ID
			vo.setDeleteDateTime(DateTimeUtil.saveDateTime());
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			vo.setDeleteUserIdx(request.getSession().getAttribute("userIdx").toString());
		}
		// 수정
		else {
			// 수정 일시, 수정한 사용자 ID
			vo.setUpdateDateTime(DateTimeUtil.saveDateTime());
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			vo.setUpdateUserIdx(request.getSession().getAttribute("userIdx").toString());
		}

		// 수정
		session.update(namespace + ".update", vo);

		// 정보
		DepartmentVo newVo = new DepartmentVo();
		newVo.setDepartmentIdx(vo.getDepartmentIdx());
		newVo = session.selectOne(namespace + ".read", newVo);
		return newVo;
	}

	@Override
	public List<DepartmentVo> all(DepartmentVo vo) throws Exception {
		return session.selectList(namespace + ".all", vo);
	}
}
