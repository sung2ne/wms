<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/contents/top.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            시간
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 전자출결</a></li>
            <li><a href="#">기준정보</a></li>
            <li class="active">시간</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">

            <div class="col-md-8">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">시간 목록</h3>
                        <div class="box-tools"><button type="button" class="btn btn-success" id="btnShowCreate">신규등록</button></div>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered table-hover" id="scheduletimeTable">
                            <thead>
                            <tr>
                                <th>교시</th>
                                <th>시작 시간</th>
                                <th>종료 시간</th>
                                <th>사용</th>
                                <th>삭제</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-md-4">

                <!-- 보기 -->
                <div class="box hidden" id="viewBox">
                    <div class="box-header">
                        <h3 class="box-title">시간 정보</h3>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered table-hover">
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tr>
                                <th>교시</th>
                                <td><span id="classTime"></span></td>
                            </tr>
                            <tr>
                                <th>시작 시간</th>
                                <td><span id="startTime"></span>
                            </tr>
                            <tr>
                                <th>종료 시간</th>
                                <td><span id="endTime"></span>
                            </tr>
                        </table>
                        <table class="table table-bordered table-hover" style="margin-top: 10px;">
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tr>
                                <th>등록</th>
                                <td><span id="createUserName"></span>
                            </tr>
                            <tr>
                                <th>등록 일시</th>
                                <td><span id="createDateTime"></span>
                            </tr>
                        </table>
                        <table class="table table-bordered table-hover hidden" id="updateDateTimeTable" style="margin-top: 10px;">
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tr>
                                <th>수정</th>
                                <td><span id="updateUserName"></span>
                            </tr>
                            <tr>
                                <th>수정 일시</th>
                                <td><span id="updateDateTime"></span>
                            </tr>
                        </table>
                        <table class="table table-bordered table-hover hidden" id="deleteDateTimeTable" style="margin-top: 10px;">
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tr>
                                <th>삭제</th>
                                <td><span id="deleteUserName"></span>
                            </tr>
                            <tr>
                                <th>삭제 일시</th>
                                <td><span id="deleteDateTime"></span>
                            </tr>
                        </table>
                    </div>
                    <div class="box-footer">
                        <button type="button" class="btn btn-warning" id="btnShowEdit">수정</button>
                        <div class="pull-right">
                            <button type="button" class="btn btn-danger" id="btnDelete" data-toggle="modal" data-target="#deleteModal">삭제</button>
                        </div>
                    </div>
                </div>
                <!--// 보기 -->

                <!-- 등록, 수정 -->
                <div class="box" id="formBox">
                    <div class="box-header">
                        <h3 class="box-title">시간 <span id="formText">등록</span></h3>
                    </div>
                    <div class="box-body">
                        <form id="form">
                            <table class="table table-bordered table-hover">
                                <colgroup>
                                    <col width="120">
                                    <col>
                                </colgroup>
                                <tr>
                                    <th>교시</th>
                                    <td><input type="text" class="form-control" name="classTime"></td>
                                </tr>
                                <tr>
                                    <th>시작 시간</th>
                                    <td><input type="text" class="form-control" name="startTime"></td>
                                </tr>
                                <tr>
                                    <th>종료 시간</th>
                                    <td><input type="text" class="form-control" name="endTime"></td>
                                </tr>
                            </table>
                            <table class="table table-bordered table-hover hidden" id="useDelete" style="margin-top: 10px;">
                                <colgroup>
                                    <col width="120">
                                    <col>
                                </colgroup>
                                <tr>
                                    <th>사용</th>
                                    <td>
                                        <select class="form-control" name="useYN">
                                            <option value="Y">사용</option>
                                            <option value="N">사용안함</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>삭제</th>
                                    <td>
                                        <select class="form-control" name="deleteYN">
                                            <option value="Y">삭제</option>
                                            <option value="N">삭제안함</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <div class="box-footer">
                        <button type="button" class="btn btn-primary" id="btnAddConfirm">등록</button>
                        <button class="btn btn-primary hidden" id="btnAddConfirmLoading" type="button" disabled>
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
                        </button>
                        <button type="button" class="btn btn-warning hidden" id="btnEditConfirm">수정</button>
                        <button class="btn btn-warning hidden" id="btnEditConfirmLoading" type="button" disabled>
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
                        </button>
                        <div class="pull-right">
                            <button type="button" class="btn btn-default" id="btnCancel">취소</button>
                        </div>
                    </div>
                </div>
                <!--// 등록, 수정 -->

            </div>

        </div>
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<%@include file="../layout/contents/footer.jsp" %>
<%@include file="../layout/contents/bottom.jsp" %>
<%@include file="../layout/contents/script.jsp" %>

<script>
    let scheduletimeIdx;
    let sideWork = 'add';

    // 수정항목 정보
    function viewEditData(data) {
        // 보김, 숨김
        $('#useDelete').addClass('hidden');
        $('#viewBox').removeClass('hidden');
        $('#formBox').addClass('hidden');

        // 보기
        $('#classTime').text(data.classTime);
        $('#startTime').text(data.startTime);
        $('#endTime').text(data.endTime);
        $('#createDateTime').text( moment(data.createDateTime,'YYYYMMDDHHmmss').format('YYYY-MM-DD HH:mm') );
        $('#createUserName').text(data.createUserName);

        // 수정한 사람, 수정일시
        if (data.updateUserName) {
            $('#updateDateTimeTable').removeClass('hidden');
            $('#updateDateTime').text( moment(data.updateDateTime,'YYYYMMDDHHmmss').format('YYYY-MM-DD HH:mm') );
            $('#updateUserName').text(data.updateUserName);
        }

        // 삭제한 사람, 삭제일시
        if (data.deleteUserName) {
            $('#deleteDateTimeTable').removeClass('hidden');
            $('#deleteDateTime').text( moment(data.deleteDateTime,'YYYYMMDDHHmmss').format('YYYY-MM-DD HH:mm') );
            $('#deleteUserName').text(data.deleteUserName);
        }

        // 수정
        $('#form input[name=classTime]').val(data.classTime);
        $('#form input[name=startTime]').val(data.startTime);
        $('#form input[name=endTime]').val(data.endTime);
        $('#form select[name=useYN]').val(data.useYN);
        $('#form select[name=deleteYN]').val(data.deleteYN);
    }

    // 목록
    let scheduletimeTable = $('#scheduletimeTable').DataTable({
        language: lang_kor,
        paging: true,
        pageLength: 20,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        ajax: {
            url: '<c:url value="/scheduletime/list"/>',
            type: 'GET',
            data: function ( d ) {
            }
        },
        columns: [
            { data: 'classTime' },
            { data: 'startTime' },
            { data: 'endTime' },
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
            [ 0, 'asc' ]
        ],
        createdRow: function ( row, data, dataIndex, cells ) {
            $(row).attr('data-scheduletime-idx', data.scheduletimeIdx);
        },
    });

    // 보기
    $('#scheduletimeTable tbody').on('click', 'tr', function () {
        sideWork = 'view';
        scheduletimeIdx = $(this).data('scheduletime-idx');

        $.ajax({
            url: '<c:url value="/scheduletime/view"/>',
            type: 'GET',
            data: {
                'scheduletimeIdx': scheduletimeIdx
            },
            success: function (res) {
                viewEditData(res.data);
            }
        });
    });
</script>

<%@include file="create.jsp" %>
<%@include file="update.jsp" %>
<%@include file="delete.jsp" %>

</body>
</html>
