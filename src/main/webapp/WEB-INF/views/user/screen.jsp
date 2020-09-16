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
            사용자
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> WMS</a></li>
            <li><a href="#">기준정보</a></li>
            <li class="active">사용자</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
        
        	<!-- 왼쪽 -->
            <div class="col-md-8">            
	            <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">사용자 목록</h3>
                        <div class="box-tools"><button type="button" class="btn btn-success" id="btnShowCreate">신규등록</button></div>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered table-hover" id="studentTable">
                        	<thead>
                            <tr>
                                <th>이름</th>
                                <th>아이디</th>
                                <th>부서</th>
                                <th>핸드폰번호</th>
                                <th>전화번호</th>    
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
			<!--// 왼쪽 -->
			
			<!-- 오른쪽 -->
            <div class="col-md-4">    
            	<form id="form">        
	            	<div class="box-header">
	                    <h3 class="box-title">사용자 정보</h3>
	                </div>
	                <div class="box-body">	                    
                        <table class="table table-bordered table-hover">
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tr>
                                <th>학과/부서</th>
                                <td>
                                    <select class="form-control" name="departmentIdx">
                                        <option value="">선택</option>
                                        <option value="">선택</option>
                                            <c:forEach var="departmentList" items="${departmentList}">
                                                <option value="${departmentList.departmentIdx}">${departmentList.departmentName}</option>
                                            </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>이름</th>
                                <td><input type="text" class="form-control" name="userName"></td>
                            </tr>
                            <tr>
                                <th>아이디</th>
                                <td><input type="text" class="form-control" name="userId"></td>
                            </tr>
                            <tr>
                                <th>비밀번호</th>
                                <td><input type="password" class="form-control" name="password"></td>
                            </tr>
                            <tr>
                                <th>비밀번호 확인</th>
                                <td><input type="password" class="form-control" name="passwordConfirm"></td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td><input type="text" class="form-control" name="phone"></td>
                            </tr>
                            <tr>
                                <th>핸드폰번호</th>
                                <td><input type="text" class="form-control" name="mobile"></td>
                            </tr>
                            <tr>
                                <th>이메일</th>
                                <td><input type="text" class="form-control" name="email"></td>
                            </tr>
                            <tr>
                                <th>구분</th>
                                <td>
                                    <select class="form-control" name="grade">
                                        <option value="">선택</option>
                                        <option value="CU">업체사용자</option>
                                        <option value="CA">업체관리자</option>
                                        <option value="A">관리자</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
					</div>
					<div class="box-footer">
                        <button type="button" class="btn btn-primary" id="btnAddConfirm">등록</button>
                        <button class="btn btn-primary hidden" id="btnAddConfirmLoading" type="button" disabled>
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
                        </button>
                        <button type="button" class="btn btn-warning hidden" id="btnEditConfirm">정보 수정</button>
                        <button class="btn btn-warning hidden" id="btnEditConfirmLoading" type="button" disabled>
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
                        </button>
                        <button type="button" class="btn btn-warning hidden" id="btnEditPasswordConfirm">비밀번호 수정</button>
                        <button class="btn btn-warning hidden" id="btnEditPasswordConfirmLoading" type="button" disabled>
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
                        </button>
                        <div class="pull-right">
                            <button type="button" class="btn btn-default" id="btnCancel">취소</button>
                        </div>
                    </div>
				</form>
            </div>
            <!--// 오른쪽 -->

        </div>
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<%@include file="../layout/contents/footer.jsp" %>
<%@include file="../layout/contents/bottom.jsp" %>
<%@include file="../layout/contents/script.jsp" %>

<script>
    let userIdx;
    let sideWork = 'add';

    // 대학/학부 목록
    function collegeList(collegeIdx, departmentIdx) {
        return new Promise(function(resolve, reject) {
            $.ajax({
                url: '<c:url value="/college/list"/>',
                type: 'GET',
                data: {
                },
                success: function (res) {
                    let options = '<option value="">선택</option>';
                    $.each(res.data, function (index, item) {
                        options += '<option value="' + item.collegeIdx + '">' + item.collegeName + '</option>';
                    });
                    $('#form select[name=collegeIdx]').empty().append(options).val(collegeIdx);
                    resolve(collegeIdx, departmentIdx);
                }
            });
        });
    }

    // 부서/학과 목록
    function departmentList(collegeIdx, departmentIdx) {
        return new Promise(function(resolve, reject) {
            $.ajax({
                url: '<c:url value="/department/list"/>',
                type: 'GET',
                data: {
                    'collegeIdx': collegeIdx
                },
                success: function (res) {
                    let options = '<option value="">선택</option>';
                    $.each(res.data, function (index, item) {
                        options += '<option value="' + item.departmentIdx + '">' + item.departmentName + '</option>';
                    });
                    $('#form select[name=departmentIdx]').empty().append(options).val(departmentIdx);
                    resolve();
                }
            });
        });
    }

    // 수정항목 정보
    function viewEditData(data) {
        // 보김, 숨김
        $('#useDelete').addClass('hidden');
        $('#viewBox').removeClass('hidden');
        $('#formBox').addClass('hidden');

        // 보기
        $('#collegeName').text(data.collegeName);
        $('#departmentName').text(data.departmentName);
        $('#userName').text(data.userName);
        $('#userId').text(data.userId);
        $('#userPhone').text(data.userPhone);
        $('#email').text(data.email);

        // 구분
        if (data.grade == 'P') {
            $('#grade').text('교수');
        } else if (data.grade == 'S') {
            $('#grade').text('학생');
        } else if (data.grade == 'H') {
            $('#grade').text('조교');
        } else if (data.grade == 'A') {
            $('#grade').text('관리자');
        }

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
        $('#form input[name=userName]').val(data.userName);
        $('#form input[name=userId]').val(data.userId);
        $('#form input[name=userPhone]').val(data.userPhone);
        $('#form input[name=email]').val(data.email);
        $('#form select[name=grade]').val(data.grade);
        $('#form select[name=useYN]').val(data.useYN);
        $('#form select[name=deleteYN]').val(data.deleteYN);

        collegeList(data.collegeIdx, data.departmentIdx)    // 대학/학부 목록
            .then(departmentList(data.collegeIdx, data.departmentIdx)); // 부서/학과 목록
    }

    // 대학/학부 변경할 경우
    $('#form select[name=collegeIdx]').on('change', function() {
        let collegeIdx = $(this).val();
        departmentList(collegeIdx, '');
    });
</script>

<%@include file="professor.jsp" %>
<%@include file="student.jsp" %>
<%@include file="assistant.jsp" %>
<%@include file="admin.jsp" %>
<%@include file="create.jsp" %>
<%@include file="update.jsp" %>
<%@include file="password.jsp" %>
<%@include file="delete.jsp" %>

</body>
</html>
