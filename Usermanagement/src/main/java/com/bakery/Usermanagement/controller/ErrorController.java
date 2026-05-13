package com.bakery.Usermanagement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;

//Handling error pages.

@Controller
public class ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {

        //Gets HTTP status code from the request
        Object statusCode = request.getAttribute(
            "jakarta.servlet.error.status_code"
        );

        //Retrieves the error message if available
        Object errorMessage = request.getAttribute(
            "jakarta.servlet.error.message"
        );

        // Pass data to the JSP page
        model.addAttribute("statusCode", statusCode);
        model.addAttribute("errorMessage",
            errorMessage != null ? errorMessage.toString() : "An unexpected error occurred."
        );

        //Directs to correct error page based on status code
        if (statusCode != null) {
            int code = Integer.parseInt(statusCode.toString());

            if (code == 404) {
                return "error/404";
            } else if (code == 500) {
                return "error/500";
            }
        }

        //Default fallback
        return "error/500";
    }
}