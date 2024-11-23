package com.example.add.Controller;

import com.example.add.service.DashboardService;
import com.example.entity.DashboardStats;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("/admin")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @GetMapping("/stats")
    public String getDashboardStats(Model model) {
        DashboardStats stats = dashboardService.getDashboardStats();
        model.addAttribute("dashboardStats", stats);  // Add data to the model
        return "dashboard";  // Name of the JSP file, e.g., dashboard.jsp
    }
}

