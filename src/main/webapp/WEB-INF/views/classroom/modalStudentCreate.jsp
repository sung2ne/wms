<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
// 모달 선택 학생 추가
$('#btnStudentAddConfirm').on('click', function() {
    if ($('input[name=lectureStudentModalCheckbox]:checked').length == 0) {
        toastr.error('선택 항목이 없습니다.');
    } else {
        $("input[name=lectureStudentModalCheckbox]").each(function() {
            if ( $(this).is(":checked") ) {
                let studentIdx = $(this).val();

                $.ajax({
                    url: '/lectureStudent/create',
                    type: 'POST',
                    data: {
                        classroomIdx : classroomIdx,
                        studentIdx : studentIdx,
                    },
                    beforeSend: function() {
                        $('#btnDeleteConfirm').addClass('d-none');
                        $('#btnDeleteConfirmLoading').removeClass('d-none');
                    },
                     success: function (res) {
						console.log(res);
                        if (res.result == 'ok') {
                            toastr.success('등록되었습니다.');
                        } else {
                            toastr.error(res.message);
                        }
                    }, 
                    complete:function(){
                        checkDelete = false;
                        $('input[name=lectureStudentModalCheckbox]').attr('checked', false);
                        $('#btnStudentAddConfirm').removeClass('d-none');
                        $('#btnStudentAddConfirmLoading').addClass('d-none');
                    }
                });
            }
        });

        $('#lectureStudentModal').modal('hide');
        $('#lectureStudentTable').DataTable().ajax.reload( function () {});
        $('#lectureStudentModalTable').DataTable().ajax.reload( function () {});
    }
});
</script>
