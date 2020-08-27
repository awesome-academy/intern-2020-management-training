const CLOSER_TIME = 1500

export function deleteSubject() {
  $('body').on('click', '#subjects-tbl .delete-subject-item', function(event) {
    event.preventDefault();
    let url = this.getAttribute('href');
    Swal.fire({
      title: I18n.t("js.trainer.subject.d_confirm_title"),
      text: I18n.t("js.trainer.subject.d_confirm_text"),
      showCancelButton: true,
      icon: 'warning',
      confirmButtonText: I18n.t("js.trainer.subject.d_btn_confirm"),
      cancelButtonText: I18n.t("js.trainer.subject.d_btn_cancel")
    }).then((result) => {
      if (result.value) {
        $.ajax({
          url: url,
          type: 'delete',
          success: function(response) {
            if (response.success) {
              customAlert('sc');
              let id = response.room_id;
              $('#row-' + id).remove();
              reloadPage();
            } else {
              customAlert('err');
            }
          },
          error: function(error) {
            customAlert('err');
          }
        });
      }
    })
  });
}

export function customAlert(type) {
  let prefix = type
  Swal.fire({
    title: I18n.t("js.trainer.subject.res." + prefix + "_title"),
    text: I18n.t("js.trainer.subject.res." + prefix + "_text"),
    icon: I18n.t("js.trainer.subject.res." + prefix + "_class"),
    timer: CLOSER_TIME
  });
}

export function reloadPage() {
  let element = $('#paginator .page-item.active')[0];
  let current_page = parseInt(element.firstElementChild.text);
  let number_records = $('#subjects-tbl #subjects-tbody').childElementCount;
  let next_page = element.nextElementSibling
  if (next_page == null) {

  } else {
    $(element).trigger('click')
  }
}
