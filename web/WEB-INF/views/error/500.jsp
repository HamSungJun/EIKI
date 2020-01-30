<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<html>
<head>
    <title>EIKI 500</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>서비스 실행중 오류가 발생했습니다.</h1>
    <h1>잠시 후 다시 시도해 보세요.</h1>
    <p><%= exception.getMessage() %></p>
    <p><%= exception.toString() %></p>
    <p><%= exception.printStackTrace() %></p>
</body>
</html>
