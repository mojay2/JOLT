<div class="mx-auto alert alert-primary alert-dismissible fade show text-center position-absolute top-0 start-50 translate-middle-x" role="alert" style="max-width: 500px;">
    <%=session.getAttribute("feedback-message")%>
    <button type="btn" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times</span>
    </button>
    <%session.removeAttribute("feedback-message");%>
</div>