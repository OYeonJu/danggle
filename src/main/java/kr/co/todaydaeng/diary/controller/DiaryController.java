package kr.co.todaydaeng.diary.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import kr.co.todaydaeng.common.Util;
import kr.co.todaydaeng.diary.model.service.DiaryService;
import kr.co.todaydaeng.diary.model.vo.Diary;
import kr.co.todaydaeng.member.model.vo.Member;
import kr.co.todaydaeng.myPage.model.service.MyPageService;
import kr.co.todaydaeng.myPage.model.vo.Dog;

@Controller
public class DiaryController {

	@Autowired
	private DiaryService dService;



	/* 달력 페이지 호출 */
	@RequestMapping(value = "/diary/diaryCalendarPage.do", method = RequestMethod.GET)
	public String diaryCalendarPage(@SessionAttribute Member member, @RequestParam int dogNo, String year, String month,
			Model model) {
		
		// 로그인 한 회원인지 확인 -> 아니면 로그인 페이지로 이동
		if(member==null) {
			return "/resources/staticViews/member/login.jsp";
		}
		
		// view 페이지에 출력될 반려견 정보 가져오기
		int memberNo = member.getMemberNo();
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("memberNo", memberNo);
		map.put("dogNo", dogNo);

		Dog dog = dService.selectDogInfo(map);
		
		// 달력에 출력될 정보 가져오기
		HashMap<String, Integer> cal =Util.calendar(year, month);
		
		// 월별 일정에 대해 일별 표시하기 구현
		String yyyyMM = String.valueOf(cal.get("year")) + Util.isTwo(String.valueOf(cal.get("month")));
		HashMap<String, Object> map2 = new HashMap<>();
		map2.put("memberNo", memberNo);
		map2.put("yyyyMM", yyyyMM);
		map2.put("dogNo", dogNo);
		ArrayList<Diary> list= dService.calViewList(map2);
		model.addAttribute("cal", cal);
		model.addAttribute("dog", dog);
		model.addAttribute("list", list);
		return "diary/diaryCalendarPage";
	}

	/* 선택한 날짜의 일기 가져오기 */
	@RequestMapping(value = "/diary/selectDiary.do", method = RequestMethod.GET)
	@ResponseBody
	public Diary selectDiary(@RequestParam String year, @RequestParam String month, @RequestParam String date,
			@RequestParam int dogNo, Model model) {

		String scheduleDate = year + Util.isTwo(month) + Util.isTwo(date);


		HashMap<String, Object> map = new HashMap<>();
		map.put("scheduleDate", scheduleDate);
		map.put("dogNo", dogNo);

		Diary diary = dService.selectDiary(map);
		if(diary!=null) {
			return diary;
		}else {
			return null;
		}
		

	}
	
	/* 일기 수정 로직  */
	@RequestMapping(value = "/diary/updateDiary.do",method = RequestMethod.POST)
	public void updateDiary(Diary diary, HttpServletResponse response) throws IOException {
		int result = dService.updateDiary(diary);
		if(result>0) {
			response.getWriter().print(true);
		}else {
			response.getWriter().print(false);
		}
	}
	
	/* 일기 삽입 로직 */
	@RequestMapping(value = "/diary/insertDiary.do", method = RequestMethod.POST)
	public void insertDiary(@SessionAttribute Member member, Diary diary, HttpServletResponse response) throws IOException {
		int memberNo = member.getMemberNo();
		String year=diary.getYear();
		String month=Util.isTwo(diary.getMonth());
		String date=Util.isTwo(diary.getDate());
		
		String scheduleDate=year+month+date;
		
		diary.setMemberNo(memberNo);
		diary.setScheduleDate(scheduleDate);
		
		
		int result =dService.insertDiary(diary);
		if(result>0) {
			response.getWriter().print(true);
		}else {
			response.getWriter().print(false);
		}
	}
	
	/* 일기 삭제 로직 */
	@RequestMapping(value = "/diary/deleteDiary.do",method = RequestMethod.POST)
	public void deleteDiary(Diary diary, HttpServletResponse response) throws IOException {
		String year=diary.getYear();
		String month=Util.isTwo(diary.getMonth());
		String date=Util.isTwo(diary.getDate());
		
		String scheduleDate=year+month+date;
		
		
		diary.setScheduleDate(scheduleDate);
		
		int result =dService.deleteDiary(diary);
		if(result>0) {
			response.getWriter().print(true);
		}else {
			response.getWriter().print(false);
		}
	}

}
