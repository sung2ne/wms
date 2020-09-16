<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
// 출결결과 수정
        $('#attendTable tbody').on('click', 'button', function (e) {
            e.preventDefault();
            let attendIdx = $(this).data('attend-idx');
            let attendYNL = $(this).data('attend-ynl');
            console.log(attendIdx);
			console.log(attendYNL);
            if (attendYNL) {
                $.ajax({
                    url: '/attend/update',
                    type: 'POST',
                    data: {
                        'attendIdx': attendIdx,
                        'attendYNL': attendYNL,
                    },
                    beforeSend: function() {
                        //$('#btnUpdateConfirm').addClass('d-none');
                        //$('#btnUpdateConfirmLoading').removeClass('d-none');
                    },
                    success: function (res) {
                        let data = res.data;

                        if (res.result == 'ok') {
                            $('#attendTable').DataTable().ajax.reload( function () {});
                            if(attendYNL == 'Y'){
                            	toastr.success('출석으로 수정되었습니다.');
                            } else if(attendYNL == 'N'){
                            	toastr.success('결석으로 수정되었습니다.');
                            } else if(attendYNL == 'L'){
                            	toastr.success('지각으로 수정되었습니다.');
                            }
                        } else {
                            toastr.error(res.message);
                        }
                    },
                    complete:function(){
                        //$('#btnDeleteConfirm').removeClass('d-none');
                        //$('#btnDeleteConfirmLoading').addClass('d-none');
                    }
                });
            }
        });
</script>
