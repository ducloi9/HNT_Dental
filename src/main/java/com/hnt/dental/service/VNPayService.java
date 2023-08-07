package com.hnt.dental.service;

import com.hnt.dental.util.SecretUtils;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.*;

public class VNPayService {

    private static final ResourceBundle bundle = ResourceBundle.getBundle("application");

    public String renderPayment(Long bookingId, double amount, HttpServletRequest request) {
        Map<String, String> vnpParams = new HashMap<>();
        vnpParams.put("vnp_Version", "2.0.0");
        vnpParams.put("vnp_Command", "pay");
        vnpParams.put("vnp_TmnCode", bundle.getString("vnp.tmnCode"));
        vnpParams.put("vnp_Amount", String.valueOf((int) Math.round(amount * 100)));
        vnpParams.put("vnp_CurrCode", "VND");
        vnpParams.put("vnp_BankCode", "");
        vnpParams.put("vnp_TxnRef", bookingId.toString());
        vnpParams.put("vnp_OrderInfo", StringUtils.join("bookingId: ", bookingId));
        vnpParams.put("vnp_OrderType", "billpayment");
        vnpParams.put("vnp_Locale", "vi");
        vnpParams.put("vnp_ReturnUrl", bundle.getString("vnp.return.url"));
        vnpParams.put("vnp_IpAddr", getIpAddress(request));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        vnpParams.put("vnp_CreateDate", formatter.format(new Date()));

        List<String> fieldNames = new ArrayList<>(vnpParams.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = vnpParams.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(fieldValue);
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnpSecure = bundle.getString("vnp.hash.secret") + hashData;
        String vnpSecureHash = sha256(vnpSecure);
        queryUrl += "&vnp_SecureHashType=SHA256&vnp_SecureHash=" + vnpSecureHash;
        return bundle.getString("vnp.pay.url") + "?" + queryUrl;
    }

    public static String sha256(String message) {
        String digest;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(message.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }

            digest = sb.toString();

        } catch (NoSuchAlgorithmException ex) {
            digest = "";
        }
        return digest;
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ipAddress;
        try {
            ipAddress = request.getHeader("X-FORWARDED-FOR");
            if (ipAddress == null) {
                ipAddress = request.getRemoteAddr();
            }
        } catch (Exception e) {
            ipAddress = "Invalid IP:" + e.getMessage();
        }
        return ipAddress;
    }
}