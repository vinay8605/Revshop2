package com.example.add.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {

    private static final Logger logger = LoggerFactory.getLogger(EmailService.class);
    
    private final JavaMailSender mailSender;
    private final String fromEmail;

    @Autowired
    public EmailService(JavaMailSender mailSender, @Value("${spring.mail.username}") String fromEmail) {
        this.mailSender = mailSender;
        this.fromEmail = fromEmail;
    }

    public void sendOrderStatusEmail(String toEmail, String orderNumber, String status) {
        MimeMessage message = mailSender.createMimeMessage();

        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setFrom(fromEmail);
            helper.setTo(toEmail);
            helper.setSubject("Order Status Update - " + orderNumber);
            helper.setText(buildEmailContent(orderNumber, status), true);

            mailSender.send(message);
            logger.info("Order status update email sent successfully to {}", toEmail);
        } catch (MessagingException e) {
            logger.error("Failed to send order status email: {}", e.getMessage());
            throw new RuntimeException("Failed to send email notification", e);
        }
    }
    
    private String buildEmailContent(String orderNumber, String status) {
        return String.format("""
            <p>Dear Customer,</p>
            
            <p>Your order #%s has been updated to: <strong>%s</strong></p>
            
            <p>%s</p>
            
            <p>If you have any questions, please don't hesitate to contact our support team.</p>
            
            <p>Best regards,<br>Your Store Team</p>
            """,
            orderNumber,
            status,
            getStatusSpecificMessage(status));
    }

    private String getStatusSpecificMessage(String status) {
        switch (status.toLowerCase()) {
            case "shipped":
                return "Your order is on its way and will be with you soon.";
            case "delivered":
                return "We’re pleased to inform you that your order has been delivered.";
            case "canceled":
                return "We’re sorry to inform you that your order has been canceled.";
            default:
                return "Your order status has been updated. Please check your account for more details.";
        }
    }
    public void sendAccountActivationEmail(String toEmail, String sellerName) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Account Activation - Welcome to Monagallu");

        String emailContent = "Hello " + sellerName + ",\n\n" +
                              "Congratulations! Your seller account has been activated. You can now access all features.\n\n" +
                              "Best regards,\n" +
                              "Monagallu ✊🏻";

        message.setText(emailContent);
        mailSender.send(message);
    }
}
