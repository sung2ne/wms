package wms.web;

import wms.domain.UserVo;
import wms.service.user.UserService;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import sung2ne.etc.Etc;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class AuthController {

	@Inject
	private UserService userService;

	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

	// 세션 검사
	public static boolean isValidSession(HttpServletRequest request) {
		if (request.getSession().getAttribute("userId") != null
				&& request.getSession().getAttribute("userIdx") != null
				&& request.getSession().getAttribute("userName") != null
				&& request.getSession().getAttribute("grade") != null)
		{
			return true;
		} else {
			return false;
		}
	}

	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginGET(ModelAndView mav, HttpServletRequest request) {
		// 세션이 존재하는 경우
		if( isValidSession(request) ){
			mav.setViewName("redirect:/page/default");
		} else {
			mav.setViewName("auth/login");
		}

		return mav;
	}

	// 로그인 처리
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView loginPOST(ModelAndView mav, UserVo userVo, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		// DB에서 로그인 정보 조회
		UserVo existUserVo = userService.read(userVo);

		// 사용자 있음
		if (existUserVo != null) {

			// 비밀번호 틀림
			if (!BCrypt.checkpw(userVo.getPassword(), existUserVo.getPassword())) {
				rttr.addFlashAttribute("userId", existUserVo.getUserId());
				rttr.addFlashAttribute("focus", "password");
				rttr.addFlashAttribute("error", "비밀번호가 틀렸습니다.");
				mav.setViewName("redirect:/auth/login");
			}

			// 로그인 성공
			else {
				HttpSession session = request.getSession(true);

				// 클라이언트 IP, 로그인 시간 업데이트
				String ip = Etc.getClientIP(request);
				UserVo loginUserVo = new UserVo();
				loginUserVo.setLoginIp(ip);
				loginUserVo.setUserIdx(existUserVo.getUserIdx());
				loginUserVo = userService.update(loginUserVo);

				// 사용자 정보
				session.setAttribute("userName", loginUserVo.getUserName());
				session.setAttribute("grade", loginUserVo.getGrade());
				session.setAttribute("userId", loginUserVo.getUserId());
				session.setAttribute("userIdx", loginUserVo.getUserIdx());

				// 로그인 후 이동하는 페이지
				mav.setViewName("redirect:/college");
			}
		}

		// 사용자 없음
		else {
			rttr.addFlashAttribute("focus", "userId");
			rttr.addFlashAttribute("error", "사용자가 존재하지 않습니다.");
			mav.setViewName("redirect:/auth/login");
		}

		return mav;
	}

	// 로그아웃 처리
	@RequestMapping(value = { "/logout" }, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView logout(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		// 세션 삭제
		HttpSession session = request.getSession(true);
		session.invalidate();

		mav.setViewName("redirect:/auth/login");
		return mav;
	}

}
