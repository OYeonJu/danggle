package kr.co.todaydaeng.diary.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.todaydaeng.diary.model.vo.Diary;
import kr.co.todaydaeng.myPage.model.vo.Dog;

public interface DiaryService {

	HashMap<String, Object> selectAllDogInfo(int currentPage, int memberNo);
	
	Dog selectDogInfo(HashMap<String, Integer> map);

	ArrayList<Diary> calViewList(HashMap<String, Object> map2);

	Diary selectDiary(HashMap<String, Object> map);

	int updateDiary(Diary diary);

	int insertDiary(Diary diary);

	int deleteDiary(Diary diary);

	

	

}
