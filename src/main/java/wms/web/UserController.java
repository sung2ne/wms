package wms.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import wms.domain.DepartmentVo;
import wms.domain.UserVo;
import wms.service.department.DepartmentService;
import wms.service.user.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService userService;

	@Inject
	private DepartmentService departmentService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	// screen
	@RequestMapping(value = {"","/"}, method = RequestMethod.GET)
	public ModelAndView screenGET(ModelAndView mav) throws Exception {
		// 부서 목록
		DepartmentVo departmentVo = new DepartmentVo();
		mav.addObject("departmentList", departmentService.all(departmentVo));
		
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
		userVo.setDeleteYN("Y");
		userVo = userService.update(userVo);
		jsonData.put("result", "ok");
		return jsonData;
	}

}
