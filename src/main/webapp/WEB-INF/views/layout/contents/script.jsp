<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<!-- jQuery 3 -->
<script src="/resources/AdminLTE-2.4.18/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="/resources/AdminLTE-2.4.18/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="/resources/AdminLTE-2.4.18/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/resources/AdminLTE-2.4.18/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="/resources/AdminLTE-2.4.18/dist/js/adminlte.min.js"></script>
<!-- toastr -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>
<!-- moment -->
<script src="<c:url value='/resources/AdminLTE-2.4.18/bower_components/moment/min/moment-with-locales.min.js'/>"></script>
<!-- DataTables -->
<script src="/resources/AdminLTE-2.4.18/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="/resources/AdminLTE-2.4.18/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<!-- custom -->
<script>
    // 토스트 메시지가 2초후 사라짐
    toastr.options.timeOut = 2000;

    // moment 언어 설정
    moment.locale('ko');

    //dataTables 한글화
    let lang_kor = {
        "decimal" : "",
        "emptyTable" : "데이터가 없습니다.",
        "info" : "_START_ - _END_ (총 _TOTAL_ 건)",
        "infoEmpty" : "0건",
        "infoFiltered" : "(전체 _MAX_ 건 중 검색결과)",
        "infoPostFix" : "",
        "thousands" : ",",
        "lengthMenu" : "_MENU_ 개씩 보기",
        "loadingRecords" : "로딩중...",
        "processing" : "처리중...",
        "search" : "검색 : ",
        "zeroRecords" : "검색된 데이터가 없습니다.",
        "paginate" : {
            "first" : "첫 페이지",
            "last" : "마지막 페이지",
            "next" : "다음",
            "previous" : "이전"
        },
        "aria" : {
            "sortAscending" : " :  오름차순 정렬",
            "sortDescending" : " :  내림차순 정렬"
        }
    };
</script>
