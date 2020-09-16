package wms.service.department;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import wms.domain.DepartmentVo;
import wms.persistence.department.DepartmentDAO;


@Service
public class DepartmentServiceImpl implements DepartmentService {

	@Inject
	private DepartmentDAO dao;

	@Override
	public DepartmentVo create(DepartmentVo vo) throws Exception {
		return dao.create(vo);
	}

	@Override
	public DepartmentVo read(DepartmentVo vo) throws Exception {
		return dao.read(vo);
	}

	@Override
	public DepartmentVo update(DepartmentVo vo) throws Exception {
		return dao.update(vo);
	}

	@Override
	public List<DepartmentVo> all(DepartmentVo vo) throws Exception {
		return dao.all(vo);
	}
}
