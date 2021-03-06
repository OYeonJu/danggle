package kr.co.todaydaeng.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ckfinder.connector.plugins.ImageResize;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.todaydaeng.admin.model.vo.AdminVO;
import kr.co.todaydaeng.board.model.service.BoardService;
import kr.co.todaydaeng.board.model.vo.Board;
import kr.co.todaydaeng.board.model.vo.BoardEx;
import kr.co.todaydaeng.board.model.vo.Comment;
import kr.co.todaydaeng.board.model.vo.Notice;
import kr.co.todaydaeng.member.model.service.MemberService;
import kr.co.todaydaeng.member.model.vo.Member;
import kr.co.todaydaeng.myPage.model.service.MyPageService;
import kr.co.todaydaeng.myPage.model.vo.Dog;

@Controller
public class BoardController {

	@Autowired
	private BoardService bService;

	@Autowired
	private MyPageService mpService;

	@Autowired
	private ServletContext context;

//		@RequestMapping(value = "/board/_community.do", method = RequestMethod.GET)
//	public ModelAndView _community(ModelAndView mav, @RequestParam(defaultValue = "1") int currentPage)
//				throws Exception {
//			int pageSize = 10; // ??????????????? ?????? ?????????
//			int naviSize = 5; // navi ??????
//			int maxPage = (int) Math.ceil(bService.getTotalCount() / (double) pageSize);
//	
//			int startNavi = currentPage - (currentPage - 1) % naviSize;
//			int endNavi = startNavi + naviSize - 1;
//			endNavi = endNavi > maxPage ? maxPage : endNavi;
//	
//			ArrayList<Integer> navi = new ArrayList<>();
//			for (int i = startNavi; i <= endNavi; i++) {
//				navi.add(i);
//			}
//	
//			// memberId ?????? board
//			ArrayList<BoardEx> boardList = bService.communityList(currentPage, pageSize);
//			ArrayList<Notice> noticeList = bService.noticeList();
//			mav.addObject("boardlist", boardList);
//			mav.addObject("noticelist", noticeList);
//			mav.addObject("navi", navi);
//			mav.addObject("preNavi", startNavi > 1 ? startNavi - 1 : 0);
//			mav.addObject("nextNavi", maxPage > endNavi ? endNavi + 1 : 0);
//			mav.setViewName("board/community");
//			return mav;
//		}
	
	// ???????????? ????????? ??????
	@RequestMapping(value = "/board/community.do", method = RequestMethod.GET)
	public ModelAndView community(ModelAndView mav, 
								  @RequestParam(defaultValue = "1") int currentPage,
								  @RequestParam(defaultValue = "none") String searchOption,
								  @RequestParam(defaultValue = "") String keyword)
			throws Exception {
		int pageSize = 10; // ??????????????? ?????? ?????????
		int naviSize = 5; // navi ??????
		int maxPage = (int) Math.ceil(bService.getTotalCount(searchOption, keyword) / (double) pageSize);

		int startNavi = currentPage - (currentPage - 1) % naviSize;
		int endNavi = startNavi + naviSize - 1;
		endNavi = endNavi > maxPage ? maxPage : endNavi;

		ArrayList<Integer> navi = new ArrayList<>();
		for (int i = startNavi; i <= endNavi; i++) {
			navi.add(i);
		}

		// memberId ?????? board
		ArrayList<BoardEx> boardList = bService.communityList(currentPage, pageSize, searchOption, keyword);
		ArrayList<Notice> noticeList = bService.noticeList();
		mav.addObject("boardlist", boardList);
		mav.addObject("noticelist", noticeList);
		mav.addObject("navi", navi);
		mav.addObject("preNavi", startNavi > 1 ? startNavi - 1 : 0);
		mav.addObject("nextNavi", maxPage > endNavi ? endNavi + 1 : 0);
		mav.addObject("searchOption", searchOption);
		mav.addObject("keyword", keyword);
		
		mav.setViewName("board/community");
		return mav;
	}

	// ????????? ??????
	@RequestMapping(value = "/board/selectContent.do", method = RequestMethod.GET)
	public void getView(@RequestParam("boardNo") int boardNo, Model model) throws Exception {
		BoardEx be = bService.view(boardNo);
		model.addAttribute("view", be);
		
		// ?????? ??????
		List<Comment> comment = null;
		comment = bService.commentList(boardNo);
		model.addAttribute("comment", comment);
	}

	// ????????? ?????? ??? ??????(???????????? ??????)
	@RequestMapping(value = "/board/post.do", method = RequestMethod.GET)
	public String post(HttpSession session, HttpServletResponse response) throws Exception {

		Member memberId = (Member) session.getAttribute("member");
		session.setAttribute("memberId", memberId);
		// ????????? ??????
		if (memberId == null) {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter write = response.getWriter();
			write.println("<script>alert('????????? ????????? ???????????? ????????? ???????????????.');</script>");
			write.flush();

			return "indexPage";

		} else {
			// ???????????? ???????????????
			return "board/write";
		}

	}

	// ????????? ????????? ?????????
	@RequestMapping(value = "/board/communityFile.do", method = RequestMethod.POST)
	public void communityFile(HttpServletRequest request, HttpServletResponse response, @SessionAttribute Member member,
			ModelAndView mav) throws Exception {

		String uploadPath = "/resources/upload/board";
		String uploadFilePath = context.getRealPath(uploadPath);
		System.out.println("?????? ?????? : " + uploadFilePath);

		// ?????? ????????? ??????(50MB)
		int uploadFileSizeLimit = 50 * 1024 * 1024;

		// ?????? ?????? ????????? ??????
		String encType = "UTF-8";

		// MultipartRequest ?????? ??????
		MultipartRequest multi = new MultipartRequest(request, uploadFilePath + "/temp", uploadFileSizeLimit, encType,
				new DefaultFileRenamePolicy());

		// ?????? ??????
		String originalFileName = multi.getFilesystemName("upload");

		// ?????????
		long currentTime = Calendar.getInstance().getTimeInMillis();

		// ????????? ????????? ?????? ?????? ??????
		String memberId = member.getMemberId();

		File file = new File(uploadFilePath + "\\temp\\" + originalFileName);

		String ext = originalFileName.substring(originalFileName.lastIndexOf('.') + 1); // ?????? ?????????
		File file2 = new File(uploadFilePath + "\\" + memberId + "_" + currentTime + "." + ext);
		file.renameTo(file2);

		JsonObject json = new JsonObject();
		json.addProperty("url", "/resources/upload/board/" + file2.getName());
		json.addProperty("uploaded", 1);
		json.addProperty("fileName", originalFileName);
		new Gson().toJson(json, response.getWriter());

	}

	// ????????? ??????
	@RequestMapping(value = "/board/insertPost.do", method = RequestMethod.POST)
	public ModelAndView insertPost(HttpServletRequest request, HttpSession session,
			@RequestParam("subject") String subject, @RequestParam("content") String content,
			@SessionAttribute Member member, ModelAndView mav) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", member.getMemberNo());
		map.put("subject", subject);
		map.put("content", content);
		bService.insertPost(map);

		mav.setViewName("redirect:/board/community.do");
		return mav;
	}

	// ????????? ?????? ??? PWD ?????? ????????? ??????
	@RequestMapping(value = "/board/updateCheckPage.do", method = RequestMethod.GET)
	public ModelAndView checkPwdPage(HttpSession session, HttpServletResponse response, ModelAndView mav,
			@RequestParam("boardNo") int boardNo) throws IOException {
		mav.setViewName("board/updateCheckPage");
		mav.addObject("boardNo", boardNo);
		return mav;
	}

	// ????????? ????????? ???????????? ??????
	@RequestMapping(value = "/board/updateCheck.do", method = RequestMethod.POST)
	public void updateCheckPage(@RequestParam String memberPwd, @SessionAttribute Member member, ModelAndView mav,
			HttpServletResponse response) throws IOException {

		String memberId = member.getMemberId();

		System.out.println(memberPwd);

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("memberPwd", memberPwd);

		Member m = mpService.selectPwdCheck(map);

		if (m != null) {
			/* ?????? ?????? */
			member = m;
			response.getWriter().print(true);
		} else {
			response.getWriter().print(false);
		}

	}

	// ????????? ?????? ????????? ??????
	@RequestMapping(value = "/board/updatePage.do", method = RequestMethod.GET)
	public ModelAndView updatePage(ModelAndView mav, @RequestParam("boardNo") int boardNo, Model model)
			throws Exception {

		// ??????????????? ??????
		BoardEx be = bService.view(boardNo);
		model.addAttribute("view", be);

		mav.setViewName("board/update");
		mav.addObject("boardNo", boardNo);
		return mav;
	}

	// ????????? ??????
	@RequestMapping(value = "/board/update.do", method = RequestMethod.POST)
	public ModelAndView update(BoardEx be, HttpServletRequest request, HttpServletResponse response, ModelAndView mav,
			@SessionAttribute Member member, Model model) throws Exception {

		String uploadPath = "/resources/upload/board";
		String uploadFilePath = context.getRealPath(uploadPath);
		System.out.println("?????? ?????? : " + uploadFilePath);

		// ?????? ????????? ??????(50MB)
		int uploadFileSizeLimit = 50 * 1024 * 1024;

		// ?????? ?????? ????????? ??????
		String encType = "UTF-8";

		// MultipartRequest ?????? ??????
		MultipartRequest multi = new MultipartRequest(request, uploadFilePath + "/temp", uploadFileSizeLimit, encType,
				new DefaultFileRenamePolicy());

		System.out.println(multi);

		int boardNo = Integer.parseInt(multi.getParameter("boardNo"));
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("boardNo", boardNo);
		map.put("subject", subject);
		map.put("content", content);

		// ?????? ??????
		String originalFileName = multi.getFilesystemName("upload");

		System.out.println(originalFileName);
		// ?????????
		long currentTime = Calendar.getInstance().getTimeInMillis();

		// ????????? ????????? ?????? ?????? ??????
		String memberId = member.getMemberId();

		if (originalFileName != null) {

			File file = new File(uploadFilePath + "\\temp\\" + originalFileName);

			String ext = originalFileName.substring(originalFileName.lastIndexOf('.') + 1); // ?????? ?????????
			File file2 = new File(uploadFilePath + "\\" + memberId + "_" + currentTime + "." + ext);
			file.renameTo(file2);

			JsonObject json = new JsonObject();
			json.addProperty("url", "/resources/upload/board/" + file2.getName());
			json.addProperty("uploaded", 1);
			json.addProperty("fileName", originalFileName);
			new Gson().toJson(json, response.getWriter());
		}
		
		model.addAttribute("boardNo", boardNo);
		int result = bService.update(map);

		if (result > 0) {
			mav.addObject("msg", "????????? ?????? ??????");
			mav.addObject("location", "/board/selectContent.do?boardNo=" + boardNo);
		} else {
			mav.addObject("msg", "????????? ?????? ??????");
			mav.addObject("location", "/board/community.do");
		}
		mav.setViewName("common/msg");
		return mav;

	}

	// ????????? ??????
	@RequestMapping(value = "/board/deleteBoardPost.do", method = RequestMethod.GET)
	public void deleteBoardPost(@RequestParam int boardNo, HttpServletResponse response) throws IOException {

		int result = bService.deleteBoardPost(boardNo);

		if (result > 0) {
			response.getWriter().print(true);
		} else {
			response.getWriter().print(false);
		}

	}
	
	//?????? ??????
	@RequestMapping(value = "/comment/insertComment.do", method = RequestMethod.POST)
	public ModelAndView insertComment(HttpServletRequest request, HttpSession session,
									  @RequestParam("bComment") String bComment, 
									  @RequestParam("memberId") String memberId,
								      Comment comment,
								      Model model,
								      ModelAndView mav) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		Member member = (Member)session.getAttribute("member");
		map.put("boardNo", comment.getBoardNo());
		map.put("bComment", bComment);
		map.put("memberId", memberId);

		int result= bService.insertComment(map);
		
		if (result > 0) {
			mav.addObject("msg", "?????? ?????? ??????");
			mav.addObject("location", "/board/selectContent.do?boardNo=" + comment.getBoardNo());
		} else {
			mav.addObject("msg", "?????? ?????? ??????");
			mav.addObject("location", "/board/community.do");
		}
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping(value = "/comment/updateComment.do", method = RequestMethod.POST)
	public void updateComment() throws Exception {
		 
	}
	
	@RequestMapping(value = "/comment/deleteComment.do", method = RequestMethod.GET)
	public void deleteComment() {
		
	}
	
	
	
	@RequestMapping(value = "/hospital/hospitalInfo.do", method = RequestMethod.GET)
	public void hospital() {
	}
}
