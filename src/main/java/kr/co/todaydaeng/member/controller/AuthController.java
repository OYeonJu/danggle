package kr.co.todaydaeng.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.todaydaeng.member.model.service.AuthService;
import kr.co.todaydaeng.member.model.vo.Member;

@Controller
public class AuthController {

	@Autowired
	private AuthService authService;

	@RequestMapping(value = "/login/kakao")
	public String login(@RequestParam(value = "code", required = false) String code,
			HttpServletRequest request, Model model) throws Exception {
		// 사용자가 카카오 로그인
		// 카톡에 연결된 카카오 계정의 자격정보를 통해 사용자를 인식
		// 사용자가 한 번도 동의하지 않은 서비스라면 Oauth창을 띄움
		// 항목 동의 후 로그인 요청
		// redriect_uri로 1회용 Authorization code 같이 전달
		System.out.println("1. 인가코드 : " + code);

		// Authorization code로 액세스 토큰 요청
		String access_Token = authService.getAccessToken(code);

		// 발급받은 액세스 토큰으로 사용자 정보 요청
		HashMap<String, Object> userInfo = authService.getUserInfo(access_Token);
		userInfo.put("authProvider", "kakao");
		String socialId = (String)userInfo.get("socialId"); //식별자
		
		// 카카오 고유 id값으로 해당 사용자가 이미 DB에 있는지 조회
		Member m = authService.selectSocialId(socialId);
		if(m != null) {
			authService.updateLoginDate(m);
			switch (m.getMemberStatus()) {
			case '0':
				HttpSession session = request.getSession();
				session.setAttribute("userInfo", userInfo);
				session.setAttribute("member", m);
				return "redirect:/";
			case '1':
				model.addAttribute("member", m);
				return "dormantMember";
			default:
				return "common/errorPage";
			}
		// 없다면 추가 입력 사항 페이지로 이동하여 DB에 저장
		}else {
			model.addAttribute("userInfo",userInfo);
			return "socialJoin";
		}
	}
	
	@RequestMapping(value = "/login/naver")
	public String naverLogin(@RequestParam(value = "code", required = false) String code,
			HttpServletRequest request, Model model) throws Exception {
		// 인가 코드 확인
		System.out.println("1. 인가코드 : " + code);
		
		// 인가 코드로 액세스 토큰 요청
		String access_Token = authService.getNaverAccessToken(code);
		
		// 액세스 토큰으로 사용자 정보 요청
		HashMap<String, Object> userInfo = authService.getNaverUserInfo(access_Token);
		userInfo.put("authProvider", "naver");
		String socialId = (String)userInfo.get("socialId");
		
		//고유 id값으로 기존 회원인지 확인
		Member m = authService.selectSocialId(socialId);
		if(m != null) {
			authService.updateLoginDate(m);
			switch (m.getMemberStatus()) {
			case '0':
				HttpSession session = request.getSession();
				session.setAttribute("userInfo", userInfo);
				session.setAttribute("member", m);
				return "redirect:/";
			case '1':
				model.addAttribute("member", m);
				return "dormantMember";
			default:
				return "common/errorPage";
			}
		}else {
			model.addAttribute("userInfo",userInfo);
			return "socialJoin";
		}
	}
	
	
	@RequestMapping(value = "/socialJoin.do")
	public String kakaoJoin(Member member,HttpServletRequest request) {
		int result = authService.socialJoin(member);
		if(result>0) {
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			return "redirect:/";
		}else {
			return "common/errorPage";
		}
	}
}
