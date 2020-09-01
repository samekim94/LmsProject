package com.dons.board.Exception;

public class DbException extends RuntimeException {
	public DbException() {
		super("스프링은 RuntimeException 예외만 인정합니다.");
	}
}
