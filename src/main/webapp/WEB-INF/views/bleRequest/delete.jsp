<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
    // 삭제 처리
    $('#btnDeleteConfirm').on('click', function() {
        $.ajax({
            url: '<c:url value="/bleRequest/delete"/>',
            type: 'POST',
            data: {
                'bleRequestIdx': bleRequestIdx,
            },
            beforeSend: function() {
                $('#btnDeleteConfirm').addClass('hidden');
                $('#btnDeleteConfirmLoading').removeClass('hidden');
            },
            success: function (res) {
                $('#deleteModal').modal('hide');

                if (res.result == 'ok') {
                    departmentIdx = '';
                    $('#formText').text('등록');
                    $('#form').each(function(){
                        this.reset();
                    });
                    $('#useDelete').addClass('hidden');
                    $('#viewBox').addClass('hidden');
                    $('#formBox').removeClass('hidden');
                    $('#btnAddConfirm').removeClass('hidden');  // 등록버튼
                    $('#btnEditConfirm').addClass('hidden');    // 수정버튼
                    $('#subjectTable').DataTable().ajax.reload( function () {});
                    toastr.success('삭제되었습니다.');
                } else {
                    toastr.error(res.message);
                }
            },
            complete:function(){
                $('#btnDeleteConfirm').removeClass('hidden');
                $('#btnDeleteConfirmLoading').addClass('hidden');
            }
        });
    });
</script>
