<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
    // 수정폼
    $('#btnShowEdit').on('click', function() {
        sideWork = 'edit';
        $('#formText').text('수정');
        $('#useDelete').removeClass('hidden');
        $('#viewBox').addClass('hidden');           // 보기
        $('#formBox').removeClass('hidden');        // 등록,수정
        $('#btnAddConfirm').addClass('hidden');     // 등록버튼
        $('#btnEditConfirm').removeClass('hidden'); // 수정버튼
    });

    // 수정 처리
    $('#btnEditConfirm').on('click', function(e) {
        e.preventDefault();

        if (!formCheck()) return false;

        let formData = new FormData($('#form')[0]);
        formData.append('yearSemesterIdx', yearSemesterIdx);

        $.ajax({
            url: '<c:url value="/yearSemester/update"/>',
            type: 'POST',
            data: formData,
            processData : false,
            contentType : false,
            beforeSend: function() {
                $('#btnEditConfirm').addClass('hidden');
                $('#btnEditConfirmLoading').removeClass('hidden');
            },
            success: function (res) {
                if (res.data) {
                    sideWork = 'view';
                    viewEditData(res.data);
                    $('#yearSemesterTable').DataTable().ajax.reload( function () {});
                    toastr.success('수정되었습니다.');
                } else {
                    toastr.error(res.message);
                }
            },
            complete:function(){
                $('#btnEditConfirm').removeClass('hidden');
                $('#btnEditConfirmLoading').addClass('hidden');
            }
        });
    });
</script>
