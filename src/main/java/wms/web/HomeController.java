package wms.web;

import wms.service.user.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;

@Controller
public class HomeController {

	@Inject
	private UserService userService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	// home
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView root(ModelAndView mav) {
		mav.setViewName("redirect:/auth/login");
		return mav;
	}

	// dashboard
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public ModelAndView dashboard(ModelAndView mav) {
		mav.setViewName("home/dashboard");
		return mav;
	}

	// default
	@RequestMapping(value = "/page/default", method = RequestMethod.GET)
	public ModelAndView commingsoon(ModelAndView mav) {
		mav.setViewName("page/default");
		return mav;
	}

	/*
	// initDB
	@RequestMapping(value = "/initdb", method = RequestMethod.GET)
	public ModelAndView initdb(ModelAndView mav, HttpServletRequest request) throws Exception {
		if (getClientIP(request).equals("127.0.0.1") || getClientIP(request).equals("0:0:0:0:0:0:0:1")) {
			String userIdx = UUID.randomUUID().toString();

			// 대학/학부 추가
			CollegeVo collegeVo = new CollegeVo();
			collegeVo.setCollegeName("관리");
			collegeVo.setCollegePhone("02-1111-1111");
			collegeVo.setCreateUserIdx(userIdx);
			collegeVo = collegeService.create(collegeVo);

			// 학과/부서 추가
			DepartmentVo departmentVo = new DepartmentVo();
			departmentVo.setCollegeIdx(collegeVo.getCollegeIdx());
			departmentVo.setDepartmentName("관리");
			departmentVo.setDepartmentPhone("02-1111-1112");
			departmentVo.setCreateUserIdx(userIdx);
			departmentVo = departmentService.create(departmentVo);

			// 관리자
			UserVo userVo = new UserVo();
			userVo.setUserIdx(userIdx);
			userVo.setCollegeIdx(collegeVo.getCollegeIdx());
			userVo.setDepartmentIdx(departmentVo.getDepartmentIdx());
			userVo.setUserId("admin");
			String hashedPassword = BCrypt.hashpw("qwer1234", BCrypt.gensalt(12));
			userVo.setPassword(hashedPassword);
			userVo.setUserName("관리자");
			userVo.setGrade("A");
			userVo.setUserPhone("010-1111-1111");
			userVo.setEmail("admin@test.com");
			userVo.setCreateUserIdx(userIdx);
			userVo = userService.create(userVo);

			mav.setViewName("page/default");
		} else {
			mav.setViewName("page/error404");
		}

		return mav;
	}
	*/

}
