package com.dons.board.Exception;
//공용 예외클래스 // throws, try~catch 생략가능
@SuppressWarnings("serial")
public class PageNumException extends RuntimeException{
	public PageNumException(String msg) {
		super(msg); //getMessage()
	}
}
