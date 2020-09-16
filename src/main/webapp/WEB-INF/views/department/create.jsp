<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
    // 입력항목 검사
    function formCheck() {
        let result = true;

        if ( !$.trim($('#form select[name=collegeIdx]').val()) ) {
            toastr.error('대학/학부를 선택해주세요.');
            $('#form select[name=collegeIdx]').focus();
            result = false;
            return false;
        }

        if ( !$.trim($('#form input[name=departmentName]').val()) ) {
            toastr.error('학과/부서를 입력해주세요.');
            $('#form input[name=departmentName]').focus();
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
            url: '<c:url value="/department/create"/>',
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
                    departmentIdx = res.data.departmentIdx;
                    sideWork = 'view';
                    viewEditData(res.data);
                    $('#departmentTable').DataTable().ajax.reload( function () {});
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
