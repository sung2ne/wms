package wms.persistence.department;

import wms.domain.DepartmentVo;

import java.util.List;


public interface DepartmentDAO {
	DepartmentVo create(DepartmentVo vo) throws Exception;

	DepartmentVo read(DepartmentVo vo) throws Exception;

	DepartmentVo update(DepartmentVo vo) throws Exception;

	List<DepartmentVo> all(DepartmentVo vo) throws Exception;
}
