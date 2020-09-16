package wms.web;

import wms.domain.UserVo;
import wms.service.college.CollegeService;
import wms.service.department.DepartmentService;
import wms.service.user.UserService;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService userService;

	@Inject
	private DepartmentService departmentService;

	@Inject
	private CollegeService collegeService;

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	// screen
	@RequestMapping(value = {"","/"}, method = RequestMethod.GET)
	public ModelAndView screenGET(ModelAndView mav) throws Exception {

		/*
		// 관리자 비밀번호 변경 - 응급상황에 사용
		UserVo userVo = new UserVo();
		String hashedPassword = BCrypt.hashpw("qwer1234", BCrypt.gensalt(12));
		userVo.setPassword(hashedPassword);
		userVo.setEmployeeNumber("admin");
		userVo = userService.update(userVo);
		*/

		UserVo userVo = new UserVo();
		List<UserVo> userVoList = userService.all(userVo);

// 사용자가 없으면 사용자 추가
		if (userVoList.size() == 0) {
			String uuidUser = UUID.randomUUID().toString();
			String hashedPassword = BCrypt.hashpw("qwer1234", BCrypt.gensalt(12));

			// 사용자 추가
			userVo.setIdx(uuidUser);
			userVo.setUserId("2019A999");
			userVo.setPassword(hashedPassword);
			userVo.setName("홍길동");
			userVo.setPhone("070-4388-9546");
			userVo.setRankIdx(rankIdx);
			userVo.setDepartmentIdx(departmentIdx);
			userVo.setDeleted("삭제안함");
			userVo.setCreatedBy(uuidUser);
			userVo.setUpdatedBy(uuidUser);
			String idx = userService.create(userVo);
		}

		mav.setViewName("user/screen");
		return mav;
	}

	// 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> listGET(UserVo userVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		List<UserVo> userVoList = userService.all(userVo);
		jsonData.put("data", userVoList);
		return jsonData;
	}

	// 보기
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> viewGET(UserVo userVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		userVo = userService.read(userVo);
		jsonData.put("data", userVo);
		return jsonData;
	}

	// 등록
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> createPOST(UserVo userVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();

		// 비밀번호 암호화
		String hashedPassword = BCrypt.hashpw(userVo.getPassword(), BCrypt.gensalt(12));
		userVo.setPassword(hashedPassword);

		userVo = userService.create(userVo);
		jsonData.put("data", userVo);
		return jsonData;
	}

	// 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> updatePOST(UserVo userVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();

		// 비밀번호 암호화
		if (userVo.getPassword() != null) {
			String hashedPassword = BCrypt.hashpw(userVo.getPassword(), BCrypt.gensalt(12));
			userVo.setPassword(hashedPassword);
		}

		userVo = userService.update(userVo);
		jsonData.put("data", userVo);
		return jsonData;
	}

	// 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> deletePOST(UserVo userVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		userVo.setUseYN("N");
		userVo.setDeleteYN("Y");
		userVo = userService.update(userVo);
		jsonData.put("result", "ok");
		return jsonData;
	}

}
