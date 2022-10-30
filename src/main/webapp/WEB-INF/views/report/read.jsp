<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="reportno" value="${reportVO.reportno }" />
<c:set var="title" value="${reportVO.title }" />   
<c:set var="author" value="${reportVO.author }" />  
<c:set var="maincharacter" value="${reportVO.maincharacter }" /> 
<c:set var="favoriteline" value="${reportVO.favoriteline }" />      
<c:set var="file1" value="${reportVO.file1 }" />
<c:set var="file1saved" value="${reportVO.file1saved }" />
<c:set var="thumb1" value="${reportVO.thumb1 }" />
<c:set var="content" value="${reportVO.content }" />
<c:set var="size1_label" value="${reportVO.size1_label }" />
 
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
 
<DIV class='title_line'><A href="./list_by_cateno_search_paging.do?cateno=${cateno }" class='title_link'>${cateVO.name }</A></DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <c:if test="${sessionScope.id != null }">
      <A href="./create.do">등록</A>
      <span class='menu_divide' >│</span>
      <A href="./update_text.do?reportno=${reportno}&now_page=${param.now_page}">수정</A>
      <span class='menu_divide' >│</span>
      <A href="./update_file.do?reportno=${reportno}&now_page=${param.now_page}">파일 수정</A>
      <span class='menu_divide' >│</span>
      <A href="./delete.do?reportno=${reportno}">삭제</A>  
      <span class='menu_divide' >│</span>
    </c:if>

    <A href="javascript:location.reload();">새로고침</A>
    
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search_paging.do'>
      <input type='hidden' name='cateno' value='${cateno }'>
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_cateno_search.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 50%; float: left; margin-right: 10px;">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/report/storage/ --%>
                <IMG src="/report/storage/${file1saved }" style="width: 100%;"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/report/images/none1.png" style="width: 100%;"> 
              </c:otherwise>
            </c:choose>
        </DIV>
        <DIV style="width: 48%; height: 260px; float: left; margin-right: 10px; margin-bottom: 30px;">
          제목 :<span style="font-size: 1.2em; font-weight: bold;"> ${title }</span><br>
          저자 :<span style="font-size: 1.2em; font-weight: bold;"> ${author }</span><br>
          <span style="font-family: 'Song Myung', serif; font-size: 2em; font-weight: bold; font-style: italic;">"${favoriteline }"</span><br>
          등장인물 :<span style="font-size: 1.2em; font-weight: bold;"> ${maincharacter }</span><br>
        </DIV> 

        <DIV>${content }</DIV>
      </li>
            
      
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <A href='/download?dir=/report/storage&filename=${file1saved}&downname=${file1}'>${file1}</A> (${size1_label}) 
            <A href='/download?dir=/report/storage&filename=${file1saved}&downname=${file1}'><IMG SRC="/report/images/download.png"></A>
          </c:if>
        </DIV>
      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

