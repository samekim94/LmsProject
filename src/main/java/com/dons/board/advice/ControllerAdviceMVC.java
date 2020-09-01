package com.dons.board.advice;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dons.board.Exception.PageNumException;

@ControllerAdvice
public class ControllerAdviceMVC {
	@ExceptionHandler(Exception.class)
	public String except (Exception ex , Model model) {
		System.out.println("Exception...."+ex.getMessage());
		model.addAttribute("exception",ex);
		System.out.println(model);
		return "error/error_page";
	}
	@ExceptionHandler(PageNumException.class)
	public String except(PageNumException ex, RedirectAttributes attr) {
		attr.addFlashAttribute("msg",ex.getMessage());
		return "redirect:/";
	}
}
