package wms.persistence.user;

import wms.domain.UserVo;

import java.util.List;


public interface UserDAO {
	UserVo create(UserVo vo) throws Exception;

	UserVo read(UserVo vo) throws Exception;

	UserVo update(UserVo vo) throws Exception;

	List<UserVo> all(UserVo vo) throws Exception;
}
