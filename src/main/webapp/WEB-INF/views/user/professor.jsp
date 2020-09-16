<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
    // 교수
    let professorTable = $('#professorTable').DataTable({
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
                d.grade = 'P';
            }
        },
        columns: [
            { data: 'userName' },
            { data: 'userId' },
            { data: 'userPhone' },
            { data: 'email' },
            { data: 'collegeName' },
            { data: 'departmentName' },
            {
                render: function(data, type, row) {
                    if (row['useYN'] == 'Y') {
                        return '사용';
                    } else {
                        return '<span class="text-danger">사용안함</span>';
                    }
                }
            },
            {
                render: function(data, type, row) {
                    if (row['deleteYN'] == 'Y') {
                        return '<span class="text-danger">삭제</span>';
                    } else {
                        return '삭제안함';
                    }
                }
            },
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
            [ 3, 'asc' ],
            [ 4, 'asc' ],
        ],
        createdRow: function ( row, data, dataIndex, cells ) {
            $(row).attr('data-user-idx', data.userIdx);
        },
    });

    // 교수 보기
    $('#professorTable tbody').on('click', 'tr', function () {
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
