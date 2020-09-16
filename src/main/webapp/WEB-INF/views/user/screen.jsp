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
                        <div class="box-tools"></div>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered table-hover" id="userTable">
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
            	     
           		<div class="box box-primary">   
	            	<div class="box-header with-border">
	                    <h3 class="box-title">사용자 정보</h3>
	                    <div class="box-tools text-danger">*은 필수입력</div>
	                </div>
	                <form id="form" class="form-horizontal">
		                <div class="box-body">	            
		                	<div class="form-group">
		                		<label class="col-sm-3 control-label">
		                			<span class="text-danger">*</span> 구분
		                		</label>
		                		<div class="col-sm-9">
		                			<select class="form-control" name="grade">
                                        <option value="">선택</option>
                                        <option value="CU" selected>업체사용자</option>
                                        <option value="CA">업체관리자</option>
                                        <option value="A">관리자</option>
                                    </select>
		                		</div>
		                	</div>        
		                	<div class="form-group">
		                		<label class="col-sm-3 control-label">
		                			<span class="text-danger">*</span> 부서
		                		</label>
		                		<div class="col-sm-9">
		                			<select class="form-control" name="departmentIdx">
                                        <option value="">선택</option>
                                        <c:forEach var="departmentList" items="${departmentList}">
                                            <option value="${departmentList.departmentIdx}">${departmentList.departmentName}</option>
                                        </c:forEach>
                                    </select>
		                		</div>
		                	</div> 
		                	<div class="form-group">
		                		<label class="col-sm-3 control-label">
		                			<span class="text-danger">*</span> 이름
		                		</label>
		                		<div class="col-sm-9">
		                			<input type="text" class="form-control" name="userName">
		                		</div>
		                	</div> 
		                	<div class="form-group form-group-user-id">
		                		<label class="col-sm-3 control-label">
		                			<span class="text-danger">*</span> 아이디
		                		</label>
		                		<div class="col-sm-9 form-control-user-id">
		                			<input type="text" class="form-control" name="userId">
		                			<span class="help-error help-block hide">아이디가 존재합니다.</span>
		                			<span class="help-success help-block hide">사용가능한 아이디입니다.</span>
		                		</div>
		                	</div> 
		                	<div class="form-group">
		                		<label class="col-sm-3 control-label">
		                			<span class="text-danger">*</span> 비밀번호
		                		</label>
		                		<div class="col-sm-9">
		                			<input type="password" class="form-control" name="password">
		                		</div>
		                	</div> 
		                	<div class="form-group">
		                		<label class="col-sm-3 control-label">
		                			<span class="text-danger">*</span> 비밀번호 확인
		                		</label>
		                		<div class="col-sm-9">
		                			<input type="password" class="form-control" name="passwordConfirm">
		                		</div>
		                	</div> 
		                	<div class="form-group">
		                		<label class="col-sm-3 control-label">
		                			전화번호
		                		</label>
		                		<div class="col-sm-9">
		                			<input type="text" class="form-control" name="phone">
		                		</div>
		                	</div> 
		                	<div class="form-group">
		                		<label class="col-sm-3 control-label">
		                			<span class="text-danger">*</span> 핸드폰번호
		                		</label>
		                		<div class="col-sm-9">
		                			<input type="text" class="form-control" name="mobile">
		                		</div>
		                	</div> 
		                	<div class="form-group">
		                		<label class="col-sm-3 control-label">
		                			이메일
		                		</label>
		                		<div class="col-sm-9">
		                			<input type="text" class="form-control" name="email">
		                		</div>
		                	</div> 
						</div>
					</form>
					<div class="box-footer">
						<button type="button" class="btn btn-success" id="btnCreate">신규등록</button>
						<div class="pull-right">
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
						</div>
                    </div>
				</div>
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
<%@include file="user_list.jsp" %>
<%@include file="user_create.jsp" %>
<%@include file="user_update.jsp" %>
<%@include file="user_password.jsp" %>
<%@include file="user_delete.jsp" %>

<script>
let userId;

f_clear();

// 초기화
function f_clear() {
	$('#form').each(function(){ this.reset(); });
	$('#btnAddConfirm').removeClass('hidden');  // 등록버튼
	$('#btnEditConfirm').addClass('hidden');    // 수정버튼
	$('#btnDelete').addClass('hidden');    		// 수정버튼	
}

//등록폼
$('#btnCreate').on('click', function() {
	f_clear();    
});
</script>

</body>
</html>
