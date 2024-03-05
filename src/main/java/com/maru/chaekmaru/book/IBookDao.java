package com.maru.chaekmaru.book;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IBookDao {

	public BookDto selectBook(@Param("b_no") int b_no);

	public ArrayList<BookDto> selectBestBooksByStar(int count);

	public ArrayList<BookDto> selectBestBooksByReviewCount(int count);

	public ArrayList<BookDto> selectNewBooks(int count);

	public ArrayList<BookDto> setList(@Param("sortSql") String sortSql, @Param("startNum") int startNum,
			@Param("endNum") int endNum, @Param("search") String search);

	public int countListResult(String search);

}
