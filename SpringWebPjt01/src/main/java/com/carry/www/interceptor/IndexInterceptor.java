package com.carry.www.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.carry.www.config.PageMaker;
import com.carry.www.service.BoardService;
import com.carry.www.vo.BoardVO;
import com.carry.www.vo.Criteria;

public class IndexInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	BoardService service;
	
	@Autowired
	Criteria cri;
	
	@Autowired
	PageMaker pmIndex;
	

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView mv) throws Exception {
		
		List<BoardVO> allPost = service.boardSelectAll(cri);
		mv.addObject("allPost", allPost);
		
		pmIndex.setCri(cri);
		pmIndex.setTotalCount(service.cntAllPost());
		mv.addObject("pmIndex", pmIndex);
		
	}
}
