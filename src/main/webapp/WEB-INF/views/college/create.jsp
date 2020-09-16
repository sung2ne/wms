<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
    // 입력항목 검사
    function formCheck() {
        let result = true;

        if ( !$.trim($('#form input[name=collegeName]').val()) ) {
            toastr.error('대학/학부를 입력해주세요.');
            $('#form input[name=collegeName]').focus();
            result = false;
            return false;
        }

        return result;
    }

    // 등록폼
    $('#btnShowCreate').on('click', function() {
        sideWork = 'add';

        $('#form').each(function(){
            this.reset();
        });

        $('#formText').text('등록');
        $('#useDelete').addClass('hidden');
        $('#viewBox').addClass('hidden');
        $('#formBox').removeClass('hidden');
        $('#btnAddConfirm').removeClass('hidden');  // 등록버튼
        $('#btnEditConfirm').addClass('hidden');    // 수정버튼
    });

    // 등록 처리
    $('#btnAddConfirm').on('click', function(e) {
        e.preventDefault();

        if (!formCheck()) return false;

        let formData = new FormData($('#form')[0]);

        $.ajax({
            url: '<c:url value="/college/create"/>',
            type: 'POST',
            data: formData,
            processData : false,
            contentType : false,
            beforeSend: function() {
                $('#btnAddConfirm').addClass('hidden');
                $('#btnAddConfirmLoading').removeClass('hidden');
            },
            success: function (res) {
                if (res.data) {
                    collegeIdx = res.data.collegeIdx;
                    sideWork = 'view';
                    viewEditData(res.data);
                    $('#collegeTable').DataTable().ajax.reload( function () {});
                    toastr.success('등록되었습니다.');
                } else {
                    toastr.error(res.message);
                }
            },
            complete:function(){
                $('#btnAddConfirm').removeClass('hidden');
                $('#btnAddConfirmLoading').addClass('hidden');
            }
        });
    });

    // 취소
    $('#btnCancel').on('click', function() {
        if (sideWork == 'add') {
            $('#form').each(function(){
                this.reset();
            });
        } else {
            $('#useDelete').addClass('hidden');
            $('#viewBox').removeClass('hidden');
            $('#formBox').addClass('hidden');
        }
    });
</script>
