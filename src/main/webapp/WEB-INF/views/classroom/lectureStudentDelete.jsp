<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
// 수강 학생 삭제 처리
$('#btnStudentDeleteConfirm').on('click', function() {
    $.ajax({
        url: '/lectureStudent/delete',
        type: 'POST',
        data: {
            'classroomStudentIdx': deleteLectureStudentIdx,
        },
        beforeSend: function() {
            $('#btnStudentDeleteConfirm').addClass('d-none');
            $('#btnStudentDeleteConfirmLoading').removeClass('d-none');
        },
        success: function (res) {
        	deleteLectureStudentIdx = '';
            $('#deleteLectureStudentModal').modal('hide');

            if (res.result == 'ok') {
                $('#lectureStudentTable').DataTable().ajax.reload( function () {});
                toastr.success('삭제되었습니다.');
            } else {
                toastr.error(res.message);
            }
        },
        complete:function(){
            $('#btnStudentDeleteConfirm').removeClass('d-none');
            $('#btnStudentDeleteConfirmLoading').addClass('d-none');
        }
    });
});
</script>
