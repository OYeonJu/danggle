package kr.co.todaydaeng.myPage.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import kr.co.todaydaeng.member.model.vo.Member;
import kr.co.todaydaeng.myPage.model.service.MyPageService;
import kr.co.todaydaeng.myPage.model.vo.Dog;

@Repository
public class MyPageDAO {

	@Autowired
	@Qualifier(value = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	public Member selectPwdCheck(HashMap<String, String> map) {

		return sqlSession.selectOne("myPage.selectPwdCheck", map);

	}

	public int updateMemberInfo(Member m) {
		
		return sqlSession.update("myPage.updateMemberInfo", m);
	}

	public int updatePwdChange(HashMap<String, String> map) {
		
		return sqlSession.update("myPage.updatePwdChange", map);
	}

	public int withdrawCheck(HashMap<String, String> map) {
		return sqlSession.update("myPage.withdrawCheck", map);
	}

	
	public ArrayList<Dog> selectAllDogInfoList(int currentPage, int recordCountPerPage, int memberNo) {

		// 방법 1
//		int start=currentPage*recordCountPerPage-(recordCountPerPage-1);
//		int end= currentPage*recordCountPerPage;
//		
//		HashMap<String, Object>map = new HashMap<>();
//		map.put("memberNo", memberNo);
//		map.put("start", start);
//		map.put("end", end);
//		
//		return new ArrayList<Dog>(sqlSession.selectList("myPage.selectAllDogInfoList_1", map));
		
		// 방법2
		int offset=((currentPage-1)*recordCountPerPage);
		int limit= recordCountPerPage;
		RowBounds rb = new RowBounds(offset, limit);
		
		return new ArrayList<Dog>(sqlSession.selectList("myPage.selectAllDogInfoList",memberNo,rb));
		
	}

	public String getPageNavi(int naviContPerPage, int currentPage, int recordCountPerPage, int memberNo) {

		int recordTotalCount =totalCount(memberNo);
		
		int pageTotalCount=(int)Math.ceil(recordTotalCount/(double)recordCountPerPage);
		
		int startNavi=(((currentPage-1)/naviContPerPage)*naviContPerPage)+1;
		int endNavi=startNavi+(naviContPerPage-1);
		
		
		// 총 강아지 정보 수보다 endNavi가 크다면 총 강이지 정보 수로 세팅
		if(endNavi>pageTotalCount) {
			endNavi=pageTotalCount;
		}
		
		//pageNavi 모양 만들기
		StringBuffer sb = new StringBuffer();
		
		if(startNavi !=1) {
			sb.append("<a href='/myPage/dogInfoPage.do?currentPage="+(startNavi-1)+"'> < Prev </a>");
		}
		
		for(int i =startNavi; i<=endNavi;i++) {
			//현재 페이지이면 Bold 처리
			if(i==currentPage) {
				sb.append("<a href='/myPage/dogInfoPage.do?currentPage="+i+"'><b style='font-size:1.2em;'>"+i+"</b></a> ");
			}else {
				sb.append("<a href='/myPage/dogInfoPage.do?currentPage="+i+"'>"+i+"</a> ");
			}
		}
		
		if(endNavi!=pageTotalCount) {
			sb.append("<a href='/myPage/dogInfoPage.do?currentPage="+(endNavi+1)+"'> Next > </a>");
		}
		
		return sb.toString();
	}

	public int totalCount(int memberNo) {
		
		return Integer.parseInt(sqlSession.selectOne("myPage.selectTotalCount", memberNo));
	}

	public int insertDogInfo(Dog dog) {
		return sqlSession.insert("myPage.insertDogInfo", dog);
	}

	public Dog selectOneDogInfo(int dogNo) {
		return sqlSession.selectOne("myPage.selectOneDogInfo", dogNo);
	}

	public int updateDogInfo(Dog dog) {
		return sqlSession.update("myPage.updateDogInfo", dog);
	}

	public int deleteDogInfo(int dogNo) {
		return sqlSession.update("myPage.deleteDogInfo", dogNo);
	}
	
	

}
