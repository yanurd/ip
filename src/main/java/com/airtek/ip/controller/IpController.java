package com.airtek.ip.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import jakarta.servlet.http.HttpServletRequest;
@RestController
@RequestMapping("/api")
public class IpController {

    @GetMapping("/ip")
    public String getClientIp(HttpServletRequest request) {
        String clientIp = request.getRemoteAddr();
        
        String forwardedIp = request.getHeader("X-Forwarded-For");
        if (forwardedIp != null && !forwardedIp.isEmpty()) {
            clientIp = forwardedIp.split(",")[0].trim();
        }
        
        return clientIp;
    }
}
