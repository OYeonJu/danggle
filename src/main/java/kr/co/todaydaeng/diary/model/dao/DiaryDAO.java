package kr.co.todaydaeng.diary.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.co.todaydaeng.diary.model.vo.Diary;
import kr.co.todaydaeng.myPage.model.dao.MyPageDAO;
import kr.co.todaydaeng.myPage.model.vo.Dog;

@Repository
public class DiaryDAO {

	@Autowired
	private MyPageDAO mpDAO;

	@Autowired
	@Qualifier(value = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	public String getPageNavi(int naviContPerPage, int currentPage, int recordCountPerPage, int memberNo) {
		int recordTotalCount = mpDAO.totalCount(memberNo);

		int pageTotalCount = (int) Math.ceil(recordTotalCount / (double) recordCountPerPage);

		int startNavi = (((currentPage - 1) / naviContPerPage) * naviContPerPage) + 1;
		int endNavi = startNavi + (naviContPerPage - 1);

		// 총 강아지 정보 수보다 endNavi가 크다면 총 강이지 정보 수로 세팅
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		// pageNavi 모양 만들기
		StringBuffer sb = new StringBuffer();

		if (startNavi != 1) {
			sb.append("<a href='/myPage/diaryPage.do?currentPage=" + (startNavi - 1) + "'> < Prev </a>");
		}

		for (int i = startNavi; i <= endNavi; i++) {
			// 현재 페이지이면 Bold 처리
			if (i == currentPage) {
				sb.append("<a href='/diary/dogSelectPage.do?currentPage=" + i + "'><b style='font-size:1.2em;'>" + i
						+ "</b></a> ");
			} else {
				sb.append("<a href='/myPage/diaryPage.do?currentPage=" + i + "'>" + i + "</a> ");
			}
		}

		if (endNavi != pageTotalCount) {
			sb.append("<a href='/myPage/diaryPage.do?currentPage=" + (endNavi + 1) + "'> Next > </a>");
		}

		return sb.toString();
	}

	public Dog selectDogInfo(HashMap<String, Integer> map) {
		return sqlSession.selectOne("diary.selectDogInfo", map);
	}

	public ArrayList<Diary> calViewList(HashMap<String, Object> map2) {
		return new ArrayList<Diary>(sqlSession.selectList("diary.calViewList", map2));
	}

	public Diary selectDiary(HashMap<String, Object> map) {
		return sqlSession.selectOne("diary.selectDiary", map);
	}

	public int updateDiary(Diary diary) {
		return sqlSession.update("diary.updateDiary", diary);
	}

	public int insertDiary(Diary diary) {
		return sqlSession.insert("diary.insertDiary", diary);
	}

	public int deleteDiary(Diary diary) {
		return sqlSession.delete("diary.deleteDiary", diary);
	}

}
