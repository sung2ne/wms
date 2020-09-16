<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
    // 비밀번호 수정폼
    $('#btnShowPassword').on('click', function() {
        sideWork = 'edit';
        $('#formText').text('수정');
        $('.editTr').addClass('hidden');
        $('.passwordTr').removeClass('hidden');
        $('#useDelete').removeClass('hidden');
        $('#viewBox').addClass('hidden');           // 보기
        $('#formBox').removeClass('hidden');        // 등록,수정
        $('#btnAddConfirm').addClass('hidden');     // 등록버튼
        $('#btnEditConfirm').addClass('hidden'); // 수정버튼
        $('#btnEditPasswordConfirm').removeClass('hidden'); // 비밀번호 수정버튼
    });

    // 비밀번호 수정 처리
    $('#btnEditPasswordConfirm').on('click', function(e) {
        e.preventDefault();

        if (!passwordCheck()) return false;

        let formData = new FormData($('#form')[0]);
        formData.append('userIdx', userIdx);

        $.ajax({
            url: '<c:url value="/user/update"/>',
            type: 'POST',
            data: formData,
            processData : false,
            contentType : false,
            beforeSend: function() {
                $('#btnEditPasswordConfirm').addClass('hidden');
                $('#btnEditPasswordConfirmLoading').removeClass('hidden');
            },
            success: function (res) {
                if (res.data) {
                    sideWork = 'view';
                    viewEditData(res.data);
                    $('#professorTable').DataTable().ajax.reload( function () {});
                    $('#studentTable').DataTable().ajax.reload( function () {});
                    $('#assistantTable').DataTable().ajax.reload( function () {});
                    toastr.success('비밀번호가 수정되었습니다.');
                } else {
                    toastr.error(res.message);
                }
            },
            complete:function(){
                $('#btnEditPasswordConfirm').removeClass('hidden');
                $('#btnEditPasswordConfirmLoading').addClass('hidden');
            }
        });
    });
</script>
