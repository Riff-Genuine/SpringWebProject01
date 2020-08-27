package com.carry.www.config;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.carry.www.dao.BoardDAO;
import com.carry.www.vo.BoardVO;
import com.carry.www.vo.MemberVO;

@Repository
public class FileConfig { 
	String filePath = "D:\\Uploaded File\\";
	
	@Autowired
	BoardDAO dao;
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	public List<Map<String, Object>> insertFileInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		HttpSession session = request.getSession();
		
		MultipartFile mpFile = null;
		
		String originFileName = null;
		String originFileExtension = null;
		String storedFileName = null;
		
		MemberVO vo = (MemberVO)session.getAttribute("user");
		String userID = vo.getId();
		int no = dao.selectBoardNo(sqlSession);
		System.out.println("======================================== 숫자 : " + no );
		
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		Map<String, Object> fileMap = null;
		
		Iterator<String> iterator = mpRequest.getFileNames();
		
		while(iterator.hasNext()) {
			mpFile = mpRequest.getFile(iterator.next());
			
			if(!mpFile.isEmpty()) {
				originFileName = mpFile.getOriginalFilename();
				originFileExtension = originFileName.substring(originFileName.lastIndexOf("."));
				storedFileName = RndStringConfig.getRndString()+originFileExtension;
				
				mpFile.transferTo(new File(filePath+storedFileName));
				
				fileMap = new HashMap<String, Object>();
				fileMap.put("boardNo", no);
				fileMap.put("id", userID);
				fileMap.put("originName", originFileName);
				fileMap.put("storedName", storedFileName);
				fileMap.put("fileSize", mpFile.getSize());
				
				fileList.add(fileMap);
			} 
			
		}
		
		return fileList;
	}

	public List<Map<String, Object>> updateFileInfo(Map<String, Object> map, HttpServletRequest request, BoardVO boardInfo) throws IllegalStateException, IOException {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		HttpSession session = request.getSession();
		
		MultipartFile mpFile = null;
		
		String originFileName = null;
		String originFileExtension = null;
		String storedFileName = null;
		
		MemberVO vo = (MemberVO)session.getAttribute("user");
		String userID = vo.getId();
		int no = boardInfo.getNo();
		System.out.println("======================================== 숫자 : " + no );
		
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		Map<String, Object> fileMap = null;
		
		Iterator<String> iterator = mpRequest.getFileNames();
		
		while(iterator.hasNext()) {
			mpFile = mpRequest.getFile(iterator.next());
			
			if(!mpFile.isEmpty()) {
				originFileName = mpFile.getOriginalFilename();
				originFileExtension = originFileName.substring(originFileName.lastIndexOf("."));
				storedFileName = RndStringConfig.getRndString()+originFileExtension;
				
				mpFile.transferTo(new File(filePath+storedFileName));
				
				fileMap = new HashMap<String, Object>();
				fileMap.put("boardNo", no);
				fileMap.put("id", userID);
				fileMap.put("originName", originFileName);
				fileMap.put("storedName", storedFileName);
				fileMap.put("fileSize", mpFile.getSize());
				
				fileList.add(fileMap);
			} 
			
		}
		
		return fileList;
	}

	
}
	
	
