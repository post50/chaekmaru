package com.maru.chaekmaru.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.maru.chaekmaru.member.MemberDto;

import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;
import oracle.jdbc.proxy.annotation.Post;
import org.springframework.web.bind.annotation.RequestParam;

@Log4j2
@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	ReviewService reviewService;

	String nextPage = "";

	@PostMapping("/write_confirm")
	public String writeConfirm(Model model, HttpSession session, ReviewDto reviewDto) {
		nextPage = "redirect:/book/view/" + reviewDto.getB_no();

		MemberDto loginedMemberDto = (MemberDto) session.getAttribute("loginedMemberDto");

		reviewDto.setM_id(loginedMemberDto.getM_id());

		int result = -1;

		result = reviewService.writeConfirm(reviewDto);

		log.info(result);

		return nextPage;
	}

	@PostMapping("/modify_confirm")
	public String deleteReview(Model model, HttpSession session, ReviewDto reviewDto) {
		nextPage = "redirect:/book/view/" + reviewDto.getB_no();

		int result = -1;

		result = reviewService.modifyConfirm(reviewDto);

		log.info(result);

		return nextPage;

	}

	@GetMapping("/delete_confirm")
	public String deleteReview(@RequestParam("r_no") int r_no, @RequestParam("b_no") int b_no) {
		nextPage = "redirect:/book/view/" + b_no;
		int result = -1;

		result = reviewService.deleteConfirm(r_no);

		log.info(result);

		return nextPage;
	}

}
