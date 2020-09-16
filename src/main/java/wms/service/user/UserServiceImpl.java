package wms.service.user;

import wms.domain.UserVo;
import wms.persistence.user.UserDAO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;


@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;

	@Override
	public UserVo create(UserVo vo) throws Exception {
		return dao.create(vo);
	}

	@Override
	public UserVo read(UserVo vo) throws Exception {
		return dao.read(vo);
	}

	@Override
	public UserVo update(UserVo vo) throws Exception {
		return dao.update(vo);
	}

	@Override
	public List<UserVo> all(UserVo vo) throws Exception {
		return dao.all(vo);
	}
}
