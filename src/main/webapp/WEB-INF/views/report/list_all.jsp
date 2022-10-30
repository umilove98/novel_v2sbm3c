<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Novel world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>
  <A href="./list_all.do" class='title_link'>독후감 목록</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 

  <DIV class='menu_line'></DIV>
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 10%;"></col>
      <col style="width: 50%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    
    <%-- table 내용 --%>
    <tbody>
      <c:forEach var="ReportVO" items="${list }">
        <c:set var="title" value="${ReportVO.title }" />
        <c:set var="content" value="${ReportVO.content }" />
        <c:set var="thumb1" value="${ReportVO.thumb1 }" />
        <c:set var="reportno" value="${ReportVO.reportno }" />
        
        <tr style="height: 132px;">
          <td style='vertical-align: middle; text-align: center;'>
            ${ReportVO.memberid }
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
                <%-- /static/report/storage/ --%>
                <a href="./read.do?reportno=${reportno}&now_page=${param.now_page }"><IMG src="/report/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/report/images/none1.png" style="width: 120px; height: 80px;">
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?reportno=${reportno}"><strong>${title}</strong><br>
            <span>${ReportVO.author }</span><br>
            <span style="font-style: italic; text-decoration: underline">"${ReportVO.favoriteline }"</span>
            </a> 
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
            <A href="/report/update_text.do?reportno=${reportno }" title="글 수정"><IMG src="/report/images/update.png" class="icon"></A>
            <A href="/report/update_file.do?reportno=${reportno }" title="파일 수정"><IMG src="/report/images/update_file.png" class="icon"></A>
            <A href="/report/delete.do?reportno=${reportno }" title="삭제"><IMG src="/report/images/delete.png" class="icon"></A>
          </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

