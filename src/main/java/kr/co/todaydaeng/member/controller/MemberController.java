package kr.co.todaydaeng.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.todaydaeng.member.model.service.MemberService;
import kr.co.todaydaeng.member.model.vo.EmailAuthHist;
import kr.co.todaydaeng.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService mService;
	
	@Autowired
	private ServletContext context;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value = "/member/joinMember.do", method = RequestMethod.POST)
	public String joinMember(HttpServletRequest request) throws IOException {
		// 파일이 업로드되는 경로
		String uploadPath = "/resources/upload/memberProfile/";	
		String uploadFilePath = context.getRealPath(uploadPath);
		System.out.println("파일 경로 확인 : " + uploadFilePath);
		
		// 파일 사이즈 설정 (50MB)
		int uploadFileSizeLimit = 50 * 1024 * 1024;

		// 파일 이름 인코딩 설정
		String encType = "UTF-8";

		// MultipartRequest 객체 생성
		// 필요한 정보 : request, uploadFilePath, uploadFileSizeLimit, encType,
		// DefaultFileRenamePolicy
		MultipartRequest multi = new MultipartRequest(request, uploadFilePath, uploadFileSizeLimit, encType,
				new DefaultFileRenamePolicy());

		String memberId = multi.getParameter("memberId");
		String memberPwd = multi.getParameter("memberPwd");
		String email = multi.getParameter("email");
		String nickname = multi.getParameter("nickname");
		String gender = multi.getParameter("gender");
		String birthdate = multi.getParameter("birthdate");
		String address = multi.getParameter("address");
		String addressDetail = multi.getParameter("addressDetail");

		// 첨부한 파일 이름
		String originalFileName = multi.getFilesystemName("profileFile");

		// 폴더에 저장 및 파일 이름 변경 (아이디_파일명)
		File file = new File(uploadFilePath + "\\" + originalFileName);
		file.renameTo(new File(uploadFilePath + "\\" + memberId + "_" + originalFileName));

		// DB에 insert할 이름
		String memberProfile = memberId+"_"+originalFileName;

		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberPwd(memberPwd);
		member.setEmail(email);
		member.setNickname(nickname);
		member.setGender(gender);
		member.setBirthdate(birthdate);
		member.setAddress(address);
		member.setAddressDetail(addressDetail);
		member.setMemberProfile(memberProfile);

		int result = mService.joinMember(member);
		if (result > 0) {
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			return "welcomeJoin";
		} else {
			return "joinFail";
		}
	}
	
	
	@RequestMapping(value = "/member/memberIdCheck.do")
	public void memberIdCheck(@RequestParam String memberId, HttpServletResponse response) throws IOException {
		int result = mService.memberIdCheck(memberId);
		if (result > 0)
			response.getWriter().print(true);
		else
			response.getWriter().print(false);
	}
	
	@RequestMapping(value = "/member/loginMember.do", method = RequestMethod.POST)
	public String loginMember(Member member, HttpServletRequest request, Model model) {
		Member m = mService.loginMember(member);
		if (m != null) {
			mService.updateLoginDate(m);
			switch (m.getMemberStatus()) {
			case '0':
				HttpSession session = request.getSession();
				session.setAttribute("member", m);
				return "redirect:/";
			case '1':
				model.addAttribute("member", m);
				return "dormantMember";
			default:
				model.addAttribute("msg", "아이디와 비밀번호를 재확인 해주세요.");
				model.addAttribute("location", "/resources/staticViews/member/login.jsp");
				return "common/msg";
			}
		} else {
			model.addAttribute("msg", "아이디와 비밀번호를 재확인 해주세요.");
			model.addAttribute("location", "/resources/staticViews/member/login.jsp");
			return "common/msg";
		}
	}
	
	
	@RequestMapping(value = "/findId/sendEmailIdCode.do", method = RequestMethod.POST)
	public void sendEmailCode(String email, HttpServletResponse response) throws IOException {
		Member m = mService.memberEmailCheck(email);
		if (m != null) {
			//난수 생성
			Random rd = new Random();
			String key = Integer.toString(rd.nextInt(888888) + 111111);
			
			//이메일 정보
			String setfrom = "admin@todaydaeng.co.kr";
			String tomail = email; //받는 사람 
			String title = "[오늘의 댕댕] 아이디찾기 인증번호를 알려드립니다."; 
			String content = "아이디 찾기를 위한 인증번호 입니다." + "[인증번호 : " + key + "]";
			
			//인증번호 정보 db에 저장
			EmailAuthHist emailAuthHist = new EmailAuthHist();
			emailAuthHist.setMemberNo(m.getMemberNo());
			emailAuthHist.setEmail(email);
			emailAuthHist.setRandomNo(key);
			mService.insertAuthNo(emailAuthHist);
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(tomail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}
			response.getWriter().print(true);
		} else {
			response.getWriter().print(false);
		}
	}
	
	@RequestMapping(value = "/findId/checkIdCode.do", produces = "application/text; charset=UTF-8", method = RequestMethod.POST)
	public void checkIdCode(String findIdCode, String email, HttpServletResponse response) throws IOException {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("findIdCode", findIdCode);

		// 결과
		HashMap<String, Object> result = new HashMap<String, Object>();
		result = mService.checkIdCode(map);

		String resultCode = "success";
		//인증번호 일치
		if (result != null) {
			int timegap = Integer.parseInt(String.valueOf(result.get("TIMEGAP")));
			switch (timegap) {
			case 0: // 시간 초과
				resultCode = "fail_timeover";
				result.put("resultCode", resultCode);
				response.setCharacterEncoding("UTF-8");
				new Gson().toJson(result,response.getWriter());
				break;
				 
			case 1: // 성공;
				result.put("resultCode", resultCode);
				new Gson().toJson(result, response.getWriter());
				break;
			}
		//인증번호 불일치 (row 0개)
		} else {
			resultCode = "fail_key";
			HashMap<String, Object> failResult = new HashMap<String, Object>();
			failResult.put("resultCode", resultCode);
			new Gson().toJson(failResult,response.getWriter());	 
		}
	}
	
	@RequestMapping(value = "/findPwd/sendEmailPwdCode.do", method = RequestMethod.POST)
	public void sendEmailPwdCode(String memberId,String email,HttpServletResponse response) throws IOException{
		//존재하는 회원인지부터 확인
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId",memberId);
		map.put("email",email);
		
		Member m = mService.memberIdEmailCheck(map);
		System.out.println(m);
		
		if (m != null) {
			Random rd = new Random();
			String key = Integer.toString(rd.nextInt(888888) + 111111);

			String setfrom = "admin@todaydaeng.co.kr";
			String tomail = email; // 받는 사람
			String title = "[오늘의 댕댕] 비밀번호 찾기 인증번호를 알려드립니다.";
			String content = "비밀번호 찾기를 위한 인증번호 입니다." + "[인증번호 : " + key + "]";

			EmailAuthHist emailAuthHist = new EmailAuthHist();
			emailAuthHist.setMemberNo(m.getMemberNo());
			emailAuthHist.setEmail(m.getEmail());
			emailAuthHist.setRandomNo(key);
			mService.insertAuthNo(emailAuthHist);

			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(tomail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}
			response.getWriter().print(true);
		} else {
			response.getWriter().print(false);
		}
	}
	
	@RequestMapping(value = "/findPwd/checkPwdCode.do", method = RequestMethod.POST)
	public void checkPwdCode(String memberId,String email,String findPwdCode,HttpServletResponse response) throws IOException {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("email", email);
		map.put("findPwdCode", findPwdCode);
		
		String result = mService.checkPwdCode(map);
		if(result != null) {
			response.getWriter().print(result);
		//인증번호 오입력
		}else {
			response.getWriter().print("null");
		}
	}
	
	@RequestMapping(value = "/findPwd/changeMemberPwd.do",method = RequestMethod.POST)
	public void changeMemberPwd(String memberId, String memberPwd,HttpServletResponse response) throws IOException {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("memberPwd", memberPwd);
		
		int result = mService.changeMemberPwd(map);
		if(result>0) response.getWriter().print(true);
		else response.getWriter().print(false);
	}
	
	@RequestMapping(value = "/member/logout.do")
	public ModelAndView logoutMember(HttpSession session, ModelAndView mav) {
		session.invalidate();
		mav.addObject("msg", "로그아웃 되었습니다.");
		mav.addObject("location", "/");
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping(value = "/wakeUpDormantMember.do",method = RequestMethod.POST)
	public String wakeUpDormantMember(Member member, Model model) {
		int result = mService.wakeUpDormantMember(member);
		if(result>0) {
			//로그인 처리하려했더니 암호화때문에 암호화한 비번을 또 암호화해버림
			model.addAttribute("msg","휴면 상태가 해제되었습니다. 다시 로그인 해주세요.");
			model.addAttribute("location","/resources/views/login.jsp");
		}else {
			model.addAttribute("msg","실행 중 문제가 발생했습니다. 다시 시도해 주세요");
			model.addAttribute("location","/resources/staticViews/member/login.jsp");
		}
		return "common/msg";
	}
	
}
