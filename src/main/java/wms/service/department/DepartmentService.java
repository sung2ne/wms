package wms.service.department;

import wms.domain.DepartmentVo;

import java.util.List;


public interface DepartmentService {
	DepartmentVo create(DepartmentVo vo) throws Exception;

	DepartmentVo read(DepartmentVo vo) throws Exception;

	DepartmentVo update(DepartmentVo vo) throws Exception;

	List<DepartmentVo> all(DepartmentVo vo) throws Exception;
}
