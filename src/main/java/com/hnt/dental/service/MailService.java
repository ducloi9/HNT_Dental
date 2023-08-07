package com.hnt.dental.service;


import com.hnt.dental.dto.mail.EmailDto;
import com.hnt.dental.dto.mail.MailerDto;
import com.hnt.dental.util.FileUtils;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import org.apache.commons.text.StringSubstitutor;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

public class MailService {

    private static final ResourceBundle bundle = ResourceBundle.getBundle("application");


    public boolean sendEmail(EmailDto emailDto) throws UnirestException {
        String apiKey = bundle.getString("mailgun.api_key");
        String domain = bundle.getString("mailgun.domain");
        String from = bundle.getString("mailgun.email");
        String fromName = bundle.getString("mailgun.name");
        HttpResponse<String> request = Unirest.post("https://api.mailgun.net/v3/" + domain + "/messages")
                .basicAuth("api", apiKey)
                .queryString("from", fromName + " <" + from + ">")
                .queryString("to", emailDto.getTo().get(0).getEmail())
                .queryString("subject", emailDto.getSubject())
                .queryString("html", emailDto.getHtmlPart())
                .asString();
        System.out.println(request.getBody());
        return request.getStatus() == 200;
    }

    public static void sendMailConfirm(String username, String link, String email) throws IOException, UnirestException {
        String mailBody = FileUtils.readFile("email/register.html");
        Map<String, String> mailAttributes = new HashMap<>();
        mailAttributes.put("name",username);
        mailAttributes.put("link",link);
        StringSubstitutor stringSubstitutor = new StringSubstitutor(mailAttributes);
        mailBody = stringSubstitutor.replace(mailBody);
        EmailDto emailDto = EmailDto.builder()
                .to(List.of(MailerDto.builder()
                        .email(email)
                        .name(username)
                        .build()))
                .subject("Xác nhận đăng ký tài khoản")
                .htmlPart(mailBody)
                .build();
        new MailService().sendEmail(emailDto);
    }

    public static void sendMailForgotPassword(String username, String link, String email) throws IOException, UnirestException {
        String mailBody = FileUtils.readFile("email/forgot-password.html");
        Map<String, String> mailAttributes = new HashMap<>();
        mailAttributes.put("name",username);
        mailAttributes.put("link",link);
        StringSubstitutor stringSubstitutor = new StringSubstitutor(mailAttributes);
        mailBody = stringSubstitutor.replace(mailBody);
        EmailDto emailDto = EmailDto.builder()
                .to(List.of(MailerDto.builder()
                        .email(email)
                        .name(username)
                        .build()))
                .subject("Xác nhận đổi mật khẩu")
                .htmlPart(mailBody)
                .build();
        new MailService().sendEmail(emailDto);
    }

    public static void sendMailAccount(String username, String pass, String email) throws IOException, UnirestException {
        String mailBody = FileUtils.readFile("email/account.html");
        Map<String, String> mailAttributes = new HashMap<>();
        mailAttributes.put("name",username);
        mailAttributes.put("pass",pass);
        StringSubstitutor stringSubstitutor = new StringSubstitutor(mailAttributes);
        mailBody = stringSubstitutor.replace(mailBody);
        EmailDto emailDto = EmailDto.builder()
                .to(List.of(MailerDto.builder()
                        .email(email)
                        .name(username)
                        .build()))
                .subject("Cấp Tài khoản")
                .htmlPart(mailBody)
                .build();
        new MailService().sendEmail(emailDto);
    }

    public static void main(String[] args) {
        try {
            sendMailAccount("Huy","24356grybewfj","khuonghung1423@gmail.com");
        } catch (IOException | UnirestException e) {
            e.printStackTrace();
        }
    }
}
