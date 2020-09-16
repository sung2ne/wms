<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
    // 사용자 목록
    let userTable = $('#userTable').DataTable({
        language: lang_kor,
        paging: true,
        pageLength: 20,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        ajax: {
            url: '<c:url value="/user/list"/>',
            type: 'GET',
            data: function ( d ) {
                //d.grade = 'A';
            }
        },
        columns: [
            { data: 'userName' },
            { data: 'userId' },
            { data: 'departmentName' },
            { data: 'mobile' },
            { data: 'phone' },
        ],
        columnDefs: [
            {
                //'targets': [0],
                //'orderable': false,
                //'searchable': false,
            },
        ],
        order: [
            [ 0, 'asc' ],
            [ 1, 'asc' ],
            [ 2, 'asc' ],
        ],
        createdRow: function ( row, data, dataIndex, cells ) {
            $(row).attr('data-user-idx', data.userIdx);
        },
    });

    // 조교 보기
    $('#userTable tbody').on('click', 'tr', function () {
        sideWork = 'view';
        userIdx = $(this).data('user-idx');

        $.ajax({
            url: '<c:url value="/user/view"/>',
            type: 'GET',
            data: {
                'userIdx': userIdx
            },
            success: function (res) {
                viewEditData(res.data);
            }
        });
    });
</script>
